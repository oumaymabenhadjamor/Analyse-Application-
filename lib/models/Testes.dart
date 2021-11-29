import 'package:cloud_firestore/cloud_firestore.dart';

class TestModel{
  static const ID = "id";
  static const MALADIE = "maladie";
  static const USER_ID = "userId";
  static const SCOREDYSLEXIE = "scoreDyslexie";
  static const SCOREMYOPIE = "scoreMyopie";
  static const SCORECOLORBLIND = "scoreColorBlind";
  static const SCOREDYSPRAXIE = "scoreDyspraxie";
  static const SCOREDYSPHASIE = "scoreDysphasie";
  static const SCOREDYSCALCULIE = "scoreDyscalculie";

 // static const CREATED_AT = "createdAt";
  static const ENSEIGNANTID = "enseignantId";
int _scoreDyscalculie;

int _scoreDysphasie;
int _scoreDyspraxie;
  String _id;
  String _maladie;
  String _userId;
  String _enseignantId;
 // int _createdAt;
  int _scoreDyslexie;
  int _scoreMyopie;
  int _scoreColorBlind;

//  getters
  String get id => _id;
  String get maladie => _maladie;
  String get userId => _userId;
  String get enseignantId =>_enseignantId;
  int get scoreColorBlind=> _scoreColorBlind;
  int get scoreMyopie=> _scoreMyopie;
  int get scoreDyslexie => _scoreDyslexie;

  int get scoreDyscalculie => _scoreDyscalculie;
  int get scoreDysphasie => _scoreDysphasie;
  int get scoreDyspraxie => _scoreDyspraxie;

 // int get createdAt => _createdAt;



  TestModel.fromSnapshot(DocumentSnapshot snapshot){
    _id = snapshot.data[ID];
    _maladie = snapshot.data[MALADIE];
    _scoreDyslexie = snapshot.data[SCOREDYSLEXIE];
    _scoreMyopie = snapshot.data[SCOREMYOPIE];
    _scoreColorBlind = snapshot.data[SCORECOLORBLIND];
    _userId = snapshot.data[USER_ID];
    _enseignantId=snapshot.data[ENSEIGNANTID];
    _scoreDyscalculie=snapshot.data[SCOREDYSCALCULIE];
    _scoreDysphasie=snapshot.data[SCOREDYSPHASIE];
    _scoreDyspraxie=snapshot.data[SCOREDYSPRAXIE];

  //  _createdAt = snapshot.data[CREATED_AT];

  }









}