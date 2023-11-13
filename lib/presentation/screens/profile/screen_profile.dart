import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motox/business%20logic/blocs/profile/profile_bloc.dart';
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
    context.read<ProfileBloc>().add(ProfileFetching());
    context.read<ProfileBloc>().add(FetchUserCars());
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
      return ''; // Return a default image URL.
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
                BlocBuilder<ProfileBloc, ProfileState>(
                  buildWhen: (previous, current) =>
                      (current is ProfileLoading && !current.isCarLoading) ||
                      current is ProfileFetchSuccess,
                  builder: (context, state) {
                    if (state is ProfileLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ProfileFetchSuccess) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              context
                                  .read<ProfileBloc>()
                                  .add(SelectImageFromGallery());
                            },
                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage: NetworkImage(
                                  state.user.profilePhoto.isEmpty
                                      ? defaultProfile
                                      : state.user.profilePhoto),
                            ),
                          ),
                          vertical20,
                          Text(state.user.name,
                              style: TextStyles.subheadingBlack),
                          vertical40,
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
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
                              builder: (context) => const BrandSelectPage(),
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

                BlocBuilder<ProfileBloc, ProfileState>(
                    buildWhen: (previous, current) =>
                        (current is ProfileLoading && current.isCarLoading) ||
                        current is FetchUserCarsSuccess,
                    builder: (context, state) {
                      if (state is FetchUserCarsSuccess) {
                        if (state.userCarList.isEmpty) {
                          return const Center(
                            child: Text("No cars found!"),
                          );
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
                              final car = state.userCarList[index];
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
                            itemCount: state.userCarList.length);
                      } else if (state is ProfileLoading &&
                          state.isCarLoading) {
                        return const CircularProgressIndicator();
                      } else {
                        return const SizedBox();
                      }
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

const defaultProfile =
    'https://camo.githubusercontent.com/c6fe2c13c27fe87ac6581b9fe289d2f071bd1b4ef6f3e3c5fc2aba0bbc23fd88/68747470733a2f2f75706c6f61642e77696b696d656469612e6f72672f77696b6970656469612f636f6d6d6f6e732f372f37632f50726f66696c655f6176617461725f706c616365686f6c6465725f6c617267652e706e67';
