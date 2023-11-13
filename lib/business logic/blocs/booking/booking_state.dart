part of 'booking_bloc.dart';

class BookingState {}

final class BookingInitial extends BookingState {}

class BookingsLoading extends BookingState {}

class BookingFetchingSuccess extends BookingState {
  final List<BookingModel> bookings;
  BookingFetchingSuccess({required this.bookings});
}
