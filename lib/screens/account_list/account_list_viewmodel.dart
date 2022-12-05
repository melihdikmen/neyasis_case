import 'package:flutter/material.dart';
import 'package:neyasis_case/models/account.dart';

class AccountListViewModel extends ChangeNotifier {
  List<Account> accounts = [new Account()..name = "Melih"..surname="Dikmen" ];
  bool isLoading = false;
}
