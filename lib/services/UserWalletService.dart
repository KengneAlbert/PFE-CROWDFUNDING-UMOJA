import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:umoja/models/WalletModel.dart';

class UserWalletService {
final FirebaseFirestore _firestore = FirebaseFirestore.instance;


Future<WalletModel?> getWalletByUserId(String userId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('MyWallet')
          .where('userId', isEqualTo: userId)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return WalletModel.fromMap(snapshot.docs.first.data() as Map<String, dynamic>);
      } else {
        return null; // No document found
      }
    } catch (e) {
      print('Error getting wallet by userId: $e');
      return null;
    }
  }




}