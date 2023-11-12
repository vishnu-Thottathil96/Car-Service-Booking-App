import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motox/data/models/booking_model/booking_model.dart';
import 'package:motox/data/models/model_time_slot.dart';

class ServiceRepository {
  addSlot(SlotDataModel slot) async {
    final slotCollection = FirebaseFirestore.instance.collection('slots').doc();

    await slotCollection.set({
      'date': slot.dateTime,
      'isBooked': slot.isBooked,
      'soldId': slotCollection.id,
      'time': slot.time,
    });
  }

  bookNewService(BookingModel bookingModel) async {
    final bookingCollection =
        FirebaseFirestore.instance.collection('bookings').doc();
    await bookingCollection.set({
      'userId': bookingModel.userId,
      'licenseplate': bookingModel.licensePlate,
      'servicetype': bookingModel.serviceType,
      'servicestatus': bookingModel.serviceStatus,
      'bookingId': bookingCollection.id,
      'estimatedamount': bookingModel.estimatedAmount,
      'estimatedtime': bookingModel.estimatedTime,
      'date': bookingModel.dateTime,
      'description': bookingModel.description,
      'bookedslot': bookingModel.bookedSlot,
    });
  }

  Future<List<BookingModel>> fetchBookings({String? userId}) async {
    if (userId == null) {
      final snapShots =
          await FirebaseFirestore.instance.collection('bookings').get();
      return snapShots.docs.map((booking) {
        final data = booking.data();
        return BookingModel.fromJson(data);
      }).toList();
    } else {
      final snapShots = await FirebaseFirestore.instance
          .collection('bookings')
          .where('userId', isEqualTo: userId)
          .get();
      return snapShots.docs.map((booking) {
        final data = booking.data();
        return BookingModel.fromJson(data);
      }).toList();
    }
  }
}
