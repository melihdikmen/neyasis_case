import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:neyasis_case/extensions/string_extensions.dart';
import 'package:neyasis_case/helpers/date_helper.dart';
import 'package:provider/provider.dart';

import '../../components/account_detail_input.dart';
import 'add_account_viewmodel.dart';

class AddAccount extends StatefulWidget {
  const AddAccount({super.key});

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AddAccountViewModel>(context,listen: false).clearInputs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("addAcountLabel".locale),
      ),
      body: body(),
    );
  }

  Widget body() => Consumer<AddAccountViewModel>(
        builder: ((context, provider, child) => provider.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                     AccountDetailInput(
                    key: const Key("name_input"),
                    errorText: provider.nameInputErrorText,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))
                    ],
                    controller: provider.nameTextEditingController,
                    text: "nameLabel".locale,
                  ),
                  AccountDetailInput(
                    key: const Key("surname_input"),
                    errorText: provider.surnameInputErrorText,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))
                    ],
                    controller: provider.surnameTextEditingController,
                    text: "surnameLabel".locale,
                  ),
                  AccountDetailInput(
                    key: const Key("salary_input"),
                    errorText: provider.salaryInputErrorText,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                    ],
                    controller: provider.salaryTextEditingController,
                    text: "salaryLabel".locale,
                  ),
                  AccountDetailInput(
                    key: const Key("phone_number_input"),
                    errorText: provider.phoneNumberInputErrorText,
                    controller: provider.phoneNumberTextEditingController,
                    text: "phoneNumberLabel".locale,
                  ),
                  AccountDetailInput(
                    key: const Key("identity_input"),
                    errorText: provider.identityInputErrorText,
                    controller: provider.identityTextEditingController,
                    text: "identityLabel".locale,
                  ),
                    getDateLabel(provider, context),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width - 10,
                          child: ElevatedButton(
                            key: const Key("add_button"),
                            onPressed: provider.addAccount,
                            child: provider.isUpdating
                                ? const SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ))
                                : Text("addAcountLabel".locale),
                          )),
                    )
                  ],
                ),
              )),
      );

  Widget getDateLabel(AddAccountViewModel provider, BuildContext context) =>
      Container(
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: TextField(
          controller: provider.birthDateTextEditingController,
          decoration: InputDecoration(
              icon: const Icon(Icons.calendar_today), //icon of text field
              labelText: "birthDateLabel".locale //label text of field
              ),
          readOnly: true, //set it true, so that user will not able to edit text
          onTap: () => openDatePicker(context, provider),
        ),
      );

  openDatePicker(BuildContext context, AddAccountViewModel provider) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: provider.birthDateTextEditingController.text.isEmpty
            ? DateTime.now()
            : DateHelper.stringToDate(
                provider.birthDateTextEditingController.text),
        firstDate: DateTime(
            2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(
          formattedDate); //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement
      provider.birthDateTextEditingController.text = formattedDate;
    } else {
      print("Date is not selected");
    }
  }
}
