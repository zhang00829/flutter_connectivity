import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import 'home_view.dart';
import 'no_connectivity_view.dart';

void main() => runApp(MyApp());

final GlobalKey<NavigatorState> nav = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription connectivitySubscription;
  ConnectivityResult _previousResult;

  @override
  void initState() {
    super.initState();

    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      print(connectivityResult.toString());

      Future.delayed(Duration(seconds: 1), _navToOpps);
    });
  }
  _navToOpps() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      nav.currentState.pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) {
        return NoConnectivityView();
      }),(router)=>router==null);
    }else if(_previousResult==ConnectivityResult.none){
      nav.currentState.pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) {
            return HomeView();
          }),(router)=>router==null);
    }
    _previousResult= result;
  }

  @override
  void dispose() {
    print('dispose');
    super.dispose();
    connectivitySubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: nav,
      title: 'My app',
      home: HomeView(),
    );
  }
}
