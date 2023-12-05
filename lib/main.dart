import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motox/business%20logic/blocs/auth/auth_bloc.dart';
import 'package:motox/business%20logic/blocs/booking/booking_bloc.dart';
import 'package:motox/business%20logic/blocs/bottom_bar/bottom_bar_bloc.dart';
import 'package:motox/business%20logic/blocs/brand_selection/brand_selection_bloc.dart';
import 'package:motox/business%20logic/blocs/profile/profile_bloc.dart';
import 'package:motox/presentation/screens/splash/screen_splash.dart';
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
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => BottomBarBloc()),
        BlocProvider(create: (context) => BookingBloc()),
        BlocProvider(create: (context) => ProfileBloc()),
        BlocProvider(create: (context) => BrandSelectionBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MotoX',
        theme: ThemeData(
          fontFamily: GoogleFonts.montserrat().fontFamily,
        ),
        home: const ScreenSplash(),
        // StreamBuilder<User?>(
        //     stream: FirebaseAuth.instance.authStateChanges(),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData) {
        //         return LandingPage();
        //       }
        //       return const ScreenSplash();
        //     }),
      ),
    );
  }
}
