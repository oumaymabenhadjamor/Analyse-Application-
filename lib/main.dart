
import 'package:analyse_app/screens/home.dart';

import 'package:analyse_app/providers/app.dart';
import 'package:analyse_app/providers/class.dart';
import 'package:analyse_app/providers/student.dart';

import 'package:analyse_app/providers/test.dart';
import 'package:analyse_app/providers/user.dart';
import 'package:analyse_app/screens/Register2.dart';

import 'package:analyse_app/screens/helloScreen.dart';
import 'package:analyse_app/screens/profileScreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:provider/provider.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppProvider()),
        ChangeNotifierProvider.value(value: UserProvider.initialize()),
        ChangeNotifierProvider.value(value: StudentProvider.initialize()),
        ChangeNotifierProvider.value(value: TestProvider.initialize()),
        ChangeNotifierProvider.value(value: ClassProvider.initialize()),


      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Diagnostic App',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: ScreensController())));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
    /* case Status.Uninitialized:
        return Splash();*/
      case Status.Unauthenticated:
      case Status.Authenticating:
      return HelloScreen();
      case Status.Authenticated:
        return  HomePage();
    //return ColorGame3();
      default:
        return HelloScreen();
    }
  }
}
