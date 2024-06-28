import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/models/wallet_model.dart';

final walletViewModelProvider =
    StateNotifierProvider<WalletViewModel, Wallet>((ref) {
  return WalletViewModel(initialBalance: 349.0);
});

class WalletViewModel extends StateNotifier<Wallet> {
  WalletViewModel({required double initialBalance})
      : super(Wallet(balance: initialBalance));

  void topUp(double amount) {
    state = Wallet(balance: state.balance + amount);
  }

  void withdraw(double amount) {
    if (state.balance >= amount) {
      state = Wallet(balance: state.balance - amount);
    } else {
      // Gérer le cas où le solde est insuffisant
    }
  }
}

// final walletViewModelProvider = StateNotifierProvider<WalletViewModel, Wallet>((ref) {
//   return WalletViewModel(initialBalance: 349.0);
// });

// class WalletViewModel extends StateNotifier<Wallet> {
//   WalletViewModel({required double initialBalance}) : super(Wallet(balance: initialBalance));

//   void topUp(double amount) {
//     state = Wallet(balance: state.balance + amount);
//   }

//   void withdraw(double amount) {
//     if (state.balance >= amount) {
//       state = Wallet(balance: state.balance - amount);
//     } else {
//       // Gérer le cas où le solde est insuffisant
//     }
//   }
// }