// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motox/data/models/booking_model/booking_model.dart';
import 'package:motox/data/models/model_car.dart';
import 'package:motox/data/models/model_time_slot.dart';
import 'package:motox/data/repositories/service_repository.dart';
import 'package:motox/data/repositories/user_repository.dart';
import 'package:motox/presentation/screens/slot_selection/widgets/calendar_section.dart';
import 'package:motox/presentation/widgets/large_button.dart';
import 'package:motox/utils/car_datas/cars_data.dart';
import 'package:motox/utils/colors/colors.dart';
import 'package:motox/utils/constants/enums.dart';
import 'package:motox/utils/constants/screen_size.dart';
import 'package:motox/utils/constants/space.dart';
import 'package:motox/utils/constants/text_styles.dart';
import 'package:motox/utils/controllers/text_editing_controllers.dart';
import 'package:motox/utils/design_assets/design_assets.dart';
import 'package:motox/utils/dialouges/dialouges.dart';

Car? selectedCarForService;

class ServiceDescription extends StatelessWidget {
  ServiceDescription({super.key, this.serviceType, required this.slot});
  final String? serviceType;
  final SlotDataModel slot;
  final _formKey = GlobalKey<FormState>();

  ValueNotifier<int> selectedCarIndex = ValueNotifier(-1);

  String getCarImage(String brandName, String modelName) {
    for (var carBrand in carData) {
      final brandData = carBrand[brandName];
      if (brandData != null) {
        final modelData = brandData['models'][modelName];
        if (modelData != null) {
          return modelData;
        }
      }
    }
    return ''; // Return a default image URL or handle the case where the car isn't found.
  }

  @override
  Widget build(BuildContext context) {
    double height = MyScreenSize.screenHeight(context);
    return Scaffold(
      backgroundColor: whiteColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text(serviceType ?? 'Select Car'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                vertical20,
                serviceType != null
                    ? Form(
                        key: _formKey,
                        child: TextFormField(
                          controller:
                              TextEditingControllers.descriptionController,
                          maxLines: 6,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              hintText:
                                  'Enter Description About Your Complaint...'),
                          validator: (value) {
                            if (serviceType == 'Periodic') {
                              return null;
                            }
                            if (value == null || value.isEmpty) {
                              return 'Description is required';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            TextEditingControllers.descriptionController.text =
                                value!;
                          },
                        ),
                      )
                    : SizedBox(
                        height: height / 4,
                        width: double.infinity,
                        child: Image.asset(
                          'assets/icons/select_car.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                vertical20,
                StreamBuilder<List<Car>>(
                  stream: UserRepository.streamUserCars(
                      FirebaseAuth.instance.currentUser!.uid),
                  builder: (context, snapshot) {
                    log('message');
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                          child: Text(
                        'No cars found.',
                        style: TextStyles.subheadingGrey,
                      ));
                    }
                    return ValueListenableBuilder(
                        valueListenable: selectedCarIndex,
                        builder: (context, value, _) {
                          return GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 15,
                                      crossAxisSpacing: 15,
                                      crossAxisCount: 3),
                              // scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final car = snapshot.data![index];
                                return Material(
                                  color: whiteColor,
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(5),
                                  child: GestureDetector(
                                    onTap: () {
                                      selectedCarIndex.value = index;
                                      selectedCarForService =
                                          snapshot.data![index];
                                    },
                                    child: Container(
                                      height: 160,
                                      width: 110,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: selectedCarIndex.value ==
                                                      index
                                                  ? greenColor
                                                  : whiteColor)),
                                      child: Column(
                                        children: [
                                          Text(car.model),
                                          vertical10,
                                          SizedBox(
                                            width: double.infinity,
                                            height: 80,
                                            child: Image.network(getCarImage(
                                                car.make, car.model)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: snapshot.data!.length);
                        });
                  },
                ),
                vertical50,
                LargeButton(
                    context: context,
                    onTap: () async {
                      if (_formKey.currentState!.validate() &&
                          selectedCarForService!.model.isNotEmpty) {
                        final bookingModel = BookingModel(
                            bookedSlot: slot.time.toString(),
                            description: TextEditingControllers
                                .descriptionController.text,
                            serviceType: serviceType!,
                            licensePlate: selectedCarForService!.licensePlate,
                            serviceStatus: serviceType == serviceTypes[0]
                                ? ServiceStatus.booked.name
                                : ServiceStatus.pending.name,
                            dateTime: selectedDateTime.value,
                            userId: FirebaseAuth.instance.currentUser!.uid);
                        await ServiceRepository().addSlot(slot);
                        await ServiceRepository().bookNewService(bookingModel);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        TextEditingControllers.descriptionController.clear();
                      } else {
                        Dialogs.showSnackbar(context, 'Select Car', redColor);
                      }
                    },
                    text: 'Next'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
