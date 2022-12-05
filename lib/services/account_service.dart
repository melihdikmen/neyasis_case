import 'package:neyasis_case/models/account.dart';
import 'package:neyasis_case/net/network_manager.dart';

class AccountService {
  Future<List<Account>?> getAccounts() async {
    List<Account>? response = await NetworkManager.instance!
        .dioGet<List<Account>, Account>("/users", Account());

    if (response != null) {
       return response;
    } else {
      return null;
    }
  }
}
