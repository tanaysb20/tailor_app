import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor_app/Providers/home_provider.dart';
import 'package:tailor_app/Screens/Auth%20screen/phone_screen.dart';
import 'package:tailor_app/Screens/landing_screen.dart';
import 'Providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.hourGlass
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
      ],
      child: ScreenUtilInit(
        builder: (context, child) {
          return MaterialApp(
            localizationsDelegates: const [
              MonthYearPickerLocalizations.delegate,
            ],
            home: NavigationScreen(),
            debugShowCheckedModeBanner: false,
            builder: EasyLoading.init(),
          );
        },
        designSize: const Size(412, 915),
      ),
    );
  }
}

class NavigationScreen extends StatefulWidget {
  NavigationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<NavigationScreen> {
  bool splash = false;
  void navigationPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("userToken");

    print("$token tanay123token");

    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      splash = true;
    });
    if (token == null) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const PhoneNumberScreen()));
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LandingScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    navigationPage();
  }

  @override
  Widget build(BuildContext context) {
    return splash
        ? Container()
        : Scaffold(
            body: Container(
              width: double.infinity,
              height: 915.h,
              child: SvgPicture.asset(
                "assets/splash.svg",
                fit: BoxFit.cover,
              ),
            ),
          );
  }
}
