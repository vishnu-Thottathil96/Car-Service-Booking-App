import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motox/business%20logic/blocs/booking/booking_bloc.dart';
import 'package:motox/presentation/screens/my_booking/widgets/booking_card.dart';
import 'package:motox/utils/constants/screen_size.dart';
import 'package:motox/utils/constants/space.dart';
import 'package:motox/utils/constants/text_styles.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MyScreenSize.screenHeight(context);
    context.read<BookingBloc>().add(FetchBookings());

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
                child: BlocBuilder<BookingBloc, BookingState>(
                    builder: (context, state) {
                  if (state is BookingsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is BookingFetchingSuccess) {
                    if (state.bookings.isEmpty) {
                      return const Center(child: Text('No Bookings yet !'));
                    }
                    return ListView.separated(
                      itemBuilder: (context, index) => buildBookingCard(
                          index, height, context, state.bookings[index]),
                      separatorBuilder: (context, index) => vertical20,
                      itemCount: state.bookings.length,
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
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
