
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:neyasis_case/helpers/date_helper.dart';
import 'package:neyasis_case/models/account.dart';
import 'package:neyasis_case/net/network_manager.dart';
import 'package:neyasis_case/screens/account_list/account_list_viewmodel.dart';
import 'package:neyasis_case/services/account_service.dart';

class MockAccountService extends Mock implements AccountService {}

void main() {
  late AccountListViewModel sut;
  late MockAccountService mockAccountService;
  setUp(() {
    mockAccountService = MockAccountService();
    sut = AccountListViewModel(mockAccountService);
    NetworkManager.instance!
        .setBaseApiUrl("https://638e02774190defdb753a91e.mockapi.io");
  });

  test("initial values are correct", () {
    expect(sut.accounts, []);
    expect(sut.isLoading, false);
  });

  group("getAccounts", () {

    final accountsFromService = [ Account()
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
              ..sallary = 5000];


    void arrangeAccountServiceReturns3Accounts() {
      when(
        () => mockAccountService.getAccounts(),
      ).thenAnswer((_) async => accountsFromService);
    }

    test("gets accounts using account service", () async {
      arrangeAccountServiceReturns3Accounts();
      await sut.getAccounts();
      verify(() => mockAccountService.getAccounts()).called(1);
    });

    test("set accounts", () async {
      arrangeAccountServiceReturns3Accounts();
      final getAccounts = sut.getAccounts();
      expect(sut.isLoading, true);
      await getAccounts;
      expect(sut.accounts, accountsFromService);
      expect(sut.isLoading, false);
    });
  });


  group("delete account", (){
    final Account deleteAccount  = Account()..id = "3";

    test("delete account using account service ", ()async {
      when(()=>mockAccountService.deleteAccount(deleteAccount)).thenAnswer((_) async=> deleteAccount);
     final deleteAccountEvent =   sut.deleteAccount(deleteAccount, GlobalKey());
      expect(sut.deletetingStates[deleteAccount.id], true);
      bool result = await deleteAccountEvent;
      expect(result,false);
      expect(sut.deletetingStates[deleteAccount.id], false);
    });
  });


}
