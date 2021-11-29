import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const IMAGE = "image";
  String _name;
  String _email;
  String _id;
  String _image;
//  getters
  String get name => _name;
  String get id => _id;
  String get email => _email;
  String get image => _image;

  UserModel.fromSnapshot(DocumentSnapshot snapshot){
    _name = snapshot.data[NAME];
    _id = snapshot.data[ID];
    _email = snapshot.data[EMAIL];
    _image = snapshot.data[IMAGE];


  }


  }

