import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/models/payment_method_model.dart';
import 'package:umoja/models/payment_intent_model.dart';
import 'package:umoja/services/payment_service.dart';
import 'package:umoja/viewmodels/finance/wallet_viewModel.dart';

final topUpViewModelProvider =
    StateNotifierProvider<TopUpViewModel, TopUpState>((ref) {
  return TopUpViewModel();
});

class TopUpViewModel extends StateNotifier<TopUpState> {
  TopUpViewModel() : super(TopUpState());

  void selectAmount(double amount) {
    state = state.copyWith(selectedAmount: amount);
  }
}

class TopUpState {
  final double? selectedAmount;

  TopUpState({this.selectedAmount});

  TopUpState copyWith({
    double? selectedAmount,
  }) {
    return TopUpState(
      selectedAmount: selectedAmount ?? this.selectedAmount,
    );
  }
}
// final paymentServiceProvider = Provider<PaymentService>((ref) => PaymentService());

// final topUpViewModelProvider =
//     StateNotifierProvider<TopUpViewModel, TopUpState>((ref) {
//   return TopUpViewModel(
//       ref.read(walletViewModelProvider.notifier), ref.read(paymentServiceProvider));
// });

// class TopUpViewModel extends StateNotifier<TopUpState> {
//   final WalletViewModel _walletViewModel;
//   final PaymentService _paymentService;

//   TopUpViewModel(this._walletViewModel, this._paymentService)
//       : super(TopUpState.initial());

//   void selectAmount(double amount) {
//     state = state.copyWith(selectedAmount: amount);

//     // Créer l'intention de paiement après la sélection du montant
//     // createPaymentIntent(); 
//   }

//   void selectPaymentMethod(PaymentMethod paymentMethod) {
//     state = state.copyWith(selectedPaymentMethod: paymentMethod);

//     // Si le paiement est avec CinetPay, générer les informations de paiement CinetPay
//     if (paymentMethod.id == 'cinetpay') {
//       generateCinetPayPaymentData();
//     }
//   }

//    // Fonction pour générer les informations de paiement CinetPay
//   void generateCinetPayPaymentData() {
//     // Remplacez les valeurs par celles de votre application
//     final amount = state.selectedAmount!.toStringAsFixed(2); // Assurez-vous que le montant est un String
//     final currency = 'XOF'; // Ou la monnaie que vous utilisez
//     final description = 'Rechargement de votre porte-monnaie';

//     state = state.copyWith(
//       cinetPayPaymentData: CinetPayPaymentData(
//         amount: amount,
//         currency: currency,
//         description: description,
//         // ... autres informations facultatives
//       ),
//     );
//   }

  

  

//   Future<void> createPaymentIntent() async {
//     // try {
//     //   state = state.copyWith(isLoading: true);
//     //   if (state.selectedAmount != null) {
//     //     final paymentIntent =
//     //         await _paymentService.createPaymentIntent(state.selectedAmount!);
//     //     state = state.copyWith(paymentIntent: paymentIntent);

//     //     // Rediriger vers l'écran "Top Up Method"
//     //     Navigator.push(
//     //       context, 
//     //       MaterialPageRoute(
//     //         builder: (context) => TopUpMethodPage(topUpViewModel: this),
//     //       ),
//     //     );
//     //   }
//     try {
//       state = state.copyWith(isLoading: true);
//       if (state.selectedAmount != null) {
//         // final paymentIntent = await _paymentService.createPaymentIntent(state.selectedAmount!);
//         // state = state.copyWith(paymentIntent: paymentIntent);
//       } else {
//         // Gérer le cas où selectedAmount est null
//         state = state.copyWith(
//           isLoading: false,
//           errorMessage: 'Veuillez sélectionner un montant',
//         );
//       }
//     } catch (e) {
//       // Gérer les erreurs
//       state = state.copyWith(
//         isLoading: false,
//         errorMessage: e.toString(),
//       );
//     } finally {
//       state = state.copyWith(isLoading: false);
//     }
//   }

//   // Future<void> startPayment(String paymentMethodId) async {
//   //   try {
//   //     state = state.copyWith(isLoading: true);

//   //     if (state.selectedAmount != null &&
//   //         state.paymentIntent != null &&
//   //         state.selectedPaymentMethod != null) {
//   //       final paymentResult = await _paymentService.pay(
//   //           state.paymentIntent!.clientSecret, paymentMethodId);
//   //       if (paymentResult) {
//   //         // Mettre à jour le solde du portefeuille
//   //         _walletViewModel.topUp(state.selectedAmount!);
//   //         // Gérer le succès du paiement
//   //         state = state.copyWith(isLoading: false, paymentSuccess: true);
//   //       } else {
//   //         // Gérer l'échec du paiement
//   //         state = state.copyWith(isLoading: false, paymentSuccess: false);
//   //       }
//   //     } else {
//   //       // Gérer le cas où selectedAmount, paymentIntent ou selectedPaymentMethod est null
//   //       state = state.copyWith(
//   //         isLoading: false,
//   //         errorMessage: 'Veuillez sélectionner un montant, une méthode de paiement et créer un PaymentIntent',
//   //       );
//   //     }
//   //   } catch (e) {
//   //     // Gérer les erreurs
//   //     state = state.copyWith(
//   //       isLoading: false,
//   //       errorMessage: e.toString(),
//   //     );
//   //   } finally {
//   //     state = state.copyWith(isLoading: false);
//   //   }
//   // }
// }

// class TopUpState {
//   final double? selectedAmount;
//   final PaymentMethod? selectedPaymentMethod;
//   final PaymentIntent? paymentIntent;
//   final CinetPayPaymentData? cinetPayPaymentData; 
//   final bool isLoading;
//   final bool paymentSuccess; // Indique si le paiement a réussi
//   final String? errorMessage; // Message d'erreur

//   const TopUpState({
//     this.selectedAmount,
//     this.selectedPaymentMethod,
//     this.cinetPayPaymentData,
//     this.paymentIntent,
//     this.isLoading = false,
//     this.paymentSuccess = false,
//     this.errorMessage,
//   });

//   TopUpState.initial()
//       : selectedAmount = null,
//         selectedPaymentMethod = null,
//         cinetPayPaymentData = null,
//         paymentIntent = null,
//         isLoading = false,
//         paymentSuccess = false,
//         errorMessage = null;

//   TopUpState copyWith({
//     double? selectedAmount,
//     PaymentMethod? selectedPaymentMethod,
//     CinetPayPaymentData? cinetPayPaymentData,
//     PaymentIntent? paymentIntent,
//     bool? isLoading,
//     bool? paymentSuccess,
//     String? errorMessage,
//   }) {
//     return TopUpState(
//       selectedAmount: selectedAmount ?? this.selectedAmount,
//       selectedPaymentMethod:
//           selectedPaymentMethod ?? this.selectedPaymentMethod,
//       cinetPayPaymentData:
//           cinetPayPaymentData ?? this.cinetPayPaymentData,
//       paymentIntent: paymentIntent ?? this.paymentIntent,
//       isLoading: isLoading ?? this.isLoading,
//       paymentSuccess: paymentSuccess ?? this.paymentSuccess,
//       errorMessage: errorMessage ?? this.errorMessage,
//     );
//   }
// }

// class CinetPayPaymentData {
//   final String amount; 
//   final String currency; 
//   final String? description; 
//   final String? orderRef; // Votre référence de commande (facultatif)
//   final String? notifyUrl; // URL pour recevoir les notifications de paiement
//   final String? apiToken; // Votre jeton API CinetPay

//   CinetPayPaymentData({
//     required this.amount,
//     required this.currency,
//     this.description,
//     this.orderRef,
//     this.notifyUrl,
//     this.apiToken,
//   });
// }


// // final paymentServiceProvider = Provider<PaymentService>((ref) => PaymentService()); 

// // final topUpViewModelProvider = StateNotifierProvider<TopUpViewModel, TopUpState>((ref) {
// //   return TopUpViewModel(ref.read(walletViewModelProvider.notifier), ref.read(paymentServiceProvider));
// // });

// // class TopUpViewModel extends StateNotifier<TopUpState> {
// //   final WalletViewModel _walletViewModel;
// //   final PaymentService _paymentService;

// //   TopUpViewModel(this._walletViewModel, this._paymentService) : super(TopUpState.initial());

// //   get selectedAmount => null;

// //   // Gérer le choix du montant
// //   void selectAmount(double amount) {
// //     state = state.copyWith(selectedAmount: amount);
// //   }

// //   // Gérer le choix du mode de paiement
// //   void selectPaymentMethod(PaymentMethod paymentMethod) {
// //     state = state.copyWith(selectedPaymentMethod: paymentMethod);
// //   }

// //   // Créer un PaymentIntent
// //   Future<void> createPaymentIntent() async {
// //     try {
// //       state = state.copyWith(isLoading: true);
// //       final paymentIntent = await _paymentService.createPaymentIntent(state.selectedAmount!); // Correction de l'erreur 2
// //       state = state.copyWith(paymentIntent: paymentIntent);
// //     } catch (e) {
// //       // Gérer les erreurs
// //     } finally {
// //       state = state.copyWith(isLoading: false);
// //     }
// //   }

// //   // Lancer le paiement
// //   Future<void> startPayment(String paymentMethodId) async {
// //     try {
// //       state = state.copyWith(isLoading: true);
// //       final paymentResult = await _paymentService.pay(
// //         state.paymentIntent!.clientSecret, 
// //         paymentMethodId,
// //       );
// //       if (paymentResult) {
// //         // Mettre à jour le solde du portefeuille
// //         _walletViewModel.topUp(state.selectedAmount!); // Correction de l'erreur 3
// //         // Afficher un message de succès
// //       } else {
// //         // Afficher un message d'échec
// //       }
// //     } catch (e) {
// //       // Gérer les erreurs
// //     } finally {
// //       state = state.copyWith(isLoading: false);
// //     }
// //   }
// // }

// // class TopUpState {
// //   final double? selectedAmount;
// //   final PaymentMethod? selectedPaymentMethod;
// //   final PaymentIntent? paymentIntent;
// //   final bool isLoading;

// //   const TopUpState({
// //     this.selectedAmount,
// //     this.selectedPaymentMethod,
// //     this.paymentIntent,
// //     this.isLoading = false,
// //   });

// //   TopUpState.initial()
// //       : selectedAmount = null,
// //         selectedPaymentMethod = null,
// //         paymentIntent = null,
// //         isLoading = false;

// //   TopUpState copyWith({
// //     double? selectedAmount,
// //     PaymentMethod? selectedPaymentMethod,
// //     PaymentIntent? paymentIntent,
// //     bool? isLoading,
// //   }) {
// //     return TopUpState(
// //       selectedAmount: selectedAmount ?? this.selectedAmount,
// //       selectedPaymentMethod: selectedPaymentMethod ?? this.selectedPaymentMethod,
// //       paymentIntent: paymentIntent ?? this.paymentIntent,
// //       isLoading: isLoading ?? this.isLoading,
// //     );
// //   }
// // }