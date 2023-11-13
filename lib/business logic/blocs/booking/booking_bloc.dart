import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:motox/data/models/booking_model/booking_model.dart';
import 'package:motox/data/repositories/service_repository.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitial()) {
    on<FetchBookings>(fetchBookings);
  }

  FutureOr<void> fetchBookings(
      FetchBookings event, Emitter<BookingState> emit) async {
    emit(BookingsLoading());
    final bookings = await ServiceRepository()
        .fetchBookings(userId: FirebaseAuth.instance.currentUser!.uid);
    emit(BookingFetchingSuccess(bookings: bookings));
  }
}
