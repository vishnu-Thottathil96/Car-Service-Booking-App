import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:motox/presentation/screens/model_selection/select_model.dart';
import 'package:motox/utils/car_datas/cars_data.dart';
import 'package:motox/utils/colors/colors.dart';
import 'package:motox/utils/constants/space.dart';
import 'package:motox/utils/constants/text_styles.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class BrandSelectPage extends StatefulWidget {
  const BrandSelectPage({super.key});

  @override
  State<BrandSelectPage> createState() => _BrandSelectPageState();
}

class _BrandSelectPageState extends State<BrandSelectPage> {
  String selectedBrand = '';

  void setSelectedBrand(String brand) {
    setState(() {
      selectedBrand = brand;
    });
    log("Selected brand: $selectedBrand");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            vertical35,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: TopBar(),
            ),
            vertical40,
            BrandsGrid(
              onBrandSelected: setSelectedBrand,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              child: BottomButtons(
                selectedBrand: selectedBrand,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BrandsGrid extends StatefulWidget {
  final Function(String) onBrandSelected;
  const BrandsGrid({
    super.key,
    required this.onBrandSelected,
  });

  @override
  State<BrandsGrid> createState() => _BrandsGridState();
}

class _BrandsGridState extends State<BrandsGrid> {
  int selectedBrandIndex = -1;
  String selectedBrand = '';
  @override
  Widget build(BuildContext context) {
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
                  setState(() {
                    selectedBrandIndex = index;
                    selectedBrand = carData[selectedBrandIndex].keys.first;
                    log(selectedBrand);
                    widget.onBrandSelected(selectedBrand);
                  });
                },
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        carData[index].values.first["logo"],
                      ),
                      fit: BoxFit.contain,
                    ),
                    border: Border.all(
                      color: selectedBrandIndex == index
                          ? Colors.green
                          : const Color.fromARGB(255, 241, 240, 240),
                    ),
                    borderRadius: BorderRadius.circular(8),
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
  }
}

class BottomButtons extends StatelessWidget {
  final String selectedBrand;

  const BottomButtons({
    super.key,
    required this.selectedBrand,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
          style: const ButtonStyle(),
          onPressed: () {},
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
        Directionality(
          textDirection: TextDirection.rtl,
          child: TextButton.icon(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ModelSelectionPage(
                      brand: selectedBrand,
                    ),
                  ));
              log('from bottom button selected brand = $selectedBrand');
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
