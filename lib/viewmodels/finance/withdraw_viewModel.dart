import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/models/wallet_model.dart';
import 'package:umoja/viewmodels/finance/wallet_viewModel.dart';

final withdrawViewModelProvider =
    StateNotifierProvider<WithdrawViewModel, WithdrawState>((ref) {
  final walletViewModel = ref.read(walletViewModelProvider.notifier);
  return WithdrawViewModel(walletViewModel);
});

class WithdrawViewModel extends StateNotifier<WithdrawState> {
  final WalletViewModel _walletViewModel;

  WithdrawViewModel(this._walletViewModel) : super(WithdrawState.initial());

  void setAmount(double amount) {
    state = state.copyWith(amount: amount);
  }

  void withdraw() {
    if (_walletViewModel.state.balance >= state.amount) {
      _walletViewModel.withdraw(state.amount);
      // Afficher un message de succès
    } else {
      // Gérer le cas où le solde est insuffisant
    }
  }
}

class WithdrawState {
  final double amount;
  final bool isLoading;

  const WithdrawState({
    this.amount = 0.0,
    this.isLoading = false,
  });

  WithdrawState.initial() : amount = 0.0, isLoading = false;

  WithdrawState copyWith({
    double? amount,
    bool? isLoading,
  }) {
    return WithdrawState(
      amount: amount ?? this.amount,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
// final withdrawViewModelProvider = StateNotifierProvider<WithdrawViewModel, WithdrawState>((ref) {
//   final walletViewModel = ref.read(walletViewModelProvider.notifier); 
//   return WithdrawViewModel(walletViewModel);
// });

// class WithdrawViewModel extends StateNotifier<WithdrawState> {
//   final WalletViewModel _walletViewModel;

//   WithdrawViewModel(this._walletViewModel) : super(WithdrawState.initial());

//   void setAmount(double amount) {
//     state = state.copyWith(amount: amount);
//   }

//   void withdraw() {
//     if (_walletViewModel.state.balance >= state.amount) {
//       _walletViewModel.withdraw(state.amount);
//       // Afficher un message de succès
//     } else {
//       // Gérer le cas où le solde est insuffisant
//     }
//   }
// }

// class WithdrawState {
//   final double amount;
//   final bool isLoading;

//   const WithdrawState({
//     this.amount = 0.0,
//     this.isLoading = false,
//   });

//   WithdrawState.initial() : amount = 0.0, isLoading = false;

//   WithdrawState copyWith({
//     double? amount,
//     bool? isLoading,
//   }) {
//     return WithdrawState(
//       amount: amount ?? this.amount,
//       isLoading: isLoading ?? this.isLoading,
//     );
//   }
// }