import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class datepicker extends StatefulWidget {
  const datepicker({Key key}) : super(key: key);

  @override
  _datepickerState createState() => _datepickerState();
}

class _datepickerState extends State<datepicker> {
  DateRangePickerController _datePickerController = DateRangePickerController();

  @override
  Widget build(BuildContext context) {
    return SfDateRangePicker(
      view: DateRangePickerView.month,
      monthViewSettings: DateRangePickerMonthViewSettings(firstDayOfWeek: 6),
      selectionMode: DateRangePickerSelectionMode.multiRange,
      //onSelectionChanged: _onSelectionChanged,
      showActionButtons: true,
      controller: _datePickerController,
      onSubmit: (Object val) {
        print(val);
      },
      onCancel: () {
        _datePickerController.selectedRanges = null;
      },
    );
  }

  // void _onSelectionChanged(
  //     DateRangePickerSelectionChangedArgs dateRangePickerSelectionChangedArgs) {
  //   print(dateRangePickerSelectionChangedArgs.value);
  // }
}
