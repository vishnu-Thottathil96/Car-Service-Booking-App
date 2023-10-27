import 'package:motox/data/models/model_message.dart';
import 'package:motox/data/models/model_service_item.dart';
import 'package:motox/data/models/model_time_slot.dart';
import 'package:motox/utils/colors/colors.dart';

List homeScrenImage = [
  'assets/home_screen_images/1.jpg',
  'assets/home_screen_images/2.jpg',
  'assets/home_screen_images/3.jpg',
  'assets/home_screen_images/4.jpg',
  'assets/home_screen_images/5.jpg',
  'assets/home_screen_images/6.jpg',
];
List serviceTypes = [
  'Periodic',
  'Detailing',
  'AC repair',
  'Wheels',
  'Painting',
  'Electronics',
];
List bookingDates = [
  'Booking Date : Oct 14 2023',
  'Booking Date : Oct 01 2023',
  'Booking Date : Sept 18 2023',
  'Booking Date : March 3 2023',
  'Booking Date : Jan 22 2023',
  'Booking Date : Jan 22 2023',
];
List status = [
  'Ready to Deliver',
  'On Progress',
  'Completed',
  'Ready to Deliver',
  'On Progress',
  'Completed',
];
List statusColor = [
  greenColor,
  gradientOrange,
  blackColor,
  greenColor,
  gradientOrange,
  blackColor,
];
List helpPageIcons = [
  'assets/icons/faq.png',
  'assets/icons/chat.png',
  'assets/icons/live-chat.png',
  'assets/icons/email.png',
];
List helpHeadings = [
  'FAQ',
  'Chat Support',
  'Call Us',
  'E mail',
];
List carImages = [
  'assets/icons/m4.png',
  'assets/icons/m340i.png',
  'assets/icons/z4.png',
  'assets/icons/2series.png',
];
List carNames = [
  'BMW m4',
  'BMW m340i',
  'BMW z4',
  'BMW 2series',
];
List<Message> messages = [
  Message(
      text: 'Hello, I need to schedule a service for my car.',
      date: DateTime.now().subtract(const Duration(days: 2)),
      isSendByMe: true),
  Message(
      text: 'Sure, when would you like to come in?',
      date: DateTime.now().subtract(const Duration(days: 2)),
      isSendByMe: false),
  Message(
      text: 'Hi! We have availability this week. What day works best for you?',
      date: DateTime.now().subtract(const Duration(days: 2)),
      isSendByMe: true),
  Message(
      text: 'Not much, just working on some projects. How about you?',
      date: DateTime.now().subtract(const Duration(days: 1)),
      isSendByMe: false),
  Message(
      text: 'Thursday morning would be perfect.',
      date: DateTime.now().subtract(const Duration(days: 1)),
      isSendByMe: true),
  Message(
      text: 'Great, we have an opening on Thursday at 10 AM.',
      date: DateTime.now().subtract(const Duration(days: 1)),
      isSendByMe: false),
  Message(
      text: 'Perfect, I\'ll be there. Do I need to bring any documents?',
      date: DateTime.now().subtract(const Duration(days: 1)),
      isSendByMe: true),
  Message(
      text:
          'No need for documents, just bring your car. We\'ll take care of the rest.',
      date: DateTime.now().subtract(const Duration(days: 1)),
      isSendByMe: false),
];
List<SlotItem> periodicServiceSlotes = [
  SlotItem(time: '09.00 AM'),
  SlotItem(time: '09.30 AM'),
  SlotItem(time: '10.00 AM'),
  SlotItem(time: '10.30 AM', isBooked: true),
  SlotItem(time: '11.00 AM'),
  SlotItem(time: '11.30 AM'),
  SlotItem(time: '12.00 PM', isBooked: true),
  SlotItem(time: '12.30 PM'),
  SlotItem(time: '01.00 PM'),
  SlotItem(time: '01.30 PM'),
  SlotItem(time: '02.00 PM'),
  SlotItem(time: '02.30 PM'),
];
List<ServiceItem> typesOfServices = [
  ServiceItem(
      heading: 'Periodic', imagePath: 'assets/home_screen_images/1.jpg'),
  ServiceItem(
      heading: 'Detailing', imagePath: 'assets/home_screen_images/2.jpg'),
  ServiceItem(
      heading: 'AC repair', imagePath: 'assets/home_screen_images/3.jpg'),
  ServiceItem(heading: 'Wheels', imagePath: 'assets/home_screen_images/4.jpg'),
  ServiceItem(
      heading: 'Painting', imagePath: 'assets/home_screen_images/5.jpg'),
  ServiceItem(
      heading: 'Electronics', imagePath: 'assets/home_screen_images/6.jpg'),
];
