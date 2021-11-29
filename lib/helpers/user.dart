
import 'package:analyse_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class UserServices{
  String collection = "users";

  Firestore _firestore = Firestore.instance;

  void createUser(Map<String, dynamic> values) {
    String id = values["id"];
    _firestore.collection(collection).document(id).setData(values);
  }

  void updateUserData(Map<String, dynamic> values){
    _firestore.collection(collection).document(values['id']).updateData(values);
  }



  Future<List<UserModel>> getUsers() async =>
      _firestore.collection(collection).getDocuments().then((result) {
        List<UserModel> users = [];
        for (DocumentSnapshot user in result.documents) {
          users.add(UserModel.fromSnapshot(user));
        }
        return users;
      });




  Future<UserModel> getUserById(String id) => _firestore.collection(collection).document(id).get().then((doc){
    return UserModel.fromSnapshot(doc);
  });

  Future<bool> resetpassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return false;
    }
  }
}