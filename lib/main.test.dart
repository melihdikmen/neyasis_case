import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:neyasis_case/home.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('en'), Locale('tr')],
      child: const Home(baseApiUrl: "https://638e02774190defdb753a91e.mockapi.io",)));
}


