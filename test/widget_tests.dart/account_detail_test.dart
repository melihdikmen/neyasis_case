import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:neyasis_case/helpers/date_helper.dart';
import 'package:neyasis_case/models/account.dart';
import 'package:neyasis_case/net/network_manager.dart';
import 'package:neyasis_case/screens/account_detail/account_detail.dart';
import 'package:neyasis_case/screens/account_detail/account_detail_viewmodel.dart';
import 'package:neyasis_case/services/account_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../unit_test/account_listviewmodel_test.dart';

class MockAccountService extends Mock implements AccountService {}

void main() {
  late MockAccountService mockAccountService;
  setUp(() {
    mockAccountService = MockAccountService();
    NetworkManager.instance!
        .setBaseApiUrl("https://638e02774190defdb753a91e.mockapi.io");
  });

  Account account =  Account()
      ..id = "1"
      ..birthDate = DateHelper.stringToDate("1996-09-23")
      ..identity = "melihdikmen"
      ..name = "Melih"
      ..surname = "Dikmen"
      ..phoneNumber = "5455639258"
      ..sallary = 5000;
   
    
   

  Widget createWidgetUnderTest() {
    return EasyLocalization(
        path: 'assets/translations',
        supportedLocales: const [Locale('en'), Locale('tr')],
        fallbackLocale: const Locale('tr'),
        child: Builder(builder: (context) {
          return MaterialApp(
            title: 'Flutter Demo',
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: ThemeData(
              primarySwatch: Colors.red,
            ),
            home: ChangeNotifierProvider(
              create: (context) => AccountDetailViewModel(mockAccountService),
              child: AccountDetail(
                selectedAccount: account
              ),
            ),
          );
        }));
  }

  void arrangeAccountServiceReturn() {
    when(
      () => mockAccountService.getAccountDetail(account)
    ).thenAnswer((_) async {
      return account;
    });
  }


   testWidgets("title displayed", (WidgetTester tester) async {
    arrangeAccountServiceReturn();

    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.text("Account Detail"), findsOneWidget);
  });

  testWidgets("input values displayed", (WidgetTester tester) async {
    arrangeAccountServiceReturn();

    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.text("Melih"), findsOneWidget);
    expect(find.text("Dikmen"), findsOneWidget);
    expect(find.text("5455639258"), findsOneWidget);
    expect(find.text("5000.0"), findsOneWidget);
    expect(find.text("melihdikmen"), findsOneWidget);
    expect(find.textContaining("1996-09-23"), findsOneWidget);
    expect(find.byKey(const Key("update_button")), findsOneWidget);
    
  });



    testWidgets("inputs displayed", (WidgetTester tester) async {
    arrangeAccountServiceReturn();

    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.byKey( const Key("name_input")), findsOneWidget);
    expect(find.byKey( const Key("surname_input")), findsOneWidget);
    expect(find.byKey( const Key("salary_input")), findsOneWidget);
    expect(find.byKey( const Key("phone_number_input")), findsOneWidget);
    expect(find.byKey( const Key("identity_input")), findsOneWidget);


    
  
    
  });

}
