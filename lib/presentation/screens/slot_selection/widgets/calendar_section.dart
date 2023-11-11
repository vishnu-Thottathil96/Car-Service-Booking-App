import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:motox/presentation/screens/slot_selection/widgets/slot_grid.dart';
import 'package:motox/utils/dialouges/dialouges.dart';

ValueNotifier<DateTime> selectedDateTime = ValueNotifier(DateTime.now());

class CalenderWidget extends StatefulWidget {
  const CalenderWidget({super.key, required this.dates});
  final List<DateTime?> dates;

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  @override
  Widget build(BuildContext context) {
    return CalendarDatePicker2(
      config: CalendarDatePicker2Config(),
      value: widget.dates,
      onValueChanged: (dates) {
        final selectedDate = dates[0]!;
        final currentDate = DateTime.now();
        int differenceInDays = selectedDate.difference(currentDate).inDays;
        if (differenceInDays >= 0) {
          selectedDateTime.value = selectedDate;
          checkSlotAvailability(selectedDate);
        } else {
          Dialogs.showAlert(
            context,
            'Incorrect date!',
            'Selected date is invalid. Please pick the current or future date.',
          );
        }
      },
    );
  }
}
