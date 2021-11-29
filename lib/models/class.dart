import 'package:cloud_firestore/cloud_firestore.dart';

class ClassModel{
  static const ID = "id";
  static const ClassNAME = "classname";
  static const ENSEIGNANT_ID = "enseignantId";

  String _classname;
  String _enseignantId;
  String _id;

//  getters
  String get classname => _classname;
  String get id => _id;
  String get enseignantId => _enseignantId;

  ClassModel.fromSnapshot(DocumentSnapshot snapshot){
    _classname = snapshot.data[ClassNAME];
    _id = snapshot.data[ID];
    _enseignantId = snapshot.data[ENSEIGNANT_ID];


  }


}

