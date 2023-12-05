import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motox/business%20logic/blocs/brand_selection/brand_selection_bloc.dart';
import 'package:motox/presentation/screens/model_selection/select_model.dart';
import 'package:motox/utils/car_datas/cars_data.dart';
import 'package:motox/utils/colors/colors.dart';
import 'package:motox/utils/constants/space.dart';
import 'package:motox/utils/constants/text_styles.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class BrandSelectPage extends StatelessWidget {
  const BrandSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            vertical35,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: TopBar(),
            ),
            vertical40,
            BrandsGrid(),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              child: BottomButtons(),
            )
          ],
        ),
      ),
    );
  }
}

class BrandsGrid extends StatelessWidget {
  const BrandsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedBrandIndex = 0;
    String selectedBrand = '';
    return BlocBuilder<BrandSelectionBloc, BrandSelectionState>(
      builder: (context, state) {
        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) {
            return Card(
              color: Colors.transparent,
              elevation: 0,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      selectedBrandIndex = index;
                      selectedBrand = carData[selectedBrandIndex].keys.first;
                      log(selectedBrand);
                      context.read<BrandSelectionBloc>().add(
                          SelectionIndexChange(
                              seletedIndex: index,
                              selectedBrand: selectedBrand));
                    },
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        // image: DecorationImage(
                        //   image: NetworkImage(
                        //     carData[index].values.first["logo"],
                        //   ),
                        //   fit: BoxFit.contain,
                        // ),
                        border: Border.all(
                            color: state is BrandSelected &&
                                    state.selectedIndex == index
                                ? greenColor
                                : whiteColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.network(
                        carData[index].values.first["logo"],
                        fit: BoxFit.scaleDown,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/icons/empty_image.jpeg',
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                  Text(
                    carData[index].keys.first, // Display brand name
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
            );
          },
          itemCount: carData.length,
        );
      },
    );
  }
}

class BottomButtons extends StatelessWidget {
  const BottomButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
            'Back',
            style: TextStyles.normalTextBlack,
          ),
        ),
        BlocBuilder<BrandSelectionBloc, BrandSelectionState>(
          builder: (context, state) {
            if (state is BrandSelected) {
              // // If a brand is selected, navigate to the next page
              // Future.delayed(Duration.zero, () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => ModelSelectionPage(
              //         brand: state.selectedBrand,
              //       ),
              //     ),
              //   );
              // });

              // // Return an empty container because the "Next Step" button is not needed
              // return const SizedBox();
              return Directionality(
                textDirection: TextDirection.rtl,
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ModelSelectionPage(
                            brand: state.selectedBrand,
                          ),
                        ));
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
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Register Your Car',
              style: TextStyles.mainHeadingBlack,
            ),
            vertical10,
            Text(
              'Select Your Car Brand',
              style: TextStyles.normalTextGrey,
            ),
          ],
        ),
        SizedBox(
          height: 45,
          width: 45,
          child: CircularStepProgressIndicator(
            totalSteps: 3,
            currentStep: 1,
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
                  '1',
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
    );
  }
}
