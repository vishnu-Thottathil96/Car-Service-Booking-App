import 'package:flutter/material.dart';
import 'package:motox/data/models/booking_model/booking_model.dart';
import 'package:motox/utils/constants/screen_size.dart';
import 'package:motox/utils/constants/space.dart';
import 'package:motox/utils/constants/text_styles.dart';

class JobCardPage extends StatelessWidget {
  const JobCardPage(
      {super.key,
      required this.bookingModel,
      required this.formatedDate,
      required this.carMake,
      required this.carModel});
  final BookingModel bookingModel;
  final String formatedDate;
  final String carMake;
  final String carModel;
  @override
  Widget build(BuildContext context) {
    double height = MyScreenSize.screenHeight(context);
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            vertical20,
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Text(
                    'Service Tracking',
                    textAlign: TextAlign.center,
                    style: TextStyles.mainHeadingBlack,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Material(
                elevation: 10,
                child: Container(
                  color: const Color.fromARGB(255, 249, 253, 255),
                  width: double.infinity,
                  height: height / 2,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Booking Date :   $formatedDate',
                          style: TextStyles.normalTextBlack,
                        ),
                        Text(
                          'Status :   ${bookingModel.serviceStatus}',
                          style: TextStyles.normalTextBlack,
                        ),
                        Text(
                          'Car :   $carMake $carModel',
                          style: TextStyles.normalTextBlack,
                        ),
                        Text(
                          'Service Type :   ${bookingModel.serviceType}',
                          style: TextStyles.normalTextBlack,
                        ),
                        Text(
                          'Payment :   Not paid',
                          style: TextStyles.normalTextBlack,
                        ),
                        bookingModel.estimatedTime == null
                            ? const Text('Estimated Time :  Will be generated ')
                            : Text(
                                bookingModel.estimatedTime.toString(),
                              )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
