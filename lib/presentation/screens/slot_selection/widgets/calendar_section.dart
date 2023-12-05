// import 'package:calendar_date_picker2/calendar_date_picker2.dart';
// import 'package:flutter/material.dart';
// import 'package:motox/presentation/screens/slot_selection/widgets/slot_grid.dart';
// import 'package:motox/utils/dialouges/dialouges.dart';

// ValueNotifier<DateTime> selectedDateTime = ValueNotifier(DateTime.now());

// class CalenderWidget extends StatefulWidget {
//   const CalenderWidget({super.key, required this.dates});
//   final List<DateTime?> dates;

//   @override
//   State<CalenderWidget> createState() => _CalenderWidgetState();
// }

// class _CalenderWidgetState extends State<CalenderWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return CalendarDatePicker2(
//       config: CalendarDatePicker2Config(),
//       value: widget.dates,
//       onValueChanged: (dates) {
//         final selectedDate = dates[0]!;
//         final currentDate = DateTime.now();
//         int differenceInDays = selectedDate.difference(currentDate).inDays;
//         if (differenceInDays >= 0) {
//           selectedDateTime.value = selectedDate;
//           checkSlotAvailability(selectedDate);
//         } else {
//           Dialogs.showAlert(
//             context,
//             'Incorrect date!',
//             'Selected date is invalid. Please pick the current or future date.',
//           );
//         }
//       },
//     );
//   }
// }
////////////////////////////
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:motox/presentation/screens/slot_selection/widgets/slot_grid.dart';
import 'package:motox/utils/dialouges/dialouges.dart';

ValueNotifier<DateTime> selectedDateTime = ValueNotifier(DateTime.now());
DateTime currentDate = DateTime.now();
DateTime lastDate = DateTime.now().add(const Duration(days: 30));

class CalenderWidget extends StatefulWidget {
  const CalenderWidget({Key? key, required this.dates}) : super(key: key);
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
        // ignore: unnecessary_null_comparison
        if (dates != null && dates.isNotEmpty) {
          final selectedDate = dates[0]!;
          int differenceInDays = selectedDate.difference(currentDate).inDays;

          if (differenceInDays < 0) {
            Dialogs.showAlert(
              context,
              'Incorrect date!',
              'Selected date is invalid. Please pick the current or future date.',
            );
          } else if (selectedDate.isAfter(lastDate)) {
            Dialogs.showAlert(
              context,
              'Incorrect date!',
              'Please pick a date within the next 30 days.',
            );
          } else {
            selectedDateTime.value = selectedDate;
            checkSlotAvailability(selectedDate);
          }
        }
      },
    );
  }
}
