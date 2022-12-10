import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neyasis_case/extensions/string_extensions.dart';

import '../../helpers/date_helper.dart';
import '../../models/account.dart';
import '../../services/account_service.dart';

class AddAccountViewModel extends ChangeNotifier {
  AddAccountViewModel(this.accountService);
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
  final AccountService accountService;

  Future<void> addAccount() async {
    if (verifyInputs()) {
      isUpdating = true;
      notifyListeners();
      Account? response = await accountService.addAccount(Account()
        ..name = nameTextEditingController.text
        ..surname = surnameTextEditingController.text
        ..sallary = double.parse(salaryTextEditingController.text)
        ..phoneNumber = phoneNumberTextEditingController.text
        ..identity = identityTextEditingController.text
        ..birthDate =
            DateHelper.stringToDate(birthDateTextEditingController.text));

      if (response != null) {
      } else {
        Fluttertoast.showToast(msg: "addAccountError".locale);
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

  void clearInputs() {
    nameTextEditingController.text = "";
    surnameTextEditingController.text = "";
    salaryTextEditingController.text = "";
    phoneNumberTextEditingController.text = "";
    phoneNumberTextEditingController.text = "";
    birthDateTextEditingController.text = "";
  }
}
