import 'package:flutter/material.dart';
import 'package:motox/data/models/booking_model/booking_model.dart';
import 'package:motox/data/repositories/service_repository.dart';
import 'package:motox/data/repositories/user_repository.dart';
import 'package:motox/presentation/screens/landing_screen/screen_landing.dart';
import 'package:motox/presentation/widgets/large_button.dart';
import 'package:motox/utils/colors/colors.dart';
import 'package:motox/utils/constants/screen_size.dart';
import 'package:motox/utils/constants/space.dart';
import 'package:motox/utils/constants/text_styles.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class JobCardPage extends StatelessWidget {
  const JobCardPage(
      {super.key,
      required this.bookingModel,
      required this.formatedDate,
      required this.carMake,
      required this.carModel});
  final BookingModel bookingModel;
  final String formatedDate;
  final String carMake;
  final String carModel;
  @override
  Widget build(BuildContext context) {
    double height = MyScreenSize.screenHeight(context);
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            vertical20,
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Text(
                    'Service Tracking',
                    textAlign: TextAlign.center,
                    style: TextStyles.mainHeadingBlack,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Material(
                elevation: 10,
                child: Container(
                  color: const Color.fromARGB(255, 249, 253, 255),
                  width: double.infinity,
                  height: height / 2,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Booking Date :   $formatedDate',
                          style: TextStyles.normalTextBlack,
                        ),
                        Text(
                          'Status :   ${bookingModel.serviceStatus}',
                          style: TextStyles.normalTextBlack,
                        ),
                        Text(
                          'Car :   $carMake $carModel',
                          style: TextStyles.normalTextBlack,
                        ),
                        Text(
                          'Service Type :   ${bookingModel.serviceType}',
                          style: TextStyles.normalTextBlack,
                        ),
                        bookingModel.estimatedAmount == null
                            ? const Text(
                                'Estimated Amount :  Will be generated ')
                            : Text(
                                'Estimated Amount : ${bookingModel.estimatedAmount.toString()}',
                              ),
                        bookingModel.estimatedTime == null
                            ? const Text('Estimated Time :  Will be generated ')
                            : Text(
                                'Estimated Time : ${bookingModel.estimatedTime.toString()}',
                              )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            bookingModel.finalBill != null
                ? BillSection(bookingModel: bookingModel)
                : SizedBox()
          ],
        ),
      )),
    );
  }
}

class BillSection extends StatefulWidget {
  const BillSection({
    super.key,
    required this.bookingModel,
  });

  final BookingModel bookingModel;

  @override
  State<BillSection> createState() => _BillSectionState();
}

class _BillSectionState extends State<BillSection> {
  var _razorpay = Razorpay();
  String userName = 'Unknown User';
  @override
  void initState() {
    // TODO: implement initState
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    // Fetch the username
    UserRepository.getCurrentUserName(widget.bookingModel.userId).then((name) {
      setState(() {
        userName = name;
      });
    });
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Do something when payment succeeds
    print('Success');
    await ServiceRepository().updatePaymentStatus(
        bookingId: widget.bookingModel.bookingId!, status: true);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LandingPage(),
        ),
        (route) => false);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print('Failed');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    print('External');
  }

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'Payment',
            style: TextStyles.subheadingGrey,
          ),
          vertical70,
          Text('Final Bill Amount : Rs. ${widget.bookingModel.finalBill}'),
          vertical60,
          Padding(
              padding: const EdgeInsets.all(20.0),
              child: widget.bookingModel.isPaid == false
                  ? LargeButton(
                      context: context,
                      onTap: () {
                        double formatedAmount = widget.bookingModel.finalBill!;
                        var options = {
                          'method': {
                            'netbanking': true,
                            'card': true,
                            'upi': true,
                            'wallet': true,
                          },
                          'name': userName,
                          'key': 'rzp_test_xI1eLMUOsqnyzG',
                          "id": widget.bookingModel.bookingId,
                          "entity": "order",
                          "amount": formatedAmount * 100,
                          "currency": "INR",
                          "status": "created",
                          "notes": [],
                        };
                        _razorpay.open(options);
                      },
                      text: 'Pay Online',
                    )
                  : Text(
                      'Bill Already Paid',
                      style: TextStyle(color: greenColor),
                    ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _razorpay.clear();
    super.dispose();
  }
}
