import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neyasis_case/extensions/string_extensions.dart';
import '../../models/account.dart';
import '../../services/account_service.dart';
import 'package:pagination_view/pagination_view.dart';

class AccountListViewModel extends ChangeNotifier {
  AccountListViewModel(this.accountService);

  List<Account> accounts = [];
  bool isLoading = false;
  int page = 1;
  Map<String, bool> deletetingStates = {};
  BuildContext? context;
  final AccountService accountService;

  void setContext(BuildContext context) => this.context = context;

  Future<void> getAccounts() async {
    isLoading = true;

    var response = await accountService.getAccounts();

    if (response != null) {
      accounts = response;
      for (var e in accounts) {
        deletetingStates[e.id!] = false;
      }
    } else {
      Fluttertoast.showToast(msg: "dateGetError".locale);
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

        return nextAccountList;
      }
    } else {
      return Future.value([]);
    }
  }

  Future<bool> deleteAccount(
      Account account, GlobalKey<PaginationViewState> key) async {
    AccountService accountService = AccountService();
    deletetingStates[account.id!] = true;
    bool result = false;
    notifyListeners();
    Account? response = await accountService.deleteAccount(account);

    if (response != null) {
      accounts = [];
      notifyListeners();
      if (key is PaginationViewState) key.currentState!.refresh();
      result = true;
    } else {
      result = false;
    }

    deletetingStates[account.id!] = false;
    notifyListeners();
    return result;
  }
}
