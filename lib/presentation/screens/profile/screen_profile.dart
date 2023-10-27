import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motox/presentation/screens/onboard%20screen/screen_onboard.dart';
import 'package:motox/utils/constants/space.dart';
import 'package:motox/utils/constants/text_styles.dart';
import 'package:motox/utils/design_assets/design_assets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
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
                      FirebaseAuth.instance.signOut();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OnBoardScreen(),
                          ),
                          (route) => false);
                    },
                    icon: const Icon(Icons.logout),
                  )
                ],
              ),
              vertical20,
              const CircleAvatar(
                radius: 70,
                backgroundImage:
                    AssetImage('assets/home_screen_images/paul.png'),
              ),
              vertical20,
              Text(
                'Ilyas muhammed',
                style: TextStyles.subheadingBlack,
              ),
              vertical40,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My cars',
                    style: TextStyles.subheadingBlack,
                  ),
                  Image.asset(
                    'assets/icons/add car.png',
                    height: 60,
                    width: 60,
                  )
                ],
              ),
              vertical30,
              Container(
                height: 150,
                width: double.infinity,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Material(
                        elevation: 10,
                        child: Container(
                          height: 150,
                          width: 100,
                          child: Column(
                            children: [
                              Text(carNames[index]),
                              vertical10,
                              Container(
                                width: double.infinity,
                                height: 80,
                                child: Image.asset(carImages[index]),
                              ),
                              vertical10,
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.block,
                                      color: Colors.red,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 20,
                        ),
                    itemCount: 4),
              )
            ],
          ),
        ),
      ),
    );
  }
}
