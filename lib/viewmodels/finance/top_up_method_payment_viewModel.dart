import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/models/payment_method_model.dart';
import 'package:umoja/models/payment_intent_model.dart';
import 'package:umoja/services/payment_service.dart';
import 'package:umoja/viewmodels/finance/wallet_viewModel.dart';

final paymentServiceProvider = Provider<PaymentService>((ref) => PaymentService());

final topUpViewModelProvider =
    StateNotifierProvider<TopUpViewModel, TopUpState>((ref) {
  return TopUpViewModel(
      ref.read(walletViewModelProvider.notifier), ref.read(paymentServiceProvider));
});

class TopUpViewModel extends StateNotifier<TopUpState> {
  final WalletViewModel _walletViewModel;
  final PaymentService _paymentService;

  TopUpViewModel(this._walletViewModel, this._paymentService)
      : super(TopUpState.initial());

  void selectAmount(double amount) {
    state = state.copyWith(selectedAmount: amount);

    // Créer l'intention de paiement après la sélection du montant
    // createPaymentIntent(); 
  }

  void selectPaymentMethod(PaymentMethod paymentMethod) {
    state = state.copyWith(selectedPaymentMethod: paymentMethod);
  }

  Future<void> createPaymentIntent() async {
    // try {
    //   state = state.copyWith(isLoading: true);
    //   if (state.selectedAmount != null) {
    //     final paymentIntent =
    //         await _paymentService.createPaymentIntent(state.selectedAmount!);
    //     state = state.copyWith(paymentIntent: paymentIntent);

    //     // Rediriger vers l'écran "Top Up Method"
    //     Navigator.push(
    //       context, 
    //       MaterialPageRoute(
    //         builder: (context) => TopUpMethodPage(topUpViewModel: this),
    //       ),
    //     );
    //   }
    try {
      state = state.copyWith(isLoading: true);
      if (state.selectedAmount != null) {
        final paymentIntent = await _paymentService.createPaymentIntent(state.selectedAmount!);
        state = state.copyWith(paymentIntent: paymentIntent);
      } else {
        // Gérer le cas où selectedAmount est null
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Veuillez sélectionner un montant',
        );
      }
    } catch (e) {
      // Gérer les erreurs
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> startPayment(String paymentMethodId) async {
    try {
      state = state.copyWith(isLoading: true);

      if (state.selectedAmount != null &&
          state.paymentIntent != null &&
          state.selectedPaymentMethod != null) {
        final paymentResult = await _paymentService.pay(
            state.paymentIntent!.clientSecret, paymentMethodId);
        if (paymentResult) {
          // Mettre à jour le solde du portefeuille
          _walletViewModel.topUp(state.selectedAmount!);
          // Gérer le succès du paiement
          state = state.copyWith(isLoading: false, paymentSuccess: true);
        } else {
          // Gérer l'échec du paiement
          state = state.copyWith(isLoading: false, paymentSuccess: false);
        }
      } else {
        // Gérer le cas où selectedAmount, paymentIntent ou selectedPaymentMethod est null
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Veuillez sélectionner un montant, une méthode de paiement et créer un PaymentIntent',
        );
      }
    } catch (e) {
      // Gérer les erreurs
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

class TopUpState {
  final double? selectedAmount;
  final PaymentMethod? selectedPaymentMethod;
  final PaymentIntent? paymentIntent;
  final bool isLoading;
  final bool paymentSuccess; // Indique si le paiement a réussi
  final String? errorMessage; // Message d'erreur

  const TopUpState({
    this.selectedAmount,
    this.selectedPaymentMethod,
    this.paymentIntent,
    this.isLoading = false,
    this.paymentSuccess = false,
    this.errorMessage,
  });

  TopUpState.initial()
      : selectedAmount = null,
        selectedPaymentMethod = null,
        paymentIntent = null,
        isLoading = false,
        paymentSuccess = false,
        errorMessage = null;

  TopUpState copyWith({
    double? selectedAmount,
    PaymentMethod? selectedPaymentMethod,
    PaymentIntent? paymentIntent,
    bool? isLoading,
    bool? paymentSuccess,
    String? errorMessage,
  }) {
    return TopUpState(
      selectedAmount: selectedAmount ?? this.selectedAmount,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
      paymentIntent: paymentIntent ?? this.paymentIntent,
      isLoading: isLoading ?? this.isLoading,
      paymentSuccess: paymentSuccess ?? this.paymentSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// final paymentServiceProvider = Provider<PaymentService>((ref) => PaymentService()); 

// final topUpViewModelProvider = StateNotifierProvider<TopUpViewModel, TopUpState>((ref) {
//   return TopUpViewModel(ref.read(walletViewModelProvider.notifier), ref.read(paymentServiceProvider));
// });

// class TopUpViewModel extends StateNotifier<TopUpState> {
//   final WalletViewModel _walletViewModel;
//   final PaymentService _paymentService;

//   TopUpViewModel(this._walletViewModel, this._paymentService) : super(TopUpState.initial());

//   get selectedAmount => null;

//   // Gérer le choix du montant
//   void selectAmount(double amount) {
//     state = state.copyWith(selectedAmount: amount);
//   }

//   // Gérer le choix du mode de paiement
//   void selectPaymentMethod(PaymentMethod paymentMethod) {
//     state = state.copyWith(selectedPaymentMethod: paymentMethod);
//   }

//   // Créer un PaymentIntent
//   Future<void> createPaymentIntent() async {
//     try {
//       state = state.copyWith(isLoading: true);
//       final paymentIntent = await _paymentService.createPaymentIntent(state.selectedAmount!); // Correction de l'erreur 2
//       state = state.copyWith(paymentIntent: paymentIntent);
//     } catch (e) {
//       // Gérer les erreurs
//     } finally {
//       state = state.copyWith(isLoading: false);
//     }
//   }

//   // Lancer le paiement
//   Future<void> startPayment(String paymentMethodId) async {
//     try {
//       state = state.copyWith(isLoading: true);
//       final paymentResult = await _paymentService.pay(
//         state.paymentIntent!.clientSecret, 
//         paymentMethodId,
//       );
//       if (paymentResult) {
//         // Mettre à jour le solde du portefeuille
//         _walletViewModel.topUp(state.selectedAmount!); // Correction de l'erreur 3
//         // Afficher un message de succès
//       } else {
//         // Afficher un message d'échec
//       }
//     } catch (e) {
//       // Gérer les erreurs
//     } finally {
//       state = state.copyWith(isLoading: false);
//     }
//   }
// }

// class TopUpState {
//   final double? selectedAmount;
//   final PaymentMethod? selectedPaymentMethod;
//   final PaymentIntent? paymentIntent;
//   final bool isLoading;

//   const TopUpState({
//     this.selectedAmount,
//     this.selectedPaymentMethod,
//     this.paymentIntent,
//     this.isLoading = false,
//   });

//   TopUpState.initial()
//       : selectedAmount = null,
//         selectedPaymentMethod = null,
//         paymentIntent = null,
//         isLoading = false;

//   TopUpState copyWith({
//     double? selectedAmount,
//     PaymentMethod? selectedPaymentMethod,
//     PaymentIntent? paymentIntent,
//     bool? isLoading,
//   }) {
//     return TopUpState(
//       selectedAmount: selectedAmount ?? this.selectedAmount,
//       selectedPaymentMethod: selectedPaymentMethod ?? this.selectedPaymentMethod,
//       paymentIntent: paymentIntent ?? this.paymentIntent,
//       isLoading: isLoading ?? this.isLoading,
//     );
//   }
// }