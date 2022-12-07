import '../models/account.dart';
import '../net/network_manager.dart';

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

  Future<Account?> deleteAccount(Account account) async {
    Account? response = await NetworkManager.instance!
        .dioDelete<Account, Account>("/users/${account.id}", Account());

    if (response != null) {
      return response;
    } else {
      return null;
    }
  }

  Future<Account?> getAccountDetail(Account account) async {
    Account? response = await NetworkManager.instance!
        .dioGet<Account, Account>("/users/${account.id}", Account());

    if (response != null) {
      return response;
    } else {
      return null;
    }
  }

  Future<Account?> updateAccount(Account account) async {
    Account? response = await NetworkManager.instance!
        .dioPut<Account, Account>("/users/${account.id}", Account(), account);

    if (response != null) {
      return response;
    } else {
      return null;
    }
  }

  Future<Account?> addAccount(Account account) async {
    Account? response = await NetworkManager.instance!
        .dioPost<Account, Account>("/users", Account(), account);

    if (response != null) {
      return response;
    } else {
      return null;
    }
  }
}
