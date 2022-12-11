import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:neyasis_case/extensions/string_extensions.dart';
import 'package:neyasis_case/helpers/date_helper.dart';
import 'package:neyasis_case/models/account.dart';
import 'package:neyasis_case/net/network_manager.dart';
import 'package:neyasis_case/screens/account_detail/account_detail.dart';
import 'package:neyasis_case/screens/account_detail/account_detail_viewmodel.dart';
import 'package:neyasis_case/screens/add_account/add_account.dart';
import 'package:neyasis_case/screens/add_account/add_account_viewmodel.dart';
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

  Account account = Account()
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
              create: (context) => AddAccountViewModel(mockAccountService),
              child: const AddAccount(),
            ),
          );
        }));
  }

  testWidgets("title displayed", (WidgetTester tester) async {
    // arrangeAccountServiceReturn();

    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.text("Add Account"), findsWidgets);
  });

  testWidgets("inputs displayed", (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.byKey(const Key("name_input")), findsOneWidget);
    expect(find.byKey(const Key("surname_input")), findsOneWidget);
    expect(find.byKey(const Key("salary_input")), findsOneWidget);
    expect(find.byKey(const Key("phone_number_input")), findsOneWidget);
    expect(find.byKey(const Key("identity_input")), findsOneWidget);
  });

  testWidgets("error texts displayed", (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('add_button')));
    await tester.pump();

    expect(find.textContaining("Name input required"), findsOneWidget);
    expect(find.textContaining("Surname input required"), findsOneWidget);
    expect(find.textContaining("Salary input required"), findsOneWidget);
    expect(find.textContaining("Identity input required"), findsOneWidget);
    expect(find.textContaining("Phone number input required"), findsOneWidget);

  });
}
