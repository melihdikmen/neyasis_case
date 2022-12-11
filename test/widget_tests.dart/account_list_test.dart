import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:neyasis_case/extensions/string_extensions.dart';
import 'package:neyasis_case/helpers/date_helper.dart';
import 'package:neyasis_case/home.dart';
import 'package:neyasis_case/models/account.dart';
import 'package:neyasis_case/net/network_manager.dart';
import 'package:neyasis_case/screens/account_list/account_list.dart';
import 'package:neyasis_case/screens/account_list/account_list_viewmodel.dart';
import 'package:neyasis_case/services/account_service.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockAccountService extends Mock implements AccountService {}

void main() {
  late MockAccountService mockAccountService;

  setUp(() {
    mockAccountService = MockAccountService();
    NetworkManager.instance!
        .setBaseApiUrl("https://638e02774190defdb753a91e.mockapi.io");
  });

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
              create: (context) => AccountListViewModel(mockAccountService),
              child: const AccountList(),
            ),
          );
        }));
  }

  final accountsFromService = [
    Account()
      ..id = "1"
      ..birthDate = DateHelper.stringToDate("1996-09-23")
      ..identity = "melihdikmen"
      ..name = "Melih"
      ..surname = "Dikmen"
      ..phoneNumber = "5455639258"
      ..sallary = 5000,
    Account()
      ..id = "1"
      ..birthDate = DateHelper.stringToDate("1996-09-12")
      ..identity = "muhittinkaya"
      ..name = "Muhittin "
      ..surname = "Kaya"
      ..phoneNumber = "5385639253"
      ..sallary = 5000,
    Account()
      ..id = "1"
      ..birthDate = DateHelper.stringToDate("1996-09-12")
      ..identity = "John Doe"
      ..name = "John "
      ..surname = "Doe"
      ..phoneNumber = "5386544531"
      ..sallary = 5000
  ];

  void arrangeAccountServiceReturns3Accounts() {
    when(
      () => mockAccountService.getAccounts(),
    ).thenAnswer((_) async {
      return accountsFromService;
    });
  }

   void arrangeAccountServiceReturnEmpty() {
    when(
      () => mockAccountService.getAccounts(),
    ).thenAnswer((_) async {
      return [];
    });
  }

  testWidgets("title displayed", (WidgetTester tester) async {
    arrangeAccountServiceReturns3Accounts();

    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.text("Account List"), findsOneWidget);
  });

  testWidgets("Buttons displayed",
      (WidgetTester tester) async {
    arrangeAccountServiceReturns3Accounts();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.byKey(Key("icon_add")), findsOneWidget);
    expect(find.byKey(Key("icon_delete")), findsWidgets);
  });

  testWidgets("accounts displayed", (WidgetTester tester) async {
    arrangeAccountServiceReturns3Accounts();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
    
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();
    for (Account element in accountsFromService) {
        expect(find.text(element.name!), findsOneWidget);
    } 
    
  });



    testWidgets("if there is no data empty widget displayed", (WidgetTester tester) async {
    arrangeAccountServiceReturnEmpty();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
    
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

      expect(find.text("emptyList".locale),findsOneWidget );
    
  });
}
