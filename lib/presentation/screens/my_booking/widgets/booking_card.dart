import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motox/data/models/booking_model/booking_model.dart';
import 'package:motox/data/models/model_car.dart';
import 'package:motox/data/repositories/user_repository.dart';
import 'package:motox/presentation/screens/job_card/job_card.dart';
import 'package:motox/utils/constants/space.dart';
import 'package:motox/utils/constants/text_styles.dart';

Widget buildBookingCard(
    int index, double height, BuildContext context, BookingModel bookingModel) {
  String carModelToPass = '';
  String carMakeToPass = '';
  String formattedDate =
      DateFormat('MMM dd yyyy').format(bookingModel.dateTime);
  // Use the licensePlate from the bookingModel to fetch car details
  Future<Car?> fetchCarData() async {
    Car? carToService = await UserRepository.getCarByLicensePlate(
        userId: bookingModel.userId, licensePlate: bookingModel.licensePlate);

    if (carToService != null) {
      return carToService;
    } else {
      return Car(
        make: 'Unknown',
        model: 'Unknown',
        year: '0',
        fuel: 'Unknown',
        licensePlate: 'Unknown',
      );
    }
  }

  return Material(
    elevation: 10,
    child: GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JobCardPage(
                bookingModel: bookingModel,
                formatedDate: formattedDate,
                carMake: carMakeToPass,
                carModel: carModelToPass,
              ),
            ));
      },
      child: Container(
        color: const Color.fromARGB(255, 249, 253, 255),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (formattedDate),
                style: TextStyles.subheadingBlack,
              ),
              vertical20,

              ///
              FutureBuilder<Car?>(
                future: fetchCarData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('Fetching...');
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    if (snapshot.data != null) {
                      final carMake = snapshot.data!.make;
                      final carModel = snapshot.data!.model;
                      carMakeToPass = carMake;
                      carModelToPass = carModel;
                      return Text('Vehicle: $carMake $carModel');
                    } else {
                      return const Text('Unknown');
                    }
                  }
                },
              ),

              ///
              vertical20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Service: ${bookingModel.serviceType}'),
                  const SizedBox(width: 20),
                  Text('Status:   ${bookingModel.serviceStatus}'),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
