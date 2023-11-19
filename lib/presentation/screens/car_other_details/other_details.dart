import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motox/business%20logic/blocs/brand_selection/brand_selection_bloc.dart';
import 'package:motox/data/models/model_car.dart';
import 'package:motox/data/repositories/user_repository.dart';
import 'package:motox/presentation/screens/landing_screen/screen_landing.dart';
import 'package:motox/presentation/screens/profile/screen_profile.dart';
import 'package:motox/presentation/widgets/custom_textfield.dart';
import 'package:motox/presentation/widgets/large_button.dart';
import 'package:motox/utils/car_datas/cars_data.dart';
import 'package:motox/utils/colors/colors.dart';
import 'package:motox/utils/constants/screen_size.dart';
import 'package:motox/utils/constants/space.dart';
import 'package:motox/utils/constants/text_styles.dart';
import 'package:motox/utils/controllers/text_editing_controllers.dart';
import 'package:motox/utils/helpers/validators.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:transparent_image/transparent_image.dart';

class OtherDetailsOfCar extends StatelessWidget {
  OtherDetailsOfCar({
    super.key,
    required this.brand,
    required this.model,
  });
  final String brand;
  final String model;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String brandName = brand; // Replace with the desired brand name
    String modelName = model; // Replace with the desired model name
    ValueNotifier<String> selectedFuel = ValueNotifier<String>('Petrol');
    String? carImageURL;

// Iterate through the carData list to find the brand data
    for (var brandData in carData) {
      if (brandData.containsKey(brandName)) {
        Map<String, dynamic> brandInfo = brandData[brandName];
        Map<String, dynamic> models = brandInfo["models"];

        if (models.containsKey(modelName)) {
          carImageURL = models[modelName];
          break; // Stop searching when the model is found
        }
      }
    }

    if (carImageURL != null) {
      // now have the image URL for the specified car model.
      log("Image URL: $carImageURL");
    } else {
      // The specified brand or model was not found in carData.
      log("Car not found.");
    }
    double height = MyScreenSize.screenHeight(context);
    double width = MyScreenSize.screenWidth(context);
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              vertical20,
              const TopBar(),
              vertical20,
              Container(
                height: height / 4,
                width: width / 1.5,
                child: Stack(
                  children: [
                    Center(
                        child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: carImageURL!,
                      fit: BoxFit.cover,
                    )),
                  ],
                ),
              ),
              Text(
                '$brand  $model',
                style: TextStyles.subheadingGrey,
              ),
              vertical20,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildYearField(
                          TextEditingControllers.manufactureYearController),
                      vertical30,
                      buildReggNumberField(
                          TextEditingControllers.registerNumberController)
                    ],
                  ),
                ),
              ),
              vertical40,
              FuelSelectionWidget(
                selectedFuel: selectedFuel,
              ),
              vertical100,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: BlocConsumer<BrandSelectionBloc, BrandSelectionState>(
                  listener: (context, state) {
                    if (state is CarAddSuccessState) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LandingPage(),
                          ),
                          (route) => false);
                    }
                  },
                  builder: (context, state) {
                    if (state is FinishButtonLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    return LargeButton(
                        context: context,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            final Car car = Car(
                              make: brand,
                              model: model,
                              year: TextEditingControllers
                                  .manufactureYearController.text,
                              fuel: selectedFuel.value,
                              licensePlate: TextEditingControllers
                                  .registerNumberController.text,
                            );
                            context
                                .read<BrandSelectionBloc>()
                                .add(FinishSetupButtonClicked(car: car));
                          }
                        },
                        text: 'Finish Setup');
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//
Widget buildYearField(TextEditingController yearController) {
  return CustomTextField(
    keyboardType: TextInputType.number,
    validator: validateCarYear,
    hint: 'Manufacture Year',
    sufixIcon: Icon(
      Icons.date_range_outlined,
      color: greyColor,
    ),
    controller: yearController,
  );
}

//
//
Widget buildReggNumberField(TextEditingController numberController) {
  return CustomTextField(
    validator: validateRegisterNumber,
    hint: 'Register Number',
    sufixIcon: Icon(
      Icons.app_registration,
      color: greyColor,
    ),
    controller: numberController,
  );
}
//

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'A Few More Details',
                style: TextStyles.mainHeadingBlack,
              ),
              vertical10,
              Text(
                'Fill Other Details',
                style: TextStyles.normalTextGrey,
              ),
            ],
          ),
          SizedBox(
            height: 45,
            width: 45,
            child: CircularStepProgressIndicator(
              totalSteps: 3,
              currentStep: 3,
              stepSize: 3,
              selectedColor: gradientOrange,
              unselectedColor: Colors.grey[200],
              padding: 0,
              selectedStepSize: 3,
              roundedCap: (_, __) => true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '3',
                    style: TextStyle(
                        color: blackColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    '/3',
                    style: TextStyle(fontSize: 11),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

/////////
class FuelSelectionWidget extends StatelessWidget {
  final ValueNotifier<String> selectedFuel;
  final List<String> fuelOptions = ['Petrol', 'Diesel', 'CNG', 'Electric'];

  FuelSelectionWidget({
    required this.selectedFuel,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Select Fuel Type:', style: TextStyles.subheadingGrey),
            const Spacer(),
            DropdownButton<String>(
              style: TextStyles.normalTextBlack,
              value: selectedFuel
                  .value, // Set the initial value from the ValueNotifier
              onChanged: (String? newValue) {
                selectedFuel.value =
                    newValue!; // Update the ValueNotifier's value
              },
              items: fuelOptions.map((String fuel) {
                return DropdownMenuItem<String>(
                  value: fuel,
                  child: Text(fuel),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
