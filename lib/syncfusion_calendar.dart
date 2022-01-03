import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class syncfusion_calendar extends StatefulWidget {
  const syncfusion_calendar({Key key}) : super(key: key);

  @override
  _syncfusion_calendarState createState() => _syncfusion_calendarState();
}

class _syncfusion_calendarState extends State<syncfusion_calendar> {
  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.month,
      firstDayOfWeek: 1,
      //initialDisplayDate: DateTime(2021, 03, 01, 08, 30),
      //initialSelectedDate: DateTime(2021, 03, 01, 08, 30),
      dataSource: MeetingDataSource(getAppointments()),
    );
  }
}

List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));

  meetings.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'principal meeting',
      color: Colors.blue,
      recurrenceRule: 'FREQ=DAILY;COUNT=10',
      isAllDay: false));

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
