import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:neyasis_case/net/network_manager.dart';
import 'package:neyasis_case/screens/account_detail/account_detail_viewmodel.dart';
import 'package:neyasis_case/screens/account_list/account_list_viewmodel.dart';
import 'package:neyasis_case/screens/add_account/add_account_viewmodel.dart';
import 'package:neyasis_case/screens/splash/splash_screen.dart';
import 'package:neyasis_case/services/account_service.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key, required this.baseApiUrl});
  
  final String baseApiUrl;
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    NetworkManager.instance!.setBaseApiUrl(baseApiUrl);
    
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AccountListViewModel>(
            create: (_) => AccountListViewModel(AccountService(),),
          ),
          ChangeNotifierProvider<AccountDetailViewModel>(
            create: (_) => AccountDetailViewModel(AccountService()),
          ),
            ChangeNotifierProvider<AddAccountViewModel>(
            create: (_) => AddAccountViewModel(AccountService()),
          )
        ],
        child: MaterialApp(
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
            primarySwatch: Colors.red,
          ),
          home: SplashScreen(),
        ));
  }
}