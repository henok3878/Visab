import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/bindings/home_binding.dart';
import 'package:tourist_guide/data/shared_preference.dart';
import 'package:tourist_guide/ui/pages/dashboard_page.dart';
import 'package:tourist_guide/ui/pages/guide_home.dart';
import 'package:tourist_guide/ui/pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //SharedPreferenceUtil.changeUserSessionStatus("");
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
        initialBinding: HomePageBinding(),
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: "Visab") //MyHomePage(title: 'Visab'),
        );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({required this.title});

  @override
  Widget build(BuildContext context) {
    //return DashboardPage();
    return FutureBuilder<String>(
        future: SharedPreferenceUtil.getUserSessionStatus(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Scaffold(
                  body: Center(
                child: CircularProgressIndicator(),
              ));
            case ConnectionState.done:
              return decidePageBasedOnUserStatus(snapshot);
            default:
              return Scaffold(
                  body: Center(
                child: CircularProgressIndicator(),
              ));
          }
        });
  }
}

Widget decidePageBasedOnUserStatus(AsyncSnapshot<String> snapshot) {
  /*Possible user statuses : initial - for the first time
        logged_in and logged_out
  * */
  if (snapshot.hasData) {
    String currentStatus = snapshot.data!;
    print("Current user status : $currentStatus}");
    if (currentStatus == SharedPreferenceUtil.loggedIn) {
      return FutureBuilder<String>(
          future: SharedPreferenceUtil.getUserType(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.done:
                print("user type ");
                return decidePageBasedOnUserType(snapshot);
              default:
                return Scaffold(
                    body: Center(
                  child: CircularProgressIndicator(),
                ));
            }
          });
    } else if(currentStatus == SharedPreferenceUtil.initial){
      return LoginPage(); // beta's code here
    }
    else{
      // for logged_out case
      return LoginPage();
    }
  } else {
    return Scaffold(
        body: Center(
          child: Text("Error"),
        ));
  }
}

Widget decidePageBasedOnUserType(AsyncSnapshot<String> snapshot) {
  if (snapshot.hasData) {
    /*Possible user status : tourist and guide */
    String userType = snapshot.data!;
    print("userType : $userType");
    if (userType == SharedPreferenceUtil.guideType){
      return GuideHome();
    }
    else if (userType == SharedPreferenceUtil.touristType){
      return DashboardPage();
    }else{
      return LoginPage();
    }

  }
  else{
    return Center(
      child: CircularProgressIndicator(),
    );
  }

}
