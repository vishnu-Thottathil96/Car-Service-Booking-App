import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  String? bookingId;
  String serviceType;
  String userId;
  String licensePlate;
  String serviceStatus;
  int? estimatedAmount;
  double? finalBill;
  String? estimatedTime;
  DateTime dateTime;
  String? description;
  String bookedSlot;
  BookingModel({
    this.bookingId,
    required this.serviceType,
    required this.licensePlate,
    required this.serviceStatus,
    required this.userId,
    this.estimatedAmount,
    this.estimatedTime,
    this.description,
    required this.dateTime,
    required this.bookedSlot,
    this.finalBill,
  });
  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      bookingId: json['bookingId'],
      serviceType: json['servicetype'],
      licensePlate: json['licenseplate'],
      serviceStatus: json['servicestatus'],
      userId: json['userId'],
      dateTime: (json['date'] as Timestamp).toDate(),
      description: json['description'],
      bookedSlot: json['bookedslot'],
      finalBill: json['finalbill'],
    );
  }
}
