import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motox/business%20logic/blocs/auth/auth_bloc.dart';
import 'package:motox/presentation/screens/onboard%20screen/screen_onboard.dart';
import 'package:motox/utils/colors/colors.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MotoX());
}

class MotoX extends StatelessWidget {
  const MotoX({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MotoX',
        theme: ThemeData(
          fontFamily: GoogleFonts.montserrat().fontFamily,
        ),
        home: OnBoardScreen(),
      ),
    );
  }
}
