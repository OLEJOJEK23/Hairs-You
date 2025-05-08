import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hairs_and_you/widgets/CalendarWidget.dart';
import 'package:intl/intl.dart';

import '../../../blocks/booking_block/booking_bloc.dart';

@RoutePage()
class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();
  TimeOfDay? _selectedTime;
  final ScrollController _timeScrollController = ScrollController();
  static const int timeSlotIntervalMinutes = 20;

  @override
  void initState() {
    _selectNearestTimeSlot();
    super.initState();
  }

  @override
  void dispose() {
    _timeScrollController.dispose();
    super.dispose();
  }

  List<TimeOfDay> _generateTimeSlots(TimeOfDay? startTime, TimeOfDay? endTime) {
    if (startTime == null || endTime == null) {
      return []; // Пустой список, если время не задано
    }
    List<TimeOfDay> timeSlots = [];
    TimeOfDay currentTime = startTime;
    while (currentTime.hour < endTime.hour ||
        (currentTime.hour == endTime.hour &&
            currentTime.minute <= endTime.minute)) {
      timeSlots.add(currentTime);
      currentTime =
          _addMinutesToTimeOfDay(currentTime, timeSlotIntervalMinutes);
    }
    return timeSlots;
  }

  TimeOfDay _addMinutesToTimeOfDay(TimeOfDay time, int minutes) {
    int totalMinutes = time.hour * 60 + time.minute + minutes;
    return TimeOfDay(hour: totalMinutes ~/ 60, minute: totalMinutes % 60);
  }

  String _formatTimeOfDay(TimeOfDay timeOfDay) {
    try {
      final now = DateTime.now();
      final dt = DateTime(
          now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
      final format = DateFormat.Hm('ru'); // Русская локализация для времени
      return format.format(dt);
    } catch (e) {
      print("Error formatting time: $e");
      return "Invalid Time";
    }
  }

  DateTime _combineDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  void _selectNearestTimeSlot() {
    final state = context.read<BookingBloc>().state;
    final timeSlots =
        _generateTimeSlots(state.salon?.startTime, state.salon?.endTime);

    if (timeSlots.isEmpty) {
      setState(() {
        _selectedTime = null;
      });
      return;
    }

    final now = TimeOfDay.now();
    final isToday = _selectedDate.year == DateTime.now().year &&
        _selectedDate.month == DateTime.now().month &&
        _selectedDate.day == DateTime.now().day;

    TimeOfDay? nearestSlot;
    if (isToday) {
      int nowMinutes = now.hour * 60 + now.minute;
      for (var slot in timeSlots) {
        int slotMinutes = slot.hour * 60 + slot.minute;
        if (slotMinutes >= nowMinutes) {
          nearestSlot = slot;

          break;
        }
      }
    } else {
      nearestSlot = timeSlots.first;
    }

    setState(() {
      _selectedTime = nearestSlot;
    });
  }

  void _scrollToSelectedTimeSlot(List<TimeOfDay> timeSlots) {
    if (_selectedTime == null || timeSlots.isEmpty) {
      return;
    }

    final index = timeSlots.indexOf(_selectedTime!);
    if (index == -1) {
      return;
    }

    // Приблизительная ширина элемента: padding (16*2) + margin (6*2) + текст (~40)
    const double estimatedItemWidth = 32 + 12 + 40; // 84 пикселя
    final offset = index * estimatedItemWidth;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_timeScrollController.hasClients) {
        _timeScrollController.animateTo(
          offset,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<BookingBloc, BookingState>(builder: (context, state) {
      final timeSlots =
          _generateTimeSlots(state.salon?.startTime, state.salon?.endTime);
      return Scaffold(
        appBar: AppBar(
          title: const Text('Запись на услугу'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: theme.scaffoldBackgroundColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CalendarWidget(
                  selectedDate: _selectedDate,
                  focusedDate: _focusedDate,
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(
                      () {
                        _selectedDate = selectedDay;
                        _focusedDate = focusedDay;
                      },
                    );
                    _selectNearestTimeSlot();
                    _scrollToSelectedTimeSlot(timeSlots);
                  },
                ),
                const SizedBox(height: 24),
                // Time Selection
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    'Выберите время',
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    controller: _timeScrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: timeSlots.length,
                    itemBuilder: (context, index) {
                      final timeSlot = timeSlots[index];
                      final isSelected = timeSlot == _selectedTime;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTime = timeSlot;
                          });
                          _scrollToSelectedTimeSlot(timeSlots);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? theme.primaryColor
                                : theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? theme.primaryColor
                                  : theme.dividerColor.withValues(alpha: 0.5),
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              _formatTimeOfDay(timeSlot),
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.grey,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                // Confirm Button
                Center(
                  child: ElevatedButton(
                    onPressed: _selectedTime == null
                        ? null
                        : () {
                            context.read<BookingBloc>().add(
                                  SelectDateTime(
                                    _combineDateAndTime(
                                        _selectedDate, _selectedTime!),
                                  ),
                                );
                            context.router.pushNamed('/masters');
                          },
                    style: theme.elevatedButtonTheme.style?.copyWith(
                      padding: const WidgetStatePropertyAll(
                        EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                      ),
                    ),
                    child: const Text('Подтвердить'),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                // Добавлен отступ снизу для симметрии
              ],
            ),
          ),
        ),
      );
    });
  }
}
