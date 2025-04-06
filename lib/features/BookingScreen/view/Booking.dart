import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

@RoutePage()
class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final ScrollController _timeScrollController = ScrollController();

  static const TimeOfDay openingTime = TimeOfDay(hour: 9, minute: 0);
  static const TimeOfDay closingTime = TimeOfDay(hour: 21, minute: 0);
  static const int timeSlotIntervalMinutes = 20;

  List<TimeOfDay> _generateTimeSlots() {
    List<TimeOfDay> timeSlots = [];
    TimeOfDay currentTime = openingTime;
    while (currentTime.hour < closingTime.hour ||
        (currentTime.hour == closingTime.hour &&
            currentTime.minute <= closingTime.minute)) {
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
      final format = DateFormat.Hm('ru'); // Русская локаль для времени
      return format.format(dt);
    } catch (e) {
      print("Error formatting time: $e");
      return "Invalid Time";
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final timeSlots = _generateTimeSlots();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Запись на услугу'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Calendar Section
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TableCalendar(
                    locale: 'ru_RU',
                    // Русская локаль
                    firstDay: DateTime.now(),
                    lastDay: DateTime(2101),
                    focusedDay: _focusedDate,
                    selectedDayPredicate: (day) =>
                        isSameDay(_selectedDate, day),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDate = selectedDay;
                        _focusedDate = focusedDay;
                      });
                    },
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: theme.primaryColor.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: theme.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      defaultTextStyle: theme.textTheme.bodyMedium!,
                      weekendTextStyle: theme.textTheme.bodyMedium!.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: theme.textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      titleTextFormatter: (date, locale) =>
                          DateFormat.yMMMM(locale).format(date),
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: theme.textTheme.bodySmall!.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                      weekendStyle: theme.textTheme.bodySmall!.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Time Selection
              Text(
                'Выберите время',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
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
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? theme.primaryColor
                              : theme.colorScheme.surfaceContainer,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? theme.primaryColor
                                : theme.dividerColor.withOpacity(0.5),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            _formatTimeOfDay(timeSlot),
                            style: TextStyle(
                              color: isSelected
                                  ? theme.colorScheme.onPrimary
                                  : theme.colorScheme.onSurface,
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
              // Confirm Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    print('Selected Date: ${_selectedDate.toString()}');
                    print('Selected Time: ${_selectedTime.toString()}');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    foregroundColor: theme.colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Подтвердить'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
