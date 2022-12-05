import 'package:flutter/material.dart';
import 'package:neyasis_case/models/account.dart';
import 'package:neyasis_case/screens/account_list/account_list_viewmodel.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:provider/provider.dart';

class AccountList extends StatefulWidget {
  const AccountList({super.key});

  @override
  State<AccountList> createState() => _AccountListState();
}

class _AccountListState extends State<AccountList> {
GlobalKey<PaginationViewState>? key;

  @override
  void initState() {
    super.initState();
      key = GlobalKey<PaginationViewState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accounts"),
      ),
      body: Consumer<AccountListViewModel>(
          builder: (context, accountListViewModel, child) =>
              PaginationView<Account>(
                pullToRefresh: true,
                key: key,
                itemBuilder: (context, item, index) => ListTile(
                  title: Text(item.name!),
                ),
                preloadedItems : accountListViewModel.accounts,
                pageFetch:accountListViewModel.pageFetch,
                onEmpty: const Center(
                  child: Text('Sorry! This is empty'),
                ),
                onError: (dynamic error) => const Center(
                  child: Text('Some error occured'),
                ),
                initialLoader: const Center(
                  child: CircularProgressIndicator(),
                ),
              )),
    );
  }
}
