import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:neyasis_case/helpers/date_helper.dart';
import 'package:neyasis_case/models/account.dart';
import 'package:neyasis_case/net/network_manager.dart';
import 'package:neyasis_case/screens/account_detail/account_detail_viewmodel.dart';
import 'package:neyasis_case/services/account_service.dart';

import 'account_listviewmodel_test.dart';

void main() {
  late AccountDetailViewModel sut;
  late MockAccountService mockAccountService;
  setUp(() {
    mockAccountService = MockAccountService();
    sut = AccountDetailViewModel(mockAccountService);
    NetworkManager.instance!
        .setBaseApiUrl("https://638e02774190defdb753a91e.mockapi.io");
  });

  test("initial values are correct", () {
    expect(sut.selectedAccount, null);
    expect(sut.isLoading, false);
    expect(sut.isUpdating, false);
    expect(sut.nameTextEditingController.text, "");
    expect(sut.surnameTextEditingController.text, "");
    expect(sut.salaryTextEditingController.text, "");
    expect(sut.phoneNumberTextEditingController.text, "");
    expect(sut.birthDateTextEditingController.text, "");

    expect(sut.nameInputErrorText, null);
    expect(sut.surnameInputErrorText, null);
    expect(sut.salaryInputErrorText, null);
    expect(sut.phoneNumberInputErrorText, null);
    expect(sut.identityInputErrorText, null);
  });

  group("Account Detail", () {
    final account = Account()
      ..id = "30"
      ..birthDate = DateHelper.stringToDate("1996-09-23")
      ..identity = "melihdikmen"
      ..name = "Melih"
      ..surname = "Dikmen"
      ..phoneNumber = "905455639258"
      ..sallary = 5000;

    void arrangeAccountDetailServiceReturns() {
      when(
        () => mockAccountService.getAccountDetail(account),
      ).thenAnswer((_) async => account);
    }

    test("getAccountDetails called test", () async {
      arrangeAccountDetailServiceReturns();
      await sut.getAccountDetail(account);
      verify(() => mockAccountService.getAccountDetail(account)).called(1);
    });

    test("getAccountDetails function test ", () async {
      arrangeAccountDetailServiceReturns();
      final getAccountDetail = sut.getAccountDetail(account);
      expect(sut.isLoading, true);
      await getAccountDetail;
      expect(sut.isLoading, false);
      expect(sut.nameTextEditingController.text, account.name);
      expect(sut.surnameTextEditingController.text, account.surname);
      expect(sut.salaryTextEditingController.text, account.sallary.toString());
      expect(sut.phoneNumberTextEditingController.text, account.phoneNumber);
      expect(sut.identityTextEditingController.text, account.identity);
      expect(sut.selectedAccount, account);
      expect(DateHelper.stringToDate(sut.birthDateTextEditingController.text),
          account.birthDate);
    });

    test("verify inputs if there are any empty input", () {
      sut.nameTextEditingController.text = account.name!;
      sut.surnameTextEditingController.text = account.surname!;
      sut.salaryTextEditingController.text = account.sallary.toString();
      sut.phoneNumberTextEditingController.text = account.phoneNumber!;
      // sut.identityTextEditingController.text  = account.identity!;
      final response = sut.verifyInputs();

      expect(response, false);
    });

    test("verify inputs if there are no empty input", () {
      sut.nameTextEditingController.text = account.name!;
      sut.surnameTextEditingController.text = account.surname!;
      sut.salaryTextEditingController.text = account.sallary.toString();
      sut.phoneNumberTextEditingController.text = account.phoneNumber!;
      sut.identityTextEditingController.text = account.identity!;
      final response = sut.verifyInputs();

      expect(response, true);
    });

    test("updateAccountDetail ", () async{
      //  when(
      //   () => mockAccountService.updateAccount(account),
      // ).thenAnswer((_) async => account);

     final accountDetailViewModel = AccountDetailViewModel(AccountService());
      
      accountDetailViewModel.nameTextEditingController.text = account.name!;
      accountDetailViewModel.surnameTextEditingController.text = account.surname!;
      accountDetailViewModel.salaryTextEditingController.text = account.sallary.toString();
      accountDetailViewModel.phoneNumberTextEditingController.text = account.phoneNumber!;
      accountDetailViewModel.identityTextEditingController.text = account.identity!;
      accountDetailViewModel.birthDateTextEditingController.text = account.birthDate.toString();
      accountDetailViewModel.selectedAccount = account;
      final updateAccount = accountDetailViewModel.updateAccount();
      expect(accountDetailViewModel.isUpdating, true);
      await updateAccount;
      expect(accountDetailViewModel.isUpdating, false);


    });
  });
}
