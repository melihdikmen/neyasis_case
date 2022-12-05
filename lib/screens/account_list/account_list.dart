import 'package:flutter/material.dart';
import 'package:neyasis_case/screens/account_list/account_list_viewmodel.dart';
import 'package:provider/provider.dart';

class AccountList extends StatefulWidget {
  const AccountList({super.key});

  @override
  State<AccountList> createState() => _AccountListState();
}

class _AccountListState extends State<AccountList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accounts"),
      ),
      body: Consumer<AccountListViewModel>(
        builder: (context, accountListViewModel, child) => ListView.builder(
            itemCount: accountListViewModel.accounts.length,
            itemBuilder: ((context, index) => ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  subtitle: Text(
                      accountListViewModel.accounts[index].surname.toString()),
                  title: Text(
                      accountListViewModel.accounts[index].name.toString()),
                ))),
      ),
    );
  }
}
