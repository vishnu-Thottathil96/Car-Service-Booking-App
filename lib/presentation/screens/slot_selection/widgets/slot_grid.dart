// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motox/data/models/model_time_slot.dart';
import 'package:motox/utils/colors/colors.dart';
import 'package:motox/utils/constants/text_styles.dart';
import 'package:motox/utils/dialouges/dialouges.dart';

String bookedTime = '';
ValueNotifier<List<SlotItem>> isSlotsBookedNotifier = ValueNotifier([
  SlotItem(time: '09.00 AM'),
  SlotItem(time: '09.30 AM'),
  SlotItem(time: '10.00 AM'),
  SlotItem(time: '10.30 AM'),
  SlotItem(time: '11.00 AM'),
  SlotItem(time: '11.30 AM'),
  SlotItem(time: '12.00 PM'),
  SlotItem(time: '12.30 PM'),
  SlotItem(time: '01.00 PM'),
  SlotItem(time: '01.30 PM'),
  SlotItem(time: '02.00 PM'),
  SlotItem(time: '02.30 PM'),
]);
String selectedTime = '';

class SlotGrid extends StatelessWidget with ChangeNotifier {
  SlotGrid({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedIndex = -1;
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 5),
      child: ValueListenableBuilder(
          valueListenable: isSlotsBookedNotifier,
          builder: (context, value, _) {
            return GridView.builder(
              itemCount: value.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 2,
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final slot = value[index];
                final isBooked = slot.isBooked;
                return InkWell(
                  onTap: () {
                    if (!isBooked) {
                      // Allow selection only for slots that are not booked
                      if (selectedIndex == index) {
                        selectedIndex = -1;
                        selectedTime = slot.time;
                      } else {
                        selectedIndex = index;
                        selectedTime = slot.time;
                      }
                      isSlotsBookedNotifier.notifyListeners();
                    } else {
                      Dialogs.showAlert(context, 'Already booked',
                          'try to select another slot');
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: selectedIndex != index
                            ? null
                            : Border.all(color: blackColor, width: 2),
                        color: isBooked ? redColor : greenColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                        child: Text(
                      isSlotsBookedNotifier.value[index].time,
                      style: TextStyles.normalTextWhite,
                    )),
                  ),
                );
              },
            );
          }),
    );
  }
}

Future<void> checkSlotAvailability(DateTime dateTime) async {
  final slotsCollection = FirebaseFirestore.instance.collection('slots');
  String formattedDate = dateTime.toLocal().toIso8601String().split('T').first;
  for (var i in isSlotsBookedNotifier.value) {
    i.isBooked = false;
  }

  for (var slot in isSlotsBookedNotifier.value) {
    final slotTime = slot.time;

    final snapshot = await slotsCollection
        .where(
          'time',
          isEqualTo: slotTime,
        )
        .where('date', isEqualTo: formattedDate)
        .get();

    if (snapshot.docs.isNotEmpty) {
      slot.isBooked = true;
      isSlotsBookedNotifier.notifyListeners();
    } else {
      slot.isSelected = false;
      isSlotsBookedNotifier.notifyListeners();
    }
  }
}
