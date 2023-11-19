import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motox/data/models/model_car.dart';
import 'package:motox/data/repositories/user_repository.dart';
import 'package:motox/utils/car_datas/cars_data.dart';
import 'package:motox/utils/colors/colors.dart';
import 'package:motox/utils/constants/screen_size.dart';
import 'package:motox/utils/constants/space.dart';
import 'package:motox/utils/constants/text_styles.dart';

class CarDetailsPage extends StatelessWidget {
  final Car car;

  CarDetailsPage({
    required this.car,
  });

  @override
  Widget build(BuildContext context) {
    String currentUid = FirebaseAuth.instance.currentUser!.uid;
    Future<String> fetchUserName() async {
      String userName = await UserRepository.getCurrentUserName(currentUid);
      return userName;
    }

    String brandName = car.make;
    String modelName = car.model;
    double height = MyScreenSize.screenHeight(context);
    double width = MyScreenSize.screenWidth(context);

    String imagePath = '';
    for (Map<String, dynamic> brandData in carData) {
      if (brandData.containsKey(brandName)) {
        final brandInfo = brandData[brandName];
        if (brandInfo is Map<String, dynamic> &&
            brandInfo.containsKey("models")) {
          final models = brandInfo["models"];
          if (models is Map<String, dynamic> && models.containsKey(modelName)) {
            imagePath = models[modelName];
            break;
          }
        }
      }
    }

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        foregroundColor: blackColor,
        title: Text(
          'Car Details',
          style: TextStyles.subheadingBlack,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          vertical20,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Image.network(
              imagePath,
              width: width / 1.1,
              height: height / 2.5,
            ),
          ),
          Text(
            '${car.make} ${car.model}',
            style: TextStyles.mainHeadingBlack,
          ),
          vertical20,
          Container(
            width: width / 1.1,
            color: Color.fromARGB(68, 231, 231, 231),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text(
                    'Other Details',
                    style: TextStyles.subheadingGrey,
                  )),
                  vertical20,
                  Text('Fuel: ${car.fuel}'),
                  vertical20,
                  Text('License Plate: ${car.licensePlate}'),
                  vertical20,
                  Text('Manufactured Year: ${car.year}'),
                  vertical20,
                  FutureBuilder<String>(
                    future: fetchUserName(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text('Fetching...');
                      } else if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      } else {
                        if (snapshot.data != null) {
                          final name = snapshot.data;

                          return Text('Owner Name: $name');
                        } else {
                          return const Text('Unknown');
                        }
                      }
                    },
                  ),
                  // Text(
                  //     'Owner : ${UserRepository.getCurrentUserName(FirebaseAuth.instance.currentUser!.uid)}'),
                  vertical30
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
