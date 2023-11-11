import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motox/data/models/model_car.dart';
import 'package:motox/data/repositories/user_repository.dart';
import 'package:motox/presentation/screens/brand_selection/car_add.dart';
import 'package:motox/presentation/screens/car_details/car_details.dart';
import 'package:motox/presentation/screens/onboard%20screen/screen_onboard.dart';
import 'package:motox/utils/car_datas/cars_data.dart';
import 'package:motox/utils/colors/colors.dart';
import 'package:motox/utils/constants/space.dart';
import 'package:motox/utils/constants/text_styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                vertical20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'User Profile',
                      style: TextStyles.mainHeadingBlack,
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: const Text(
                                  ' Are you sure you want to log out?'),
                              title: const Text('Confirm Logout'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    FirebaseAuth.instance.signOut();
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const OnBoardScreen(),
                                        ),
                                        (route) => false);
                                  },
                                  child: const Text('Logout'),
                                )
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.logout),
                    )
                  ],
                ),
                vertical20,
                GestureDetector(
                    onTap: () {
                      UserRepository.uploadProfileImageToFirebase(
                          FirebaseAuth.instance.currentUser!.uid);
                    },
                    child: FutureBuilder<String?>(
                      future: UserRepository.getProfileImageUrl(
                          FirebaseAuth.instance.currentUser!.uid),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }

                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        final imageUrl = snapshot.data;

                        return CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(
                              imageUrl ?? 'assets/home_screen_images/paul.png'),
                        );
                      },
                    )),
                vertical20,
                FutureBuilder<String>(
                    future: UserRepository.getCurrentUserName(
                        FirebaseAuth.instance.currentUser!.uid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text('User Name');
                      }
                      final userName = snapshot.data!;

                      return Text(
                        userName,
                        style: TextStyles.subheadingBlack,
                      );
                    }),
                vertical40,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My cars',
                      style: TextStyles.subheadingBlack,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BrandSelectPage(),
                            ));
                      },
                      child: Image.asset(
                        'assets/icons/add car.png',
                        height: 45,
                        width: 45,
                      ),
                    )
                  ],
                ),
                vertical30,

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
                      return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            final car = snapshot.data![index];
                            return Material(
                              color: whiteColor,
                              elevation: 5,
                              borderRadius: BorderRadius.circular(5),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CarDetailsPage(
                                          car: car,
                                        ),
                                      ));
                                },
                                child: SizedBox(
                                  height: 150,
                                  width: 100,
                                  child: Column(
                                    children: [
                                      Text(car.model),
                                      vertical10,
                                      SizedBox(
                                        width: double.infinity,
                                        height: 80,
                                        child: Image.network(
                                            getCarImage(car.make, car.model)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: snapshot.data!.length);
                    }),
                vertical80 // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
