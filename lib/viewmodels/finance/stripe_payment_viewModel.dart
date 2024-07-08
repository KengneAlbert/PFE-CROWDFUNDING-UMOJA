import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/models/payment_intent_model.dart';
import 'package:umoja/services/payment_service.dart';

final paymentServiceProvider = Provider<PaymentService>((ref) => PaymentService());

final stripePaymentViewModelProvider =
    StateNotifierProvider<StripePaymentViewModel, StripePaymentState>((ref) {
  return StripePaymentViewModel(ref.read(paymentServiceProvider));
});

class StripePaymentViewModel extends StateNotifier<StripePaymentState> {
  final PaymentService _paymentService;

  StripePaymentViewModel(this._paymentService)
      : super(StripePaymentState.initial());

  Future<void> createPaymentIntent(double amount) async {
    try {
      state = state.copyWith(isLoading: true);
      // final paymentIntent = await _paymentService.createPaymentIntent(amount);
      // state = state.copyWith(paymentIntent: paymentIntent);
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

  // Future<void> startPayment(String paymentMethodId) async {
  //   try {
  //     state = state.copyWith(isLoading: true);

  //     if (state.paymentIntent != null) {
  //       final paymentResult = await _paymentService.pay(
  //           state.paymentIntent!.clientSecret, paymentMethodId);
  //       if (paymentResult) {
  //         // Gérer le succès du paiement
  //         state = state.copyWith(isLoading: false, paymentSuccess: true);
  //       } else {
  //         // Gérer l'échec du paiement
  //         state = state.copyWith(isLoading: false, paymentSuccess: false);
  //       }
  //     } else {
  //       // Gérer le cas où paymentIntent est null
  //       state = state.copyWith(
  //         isLoading: false,
  //         errorMessage: 'Veuillez créer un PaymentIntent',
  //       );
  //     }
  //   } catch (e) {
  //     // Gérer les erreurs
  //     state = state.copyWith(
  //       isLoading: false,
  //       errorMessage: e.toString(),
  //     );
  //   } finally {
  //     state = state.copyWith(isLoading: false);
  //   }
  // }
}

class StripePaymentState {
  final PaymentIntent? paymentIntent;
  final bool isLoading;
  final bool paymentSuccess; // Indique si le paiement a réussi
  final String? errorMessage; // Message d'erreur

  const StripePaymentState({
    this.paymentIntent,
    this.isLoading = false,
    this.paymentSuccess = false,
    this.errorMessage,
  });

  StripePaymentState.initial()
      : paymentIntent = null,
        isLoading = false,
        paymentSuccess = false,
        errorMessage = null;

  StripePaymentState copyWith({
    PaymentIntent? paymentIntent,
    bool? isLoading,
    bool? paymentSuccess,
    String? errorMessage,
  }) {
    return StripePaymentState(
      paymentIntent: paymentIntent ?? this.paymentIntent,
      isLoading: isLoading ?? this.isLoading,
      paymentSuccess: paymentSuccess ?? this.paymentSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}


// final paymentServiceProvider = Provider<PaymentService>((ref) => PaymentService()); 

// final stripePaymentViewModelProvider = StateNotifierProvider<StripePaymentViewModel, StripePaymentState>((ref) {
//   return StripePaymentViewModel(ref.read(paymentServiceProvider));
// });

// class StripePaymentViewModel extends StateNotifier<StripePaymentState> {
//   final PaymentService _paymentService;

//   StripePaymentViewModel(this._paymentService) : super(StripePaymentState.initial());

//   // Créer un PaymentIntent
//   Future<void> createPaymentIntent(double amount) async {
//     try {
//       state = state.copyWith(isLoading: true);
//       final paymentIntent = await _paymentService.createPaymentIntent(amount);
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

// class StripePaymentState {
//   final PaymentIntent? paymentIntent;
//   final bool isLoading;

//   const StripePaymentState({
//     this.paymentIntent,
//     this.isLoading = false,
//   });

//   StripePaymentState.initial() : paymentIntent = null, isLoading = false;

//   StripePaymentState copyWith({
//     PaymentIntent? paymentIntent,
//     bool? isLoading,
//   }) {
//     return StripePaymentState(
//       paymentIntent: paymentIntent ?? this.paymentIntent,
//       isLoading: isLoading ?? this.isLoading,
//     );
//   }
// }
