import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motox/data/repositories/service_repository.dart';
import 'package:motox/presentation/screens/booking/widgets/booking_card.dart';
import 'package:motox/utils/constants/screen_size.dart';
import 'package:motox/utils/constants/space.dart';
import 'package:motox/utils/constants/text_styles.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MyScreenSize.screenHeight(context);
    ServiceRepository().fetchBookings();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              vertical20,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'My Bookings',
                    style: TextStyles.mainHeadingBlack,
                  ),
                ],
              ),
              vertical20,
              Expanded(
                child: FutureBuilder(
                    future: ServiceRepository().fetchBookings(
                        userId: FirebaseAuth.instance.currentUser!.uid),
                    builder: (context, snapshot) {
                      if (snapshot.hasError ||
                          snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ListView.separated(
                        itemBuilder: (context, index) => buildBookingCard(
                            index, height, context, snapshot.data![index]),
                        separatorBuilder: (context, index) => vertical20,
                        itemCount: snapshot.data!.length,
                      );
                    }),
              ),
              vertical100,
            ],
          ),
        ),
      ),
    );
  }
}
