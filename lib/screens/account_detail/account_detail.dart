import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:neyasis_case/components/account_detail_input.dart';
import 'package:neyasis_case/helpers/date_helper.dart';
import 'package:neyasis_case/models/account.dart';
import 'package:neyasis_case/screens/account_detail/account_detail_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../extensions/string_extensions.dart';
import 'package:flutter/services.dart';

class AccountDetail extends StatefulWidget {
  const AccountDetail({super.key, required this.selectedAccount});
final Account selectedAccount;
  @override
  State<AccountDetail> createState() => _AccountDetailState();
}

class _AccountDetailState extends State<AccountDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AccountDetailViewModel>(context, listen: false)
          .getAccountDetail(widget.selectedAccount);
    });
  }

  @override
  Widget build(BuildContext context) {
       
    return Scaffold(
      appBar: AppBar(
        title: Text("accountDetail".locale),
      ),
      body: body(),
    );
  }
}

Widget body() => Consumer<AccountDetailViewModel>(
      builder: ((context, provider, child) => provider.isLoading ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
            child: Column(
              children: [
                AccountDetailInput(
                  errorText: provider.nameInputErrorText,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))
                  ],
                  controller: provider.nameTextEditingController,
                  text: "nameLabel".locale,
                ),
                AccountDetailInput(
                  errorText: provider.surnameInputErrorText,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))
                  ],
                  controller: provider.surnameTextEditingController,
                  text: "surnameLabel".locale,
                ),
                AccountDetailInput(
                  errorText: provider.salaryInputErrorText,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                  ],
                  controller: provider.salaryTextEditingController,
                  text: "salaryLabel".locale,
                ),
                AccountDetailInput(
                  errorText: provider.phoneNumberInputErrorText,
                  controller: provider.phoneNumberTextEditingController,
                  text: "phoneNumberLabel".locale,
                ),
                AccountDetailInput(
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
                        onPressed: provider.updateAccount,
                        child: provider.isUpdating
                            ? const SizedBox(
                                height: 25,
                                width: 25,
                                child:  CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                            : Text("updateButton".locale),
                      )),
                )
              ],
            ),
          )),
    );

Widget getDateLabel(AccountDetailViewModel provider, BuildContext context) =>
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

openDatePicker(BuildContext context, AccountDetailViewModel provider) async {
  DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate:
          DateHelper.stringToDate(provider.birthDateTextEditingController.text),
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
