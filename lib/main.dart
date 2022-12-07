import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:neyasis_case/screens/account_list/account_list.dart';
import 'package:neyasis_case/screens/account_list/account_list_viewmodel.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('en'),Locale('tr')],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider<AccountListViewModel>(
              create: (_) => AccountListViewModel(),
            )
          ],
          child: const AccountList(),
        ));
  }
}
