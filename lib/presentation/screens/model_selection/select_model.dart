import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motox/business%20logic/blocs/brand_selection/brand_selection_bloc.dart';
import 'package:motox/presentation/screens/car_other_details/other_details.dart';
import 'package:motox/utils/car_datas/cars_data.dart';
import 'package:motox/utils/colors/colors.dart';
import 'package:motox/utils/constants/space.dart';
import 'package:motox/utils/constants/text_styles.dart';
import 'package:motox/utils/dialouges/dialouges.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:transparent_image/transparent_image.dart';

class ModelSelectionPage extends StatelessWidget {
  const ModelSelectionPage({super.key, required this.brand});
  final String brand;

  @override
  Widget build(BuildContext context) {
    List<String> modelNames = [];
    List modelImageUrls = [];
    String logoUrl = '';
    String seletedModel = '';
    // Access the logo and models for the selected brand
    Map<String, dynamic>? selectedBrandData;
    for (var brandData in carData) {
      if (brandData.containsKey(brand)) {
        selectedBrandData = brandData[brand];
        break; // Stop searching when the brand is found
      }
    }
    if (selectedBrandData != null) {
      Map<String, dynamic> modelsData = selectedBrandData["models"];
      // Extract the model names and image URLs
      logoUrl = selectedBrandData["logo"];
      modelNames = modelsData.keys.toList();
      modelImageUrls = modelsData.values.toList();
    }
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: ListView(
          children: [
            vertical25,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: greyColor),
                              image: DecorationImage(
                                  image: NetworkImage(logoUrl),
                                  fit: BoxFit.scaleDown),
                            ),
                            height: 45,
                            width: 45,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              brand,
                              style: TextStyles.mainHeadingBlack,
                            ),
                          ),
                        ],
                      ),
                      vertical10,
                      Text(
                        'Select Your Car Model',
                        style: TextStyles.normalTextGrey,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 45,
                    width: 45,
                    child: CircularStepProgressIndicator(
                      totalSteps: 3,
                      currentStep: 2,
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
                            '2',
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
            ),
            vertical40,
            BlocBuilder<BrandSelectionBloc, BrandSelectionState>(
              builder: (context, state) {
                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 0,
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              seletedModel = modelNames[index];
                              context.read<BrandSelectionBloc>().add(
                                  SelectionModelIndexChange(
                                      selectedModelIndex: index,
                                      selectedModel: seletedModel));
                            },
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: state is ModelSelected &&
                                              state.selectedModelIndex == index
                                          ? greenColor
                                          : whiteColor)),
                              child: Stack(
                                children: [
                                  Center(
                                      child: FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image: modelImageUrls[index],
                                    fit: BoxFit.cover,
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/icons/no_image.jpg',
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  )),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            modelNames[index], // Display model name
                            style: TextStyles.normalTextBlack,
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: modelImageUrls.length,
                );
              },
            ),
            vertical50,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    style: const ButtonStyle(),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: blackColor,
                      size: 22,
                    ),
                    label: Text(
                      'Change Brand',
                      style: TextStyles.normalTextBlack,
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextButton.icon(
                      onPressed: () {
                        log(seletedModel);
                        seletedModel.isNotEmpty
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OtherDetailsOfCar(
                                    brand: brand,
                                    model: seletedModel,
                                  ),
                                ))
                            : Dialogs.showAlert(context, 'Select model',
                                'Select a model to continue');
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: blackColor,
                        size: 22,
                      ),
                      label: Text(
                        'Next Step',
                        style: TextStyles.normalTextBlack,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
