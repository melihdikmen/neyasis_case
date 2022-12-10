import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neyasis_case/extensions/string_extensions.dart';
import 'package:neyasis_case/helpers/date_helper.dart';
import 'package:neyasis_case/models/account.dart';
import 'package:neyasis_case/services/account_service.dart';

class AccountDetailViewModel extends ChangeNotifier {
  AccountDetailViewModel(this.accountService);
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController surnameTextEditingController = TextEditingController();
  TextEditingController salaryTextEditingController = TextEditingController();
  TextEditingController phoneNumberTextEditingController =
      TextEditingController();
  TextEditingController identityTextEditingController = TextEditingController();
  TextEditingController birthDateTextEditingController =
      TextEditingController();

  String? nameInputErrorText;
  String? surnameInputErrorText;
  String? salaryInputErrorText;
  String? phoneNumberInputErrorText;
  String? identityInputErrorText;

  bool isUpdating = false;
  bool isLoading = false;

  Account? selectedAccount;
  final AccountService accountService;

  Future<void> getAccountDetail(Account account) async {
    
    isLoading = true;
    notifyListeners();
    Account? response = await accountService.getAccountDetail(account);
    selectedAccount = account;
    if (response != null) {
      nameTextEditingController.text = response.name!;
      surnameTextEditingController.text = response.surname!;
      salaryTextEditingController.text = response.sallary!.toString();
      phoneNumberTextEditingController.text = response.phoneNumber.toString();
      identityTextEditingController.text = response.identity.toString();
      birthDateTextEditingController.text = response.birthDate.toString();
    } else {
      Fluttertoast.showToast(msg: "dateGetError".locale);
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> updateAccount() async {
    if (verifyInputs()) {
      isUpdating = true;
      notifyListeners();
      Account? response = await accountService.updateAccount(Account()
        ..name = nameTextEditingController.text
        ..surname = surnameTextEditingController.text
        ..sallary = double.parse(salaryTextEditingController.text)
        ..phoneNumber = phoneNumberTextEditingController.text
        ..identity = identityTextEditingController.text
        ..id = selectedAccount!.id
        ..birthDate = DateHelper.stringToDate(birthDateTextEditingController.text));

      if (response != null) {
      } else {
         Fluttertoast.showToast(msg: "dateGetError".locale);
      }
      isUpdating = false;
      notifyListeners();
    }
    notifyListeners();
  }

  bool verifyInputs() {
    bool isValid = true;
    if (nameTextEditingController.text.isEmpty) {
      nameInputErrorText = "nameRequired".locale;
      isValid = false;
    }
    if (surnameTextEditingController.text.isEmpty) {
      surnameInputErrorText = "surnameRequired".locale;
      isValid = false;
    }
    if (salaryTextEditingController.text.isEmpty) {
      salaryInputErrorText = "salaryRequired".locale;
      isValid = false;
    }
    if (phoneNumberTextEditingController.text.isEmpty) {
      phoneNumberInputErrorText = "phonenumberRequired".locale;
      isValid = false;
    }
    if (identityTextEditingController.text.isEmpty) {
      identityInputErrorText = "identityRequired".locale;
      isValid = false;
    }

    return isValid;
  }
}
