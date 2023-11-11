// import 'package:flutter/material.dart';
// import 'package:motox/presentation/screens/confirmed/screen_confirmed.dart';
// import 'package:motox/presentation/screens/slot_selection/widgets/service_selection.grid.dart';
// import 'package:motox/presentation/widgets/large_button.dart';
// import 'package:motox/utils/constants/text_styles.dart';

// void buildBottomSheet(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     builder: (context) {
//       return Container(
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Add Extra Service',
//                 style: TextStyles.subheadingBlack,
//               ),
//               buildServiceSelectionGrid(),
//               LargeButton(
//                 context: context,
//                 onTap: () {
//                   // Navigator.push(
//                   //     context,
//                   //     MaterialPageRoute(
//                   //       builder: (context) => ConfirmedScreen(),
//                   //     ));
//                   Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ConfirmedScreen(),
//                       ),
//                       (route) => false);
//                 },
//                 text: 'Continue',
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
