import 'dart:async';

import 'package:flutter/material.dart';
import 'package:neyasis_case/screens/account_list/account_list.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
        const Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const AccountList())));
    return Scaffold(
        body: Column(
      children: [
        Container(
            decoration:const  BoxDecoration(
                borderRadius: BorderRadius.all(
              Radius.circular(100),
            )),
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 5,
                right: 20,
                left: 20),
            alignment: Alignment.center,
            child: Image.asset(
              "assets/img/neyasis_logo.jpg",
            )),
        Container(
          margin:const  EdgeInsets.only(top:20),
          child: const CircularProgressIndicator())
      ],
    ));
  }
}
