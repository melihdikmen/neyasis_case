import 'package:flutter/material.dart';
import 'package:neyasis_case/screens/account_detail/account_detail.dart';
import 'package:neyasis_case/screens/add_account/add_account.dart';
import '../../extensions/string_extensions.dart';
import '../../models/account.dart';
import 'account_list_viewmodel.dart';
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
     Provider.of<AccountListViewModel>(context).setContext(context);
    return Scaffold(
      appBar: AppBar(
        title:  Text("accountList".locale),
        actions: [IconButton(onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder:(_)=> AddAccount())), icon: Icon(Icons.add))],
      ),
      body: Consumer<AccountListViewModel>(
          builder: (context, accountListViewModel, child) =>
              PaginationView<Account>( 
                pullToRefresh: true,
                key: key,
                itemBuilder: (context, item, index) => InkWell( 
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_)=>  AccountDetail(selectedAccount: item,))),
                  child: ListTile(
                    trailing:accountListViewModel.deletetingStates.isNotEmpty && accountListViewModel.deletetingStates[item.id]! ? const CircularProgressIndicator() :  IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _showMyDialog(item,accountListViewModel),
                    ),
                    title: Text(item.name!),
                  ),
                ),
                preloadedItems: accountListViewModel.accounts,
                pageFetch: accountListViewModel.pageFetch,
                onEmpty:  Center(
                  child: Text('emptyList'.locale),
                ),
                onError: (dynamic error) =>  Center(
                  child: Text('dateGetError'.locale),
                ),
                initialLoader: const Center(
                  child: CircularProgressIndicator(),
                ),
              )),
    );
  }

  Future<void> _showMyDialog(Account item,AccountListViewModel accountListViewModel) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text('deleteAccount'.locale),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
             
                Text('deleteAccountWarning'.locale),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child:  Text('okLabel'.locale),
              onPressed: (){
                accountListViewModel.deleteAccount(item,key!);
                Navigator.of(context).pop();
              }
            ),
            TextButton(
              child:  Text('cancelLabel'.locale),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
