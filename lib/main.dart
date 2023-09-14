import 'package:client_itc/controller/analyis_controller.dart';
import 'package:client_itc/controller/clinic_controller.dart';
import 'package:client_itc/controller/firease_api.dart';
import 'package:client_itc/controller/lab_controller.dart';
import 'package:client_itc/controller/make_appointment_controller.dart';
import 'package:client_itc/model/profile.dart';
import 'package:client_itc/view/screen/abbpar_bottom.dart';
import 'package:client_itc/view/screen/auth/login.dart';
import 'package:client_itc/view/screen/auth/signup_screen.dart';
import 'package:client_itc/view/screen/clinic/home_screen_clinic.dart';
import 'package:client_itc/view/screen/clinic/make_appointment_clinic.dart';
import 'package:client_itc/view/screen/home_page_lab.dart';
import 'package:client_itc/view/screen/home_screen_nlysis.dart';
import 'package:client_itc/view/screen/home_secreen_radial.dart';
import 'package:client_itc/view/screen/make_appointmment_lab.dart';
import 'package:client_itc/view/screen/onBoardScreen.dart';
import 'package:client_itc/view/screen/pending.dart';
import 'package:client_itc/view/screen/profile/edit_profile.dart';
import 'package:client_itc/view/screen/profile/myprofil.dart';
import 'package:client_itc/view/screen/select_type.dart';
import 'package:client_itc/view/screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/auth_controller.dart';
import 'controller/rey_x_controller.dart';

int introViewed = 0;
final auth = Auth();
final profil = Profile();
final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotification();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("onBoard")) {
    introViewed = prefs.getInt("onBoard")!;
    print("fsdakljlfsdkja ${introViewed}");
  } else {
    introViewed = 0;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(create: (_) => auth),
        ChangeNotifierProvider<InfoAnalyisProvider>(
            create: (_) => InfoAnalyisProvider()),
        ChangeNotifierProxyProvider<Auth, Profile>(
          create: (_) => profil,
          update: (_, authModel, previousprofile) {
            print("fsafdsfdasdaf ${authModel.ownerId}");
            previousprofile!.idS = authModel.ownerId as int?;
            return previousprofile;
          },
        ),
        ChangeNotifierProvider<InfoAnalyisProvider>(
            create: (_) => InfoAnalyisProvider()),
        ChangeNotifierProvider<InfoRayXProvider>(
            create: (_) => InfoRayXProvider()),
        ChangeNotifierProvider<LabProvider>(
            create: (_) => LabProvider()),
         ChangeNotifierProvider<ClinicProvider>(
            create: (_) => ClinicProvider()),
             ChangeNotifierProvider<MakeAppointmentProvider>(
            create: (_) => MakeAppointmentProvider()),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Client Itc',
          home: auth.isAuth
              ? const SelectType()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) {
                    if (authResultSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const SplashScreen();
                    } else {
                      print("dfasfddsafdfs${auth.isAuth}");
                      if (auth.isAuth) {
                        return AbbParBottom();
                      } else {
                        return const LoginPage();
                      }
                    }
                  },
                ),
          initialRoute: introViewed == 0
              ? OnBoardingScreen.routeName
              : LoginPage.routeName,
          routes: {
            LoginPage.routeName: (ctx) => const LoginPage(),
            SignUpPage.routeName: (ctx) => const SignUpPage(),
            SelectType.routeName: (ctx) => const SelectType(),
            OnBoardingScreen.routeName: (ctx) => OnBoardingScreen(),
            MainProfileScreen.routeName: (ctx) => const MainProfileScreen(),
            EditProfile.routeName: (ctx) => const EditProfile(),
            OrdersPending.routeName: (ctx) => const OrdersPending(),
            HomeScreenN.routeName: (ctx) => const HomeScreenN(),
            HomeScreenC.routeName: (ctx) => const HomeScreenC(),
            HomeScreenR.routeName: (ctx) => const HomeScreenR(),
            HomeSecreenLab.routeName: (ctx) => const HomeSecreenLab(),
            MakeAppointmentClinicSecreen.routeName: (ctx) => const MakeAppointmentClinicSecreen(),
            MakeAppointmentLabSecreen.routeName: (ctx) => const MakeAppointmentLabSecreen(),
            AbbParBottom.routeName: (ctx) =>  AbbParBottom(),
          },
        ),
      ),
    );
  }
}
