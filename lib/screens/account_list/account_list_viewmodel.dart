import 'package:flutter/material.dart';
import 'package:neyasis_case/models/account.dart';
import 'package:neyasis_case/services/account_service.dart';

class AccountListViewModel extends ChangeNotifier {
  List<Account> accounts = [];
  bool isLoading = false;
  int page = 1;

  Future<void> getAccounts() async {
    isLoading = true;

    AccountService accountService = AccountService();

    var response = await accountService.getAccounts();

    if (response != null) {
      accounts = response;
    } else {
      //TODO show error
    }

    isLoading = false;
  }

  Future<List<Account>> pageFetch(int currentListSize) async {
    if (accounts.isEmpty) {
      await getAccounts();
    }

    page = (currentListSize / 20).round();

    if (accounts.isNotEmpty) {
      if (currentListSize + 1 >= accounts.length) {
        return Future.value([]);
      } else {
        List<Account> nextAccountList = [];
        for (var i = 0; i < 20; i++) {
          if (i + currentListSize < accounts.length) {
            nextAccountList.add(accounts[i + currentListSize]);
          }
        }

        // final List<Account> nextAccountList = List.generate(
        //   20,
        //   (int index) => accounts[index + currentListSize],
        // );

        return nextAccountList;
      }
    } else {
      return Future.value([]);
    }
  }
}
