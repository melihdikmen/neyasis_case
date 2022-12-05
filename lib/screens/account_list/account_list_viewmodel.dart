import 'package:flutter/material.dart';
import 'package:neyasis_case/models/account.dart';
import 'package:neyasis_case/services/account_service.dart';

class AccountListViewModel extends ChangeNotifier {
  List<Account> accounts = [];
  bool isLoading = false;

  void getAccounts() async {
    isLoading = true;
     notifyListeners();
    AccountService accountService = AccountService();

    var response = await accountService.getAccounts();

    if (response != null) {
      accounts = response;
    } else {
      //TODO show error
    }

    isLoading = false;

    notifyListeners();
  }
}
