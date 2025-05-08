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
  List<TimeOfDay> _timeSlots = [];
  final ScrollController _timeScrollController = ScrollController();

  // Константы
  static const int _timeSlotIntervalMinutes = 20;
  static const double _estimatedItemWidth = 84;

  @override
  void initState() {
    super.initState();
    _updateTimeSlotsAndSelectNearest();
  }

  @override
  void dispose() {
    _timeScrollController.dispose();
    super.dispose();
  }

  /// Генерирует список временных слотов
  List<TimeOfDay> _generateTimeSlots(TimeOfDay? startTime, TimeOfDay? endTime) {
    if (startTime == null || endTime == null) {
      return [];
    }
    final timeSlots = <TimeOfDay>[];
    TimeOfDay currentTime = startTime;
    int startMinutes = startTime.hour * 60 + startTime.minute;
    int endMinutes = endTime.hour * 60 + endTime.minute;
    while (startMinutes <= endMinutes) {
      timeSlots.add(currentTime);
      currentTime =
          _addMinutesToTimeOfDay(currentTime, _timeSlotIntervalMinutes);
      startMinutes += _timeSlotIntervalMinutes;
    }
    return timeSlots;
  }

  /// Добавляет минуты к TimeOfDay
  TimeOfDay _addMinutesToTimeOfDay(TimeOfDay time, int minutes) {
    int totalMinutes = time.hour * 60 + time.minute + minutes;
    return TimeOfDay(hour: totalMinutes ~/ 60, minute: totalMinutes % 60);
  }

  /// Форматирует TimeOfDay в строку
  String _formatTimeOfDay(TimeOfDay timeOfDay) {
    try {
      final now = DateTime.now();
      final dt = DateTime(
          now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
      final format = DateFormat.Hm('ru');
      return format.format(dt);
    } catch (e) {
      return "Invalid Time";
    }
  }

  /// Объединяет дату и время в DateTime
  DateTime _combineDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  /// Обновляет timeSlots и выбирает ближайший слот
  void _updateTimeSlotsAndSelectNearest() {
    final state = context.read<BookingBloc>().state;
    final newTimeSlots =
        _generateTimeSlots(state.salon?.startTime, state.salon?.endTime);

    setState(() {
      _timeSlots = newTimeSlots;
      _selectedTime = _findNearestTimeSlot(newTimeSlots);
    });

    if (_selectedTime != null) {
      _scrollToSelectedTimeSlot();
    }
  }

  /// Находит ближайший слот >= текущего времени
  TimeOfDay? _findNearestTimeSlot(List<TimeOfDay> timeSlots) {
    if (timeSlots.isEmpty) {
      return null;
    }

    final now = TimeOfDay.now();
    final isToday = _selectedDate.year == DateTime.now().year &&
        _selectedDate.month == DateTime.now().month &&
        _selectedDate.day == DateTime.now().day;

    if (!isToday) {
      return timeSlots.first;
    }

    int nowMinutes = now.hour * 60 + now.minute;
    for (var slot in timeSlots) {
      int slotMinutes = slot.hour * 60 + slot.minute;
      if (slotMinutes >= nowMinutes) {
        return slot;
      }
    }
    return null;
  }

  /// Прокручивает список к выбранному слоту
  void _scrollToSelectedTimeSlot() {
    if (_selectedTime == null || _timeSlots.isEmpty) {
      return;
    }

    final index = _timeSlots.indexOf(_selectedTime!);
    if (index == -1) {
      return;
    }

    final offset = index * _estimatedItemWidth;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_timeScrollController.hasClients) {
        _timeScrollController.animateTo(
          offset,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                  setState(() {
                    _selectedDate = selectedDay;
                    _focusedDate = focusedDay;
                  });
                  _updateTimeSlotsAndSelectNearest();
                },
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  'Выберите время',
                  style: theme.textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 12),
              if (_timeSlots.isEmpty)
                const Center(child: Text('Нет доступных слотов'))
              else
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    controller: _timeScrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: _timeSlots.length,
                    itemBuilder: (context, index) {
                      final timeSlot = _timeSlots[index];
                      final isSelected = timeSlot == _selectedTime;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTime = timeSlot;
                          });
                          _scrollToSelectedTimeSlot();
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
              const SizedBox(height: 32),
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
                      EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                  ),
                  child: const Text('Подтвердить'),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
