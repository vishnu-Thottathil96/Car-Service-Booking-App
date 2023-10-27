import 'dart:developer';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:motox/presentation/widgets/large_button.dart';
import 'package:motox/utils/colors/colors.dart';
import 'package:motox/utils/constants/space.dart';
import 'package:motox/utils/constants/text_styles.dart';
import 'package:motox/utils/design_assets/design_assets.dart';
import 'package:motox/utils/dialouges/dialouges.dart';

class SlotSelectionPage extends StatelessWidget {
  const SlotSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    List<DateTime?> _dates = [
      DateTime.now(),
    ];
    DateTime selectedSlot = DateTime.now();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                    Text(
                      'Select date and time',
                      style: TextStyles.mainHeadingBlack,
                    )
                  ],
                ),
                vertical20,
                CalendarDatePicker2(
                  config: CalendarDatePicker2Config(),
                  value: _dates,
                  onValueChanged: (dates) {
                    final selectedDate = dates[0]!;
                    final currentDate = DateTime.now();
                    int differenceInDays =
                        selectedDate.difference(currentDate).inDays;
                    if (differenceInDays >= 0) {
                      _dates = dates;
                      log(_dates.toString());
                    } else {
                      Dialogs.showAlert(context, 'Incorrect date!',
                          'Selected date is invalid. Please pick current or future date.');

                      _dates[0] = currentDate;
                    }
                  },
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 9.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Slots Available',
                          style: TextStyles.subheadingGrey,
                        ),
                        CircleAvatar(
                          radius: 8,
                          backgroundColor: redColor,
                        ),
                        Text('Occupied'),
                        CircleAvatar(
                          radius: 8,
                          backgroundColor: greenColor,
                        ),
                        Text('Free'),
                      ],
                    ),
                  ),
                ),
                vertical20,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 2,
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      final slotItem = periodicServiceSlotes[index];
                      // Determine the background color based on the slot state
                      Color backgroundColor;
                      if (slotItem.isSelected) {
                        backgroundColor =
                            Colors.blue; // Highlight the selected slot
                      } else if (slotItem.isBooked) {
                        backgroundColor = Colors.red; // Already booked slot
                      } else {
                        backgroundColor = Colors.green; // Free slot
                      }
                      return GestureDetector(
                        onTap: () {
                          // Deselect all slots

                          periodicServiceSlotes.forEach((item) {
                            item.isSelected = false;
                          });
                          // Toggle the selection state of the current slot
                          !slotItem.isBooked
                              ? slotItem.isSelected = !slotItem.isSelected
                              : slotItem.isSelected = false;
                          slotItem.isSelected
                              ? log(slotItem.time.toString())
                              : Dialogs.showAlert(context, 'Already Booked !',
                                  'The slot is already booked');
                        },
                        child: Container(
                          height: 100,
                          color:
                              backgroundColor, // Use the determined background color
                          child: Center(
                            child: Text(
                              slotItem.time,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                vertical30,
                LargeButton(
                  context: context,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Add Extra Service',
                                  style: TextStyles.subheadingBlack,
                                ),
                                GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 1,
                                          crossAxisCount: 3,
                                          mainAxisSpacing: 20,
                                          crossAxisSpacing: 20),
                                  itemCount: typesOfServices.length - 1,
                                  itemBuilder: (context, index) {
                                    final serviceItem =
                                        typesOfServices[index + 1];
                                    final heading =
                                        typesOfServices[index + 1].heading;
                                    final images =
                                        typesOfServices[index + 1].imagePath;
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            serviceItem.isSelected =
                                                !serviceItem.isSelected;
                                          },
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.asset(
                                                  images.toString(),
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              serviceItem.isSelected
                                                  ? Positioned.fill(
                                                      child: Container(
                                                        color: Colors.blue
                                                            .withOpacity(0.5),
                                                        child: Icon(
                                                          Icons.check_box,
                                                          color: greenColor,
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox()
                                            ],
                                          ),
                                        ),
                                        Text(
                                          heading.toString(),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                LargeButton(
                                    context: context,
                                    onTap: () {},
                                    text: 'Continue')
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  text: 'Continue',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
