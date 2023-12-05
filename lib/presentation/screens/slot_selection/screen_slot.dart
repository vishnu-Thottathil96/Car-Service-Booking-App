import 'package:flutter/material.dart';
import 'package:motox/data/models/model_time_slot.dart';
import 'package:motox/presentation/screens/service_description/service_description.dart';
import 'package:motox/presentation/screens/slot_selection/widgets/build_legend.dart';
import 'package:motox/presentation/screens/slot_selection/widgets/calendar_section.dart';
import 'package:motox/presentation/screens/slot_selection/widgets/slot_grid.dart';
import 'package:motox/presentation/screens/slot_selection/widgets/top_bar.dart';
import 'package:motox/presentation/widgets/large_button.dart';
import 'package:motox/utils/colors/colors.dart';
import 'package:motox/utils/constants/space.dart';
import 'package:motox/utils/dialouges/dialouges.dart';

class SlotSelectionPage extends StatefulWidget {
  final String serviceType;
  const SlotSelectionPage({super.key, required this.serviceType});

  @override
  State<SlotSelectionPage> createState() => _SlotSelectionPageState();
}

class _SlotSelectionPageState extends State<SlotSelectionPage> {
  @override
  void initState() {
    checkSlotAvailability(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime?> dates = [DateTime.now()];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildTopBar(context),
                vertical20,
                CalenderWidget(dates: dates),
                buildLegend(),
                vertical30,
                SlotGrid(),
                vertical30,
                LargeButton(
                  context: context,
                  onTap: () {
                    String formattedDate = selectedDateTime.value
                        .toLocal()
                        .toIso8601String()
                        .split('T')
                        .first;
                    final slot = SlotDataModel(
                        dateTime: formattedDate,
                        isBooked: true,
                        time: selectedTime);
                    slot.time.isNotEmpty
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ServiceDescription(
                                  slot: slot, serviceType: widget.serviceType),
                            ),
                          )
                        : Dialogs.showSnackbar(
                            context, 'Select a slot', redColor);
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
