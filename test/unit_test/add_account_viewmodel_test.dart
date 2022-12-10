import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:neyasis_case/helpers/date_helper.dart';
import 'package:neyasis_case/models/account.dart';
import 'package:neyasis_case/net/network_manager.dart';
import 'package:neyasis_case/screens/account_detail/account_detail_viewmodel.dart';
import 'package:neyasis_case/screens/add_account/add_account.dart';
import 'package:neyasis_case/screens/add_account/add_account_viewmodel.dart';
import 'package:neyasis_case/services/account_service.dart';

import 'account_listviewmodel_test.dart';

void main() {
  late AddAccountViewModel sut;
  late MockAccountService mockAccountService;
  setUp(() {
    mockAccountService = MockAccountService();
    sut = AddAccountViewModel(mockAccountService);
    NetworkManager.instance!
        .setBaseApiUrl("https://638e02774190defdb753a91e.mockapi.io");
  });

  test("initial values are correct", () {
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
      ..birthDate = DateHelper.stringToDate("1996-09-23")
      ..identity = "melihdikmen"
      ..name = "Melih"
      ..surname = "Dikmen"
      ..phoneNumber = "905455639258"
      ..sallary = 5000;

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

    test("addAccount ", () async {
      final accountDetailViewModel = AddAccountViewModel(AccountService());

      accountDetailViewModel.nameTextEditingController.text = account.name!;
      accountDetailViewModel.surnameTextEditingController.text =
          account.surname!;
      accountDetailViewModel.salaryTextEditingController.text =
          account.sallary.toString();
      accountDetailViewModel.phoneNumberTextEditingController.text =
          account.phoneNumber!;
      accountDetailViewModel.identityTextEditingController.text =
          account.identity!;
      accountDetailViewModel.birthDateTextEditingController.text =
          account.birthDate.toString();

      final addAccount = accountDetailViewModel.addAccount();
      expect(accountDetailViewModel.isUpdating, true);
      await addAccount;
      expect(accountDetailViewModel.isUpdating, false);
    });
  });
}
