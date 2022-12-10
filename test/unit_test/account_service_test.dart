import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:neyasis_case/helpers/date_helper.dart';
import 'package:neyasis_case/models/account.dart';
import 'package:neyasis_case/net/network_manager.dart';
import 'package:neyasis_case/services/account_service.dart';

void main() {
  late AccountService accountService;

  setUp(() {
    accountService = AccountService();
    NetworkManager.instance!
        .setBaseApiUrl("https://638e02774190defdb753a91e.mockapi.io");
  });

  test("getAccount Service Test", () async {
    bool isPassed = false;
    final response = await accountService.getAccounts();

    if (response is List<Account>) {
      isPassed = true;
    }

    expect(isPassed, true);
  });

  test("deleteAccount Service Test", () async {
    bool isPassed = false;
    final response = await accountService.deleteAccount(Account()..id = "10");

    // if  given id does not exist test will not success

    if (response is Account) {
      isPassed = true;
    }

    expect(isPassed, true);
  });

  test("getAccountDetail Service Test", () async {
    bool isPassed = false;
    final response =
        await accountService.getAccountDetail(Account()..id = "30");

    if (response is Account) {
      isPassed = true;
    }

    expect(isPassed, true);
  });

  test("updateAccount  Service Test", () async {
    bool isPassed = false;
    final updateAccount = Account()
      ..id = "30"
      ..birthDate = DateHelper.stringToDate("1996-09-23")
      ..identity = "melihdikmen"
      ..name = "Melih"
      ..surname = "Dikmen"
      ..phoneNumber = "905455639258"
      ..sallary = 5000;

    final response = await accountService.updateAccount(updateAccount);

    if (response is Account) {
      isPassed = true;
    }

    expect(isPassed, true);
  });
}
