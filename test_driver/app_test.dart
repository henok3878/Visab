// @dart= 2.8


import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:path/path.dart';
import 'package:test/test.dart';

void main() {
  group('Visab User', () {

    //login screen
    final emailField = find.byValueKey('Email');
    final passwordField = find.byValueKey('Password');
    final signInButton = find.byValueKey("Login");

   /* //home screen
   final searchButton = find.byValueKey("search_icon");
    final homeIcon = find.byValueKey("Home");
    final favoriteIcon = find.byValueKey("Icon");
    final accountIcon = find.byValueKey("Me");
    final appBarTitle = find.byValueKey("app_bar_title");*/

    FlutterDriver driver;

    Future<bool> isPresent(SerializableFinder byValueKey,
        {Duration timeout = const Duration(seconds: 1)}) async {
      try {
        await driver.waitFor(byValueKey, timeout: timeout);
        return true;
      } catch (exception) {
        return false;
      }
    }

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
     /* final Map<String, String> envVars = Platform.environment;
      print("EnvVars : $envVars");
      final adbPath = join(
        envVars['ANDROID_SDK_ROOT'] ?? envVars['ANDROID_SDK_HOME'] ?? envVars['ANDROID_HOME'],
        'platform-tools',
        Platform.isWindows ? 'adb.exe' : 'adb',
      );
      await Process.run(adbPath , ['shell' ,'pm', 'grant', 'com.example.tourist_guide', 'android.permission.ACCESS_FINE_LOCATION']);
*/
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

  /*  test('create account', () async {
      if (await isPresent(signOutButton)) {
        await driver.tap(signOutButton);
      }

      await driver.tap(usernameField);
      await driver.enterText("tadas1@gmail.com");

      await driver.tap(passwordField);
      await driver.enterText("123456");

      await driver.tap(createAccountButton);
      await driver.waitFor(find.text("Your Todos"));
    });*/

    test('login', () async {
      await driver.tap(emailField);
      await driver.enterText("henokwondimu3878@gmail.com");
      await driver.tap(passwordField);
      await driver.enterText("123456");
      await driver.tap(signInButton);
      await driver.runUnsynchronized(() async {
        await driver.waitFor(find.text("Home"));
      });

    });


    
    /*
    // this function tests search -> click on result ->
    test('search', () async {
      *//* if (await isPresent(signOutButton)) {
        await driver.tap(signOutButton);
      }*//*
      await driver.runUnsynchronized(() async {
        await driver.waitFor(find.byType("BottomNavigationBar"));
        await driver.tap(find.byValueKey("search_icon"));
        //final searchField = find.byValueKey('search_field');
        await driver.tap(find.byValueKey("search_field"));
        await driver.enterText("Holy trinity");
       // await driver.waitFor(find.text("Holy Trinity Cathedral, Addis Ababa, Ethiopia"));
        //await driver.waitFor(find.byValueKey("search_results"));
        await driver.tap(find.byValueKey(0));
        await driver.tap(find.text("Overview"));
      });
    });*/


    /*
    // this function tests navigating to account page -> to edit profile
    test('Account navigation', () async {
      *//* if (await isPresent(signOutButton)) {
        await driver.tap(signOutButton);
      }*//*
      await driver.runUnsynchronized(() async {
        await driver.waitFor(find.byType("BottomNavigationBar"));
        await driver.tap(find.text("Me"));
        await driver.tap(find.byValueKey("edit_profile"));
        await driver.waitFor(find.text("Edit Profile"));
       *//* await driver.tap(find.byValueKey(0));
        await driver.tap(find.text("Overview"));*//*
      });
    });*/


    /*
    //this function tests navigating to favorite -> hotels -> click on the first favorite hotel
    test('Favorites hotels navigation', () async {
      *//* if (await isPresent(signOutButton)) {
        await driver.tap(signOutButton);
      }*//*
      await driver.runUnsynchronized(() async {
        await driver.waitFor(find.byType("BottomNavigationBar"));
        await driver.tap(find.text("Favorites"));
        await driver.tap(find.text("Hotels"));
        await driver.tap(find.byValueKey(0));
        await driver.waitFor(find.text("Location"));

      });
    });*/


   /* // this function tests navigation to attraction details
    test('Home attractions navigation', () async {
      await driver.runUnsynchronized(() async {
        await driver.waitFor(find.byType("BottomNavigationBar"));
        await driver.tap(find.text("Lion of Judah Statue"));
        await driver.tap(find.text("Find a Guide"));
        await driver.waitFor(find.text("Guides"));

      });
    });*/


    // this function tests city -> attraction inside city -> find a guide -> click on a guide -> click on phone number
    test('Home destinations navigation', () async {
      await driver.runUnsynchronized(() async {
        await driver.waitFor(find.byType("BottomNavigationBar"));
        await driver.tap(find.text("Jimma"));
        await Future.delayed(Duration(milliseconds: 500),(){});
        await driver.tap(find.byValueKey("Jimma Museum"));
        await Future.delayed(Duration(milliseconds: 500),(){});
        await driver.tap(find.text("Find a Guide"));
        await Future.delayed(Duration(milliseconds: 500),(){});
        await driver.tap(find.text("Abel"));
        await Future.delayed(Duration(milliseconds: 500),(){});
        await driver.tap(find.text("0990235689"));
      });
    });




  });
}


