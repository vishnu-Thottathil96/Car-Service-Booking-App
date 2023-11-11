import 'package:flutter/material.dart';
import 'package:motox/data/models/model_car.dart';
import 'package:motox/utils/car_datas/cars_data.dart';
import 'package:motox/utils/colors/colors.dart';
import 'package:motox/utils/constants/space.dart';
import 'package:motox/utils/constants/text_styles.dart';

class CarDetailsPage extends StatelessWidget {
  final Car car;

  CarDetailsPage({
    required this.car,
  });

  @override
  Widget build(BuildContext context) {
    String brandName = car.make; // Replace with the desired brand name
    String modelName = car.model; // Replace with the desired model name

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
        children: <Widget>[
          const SizedBox(
            width: double.infinity,
          ),
          vertical200,
          Text(
            '${car.year} ${car.make} ${car.model}',
            style: TextStyles.mainHeadingBlack,
          ),
          vertical20,
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.network(
              imagePath,
              width: 200,
              height: 150,
            ),
          ),
          vertical20,
          Text('Fuel: ${car.fuel}'),
          const SizedBox(height: 10),
          Text('License Plate: ${car.licensePlate}'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
