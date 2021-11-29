import 'package:analyse_app/helpers/Testes.dart';
import 'package:analyse_app/models/Testes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class TestProvider with ChangeNotifier{
  TestServices _testServices = TestServices();
  List<TestModel> testes = [];
  List<TestModel> dyslexie = [];
  List<TestModel> dyslexieByClass = [];
  List<TestModel> negativesByClass = [];
  List<TestModel> myopieByClass = [];
  List<TestModel> daltonismeByClass = [];
  List<TestModel> testsByClass = [];
  List<TestModel> myopie = [];
  List<TestModel> dyscalculie = [];
  List<TestModel> dyspraxie = [];
  List<TestModel> dysphasie = [];
  List<TestModel> dysorthographie = [];
  List<TestModel> dyscalculieByClass = [];
  List<TestModel> dyspraxieByClass = [];
  List<TestModel> dysphasieByClass = [];
  List<TestModel> dysorthographieByClass = [];
  List<TestModel> students = [];
  List<TestModel> daltonisme = [];
  List<TestModel> testsByUser = [];
  FirebaseUser _user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
String student;
  TestProvider.initialize(){
    loadTestes();
    loadtestsByUser(student: student);
    countDyspraxieByClass();
    countMyopie();

  }

  loadTestes()async{
    testes = await _testServices.getTestes();
    notifyListeners();
  }
  Future loadtestsByUser({String student})async{
    try{
    testsByUser = await _testServices.getTestsByUser(id:student);
    notifyListeners();
    return true;
  }
  catch(e){

    notifyListeners();
    print(e.toString());
    return false;
  }}
  countDyslexie({String ensignantId})async{
    FirebaseUser user = await _auth.currentUser();
    dyslexie = await _testServices.countDyslexie(id:user.uid);
    notifyListeners();
  }
  countDyspraxie({String ensignantId})async{
    FirebaseUser user = await _auth.currentUser();
    dyspraxie = await _testServices.countDyspraxie(id:user.uid);
    notifyListeners();
  }
  countDyscalculie({String ensignantId})async{
    FirebaseUser user = await _auth.currentUser();
    dyscalculie = await _testServices.countDyscalculie(id:user.uid);
    notifyListeners();
  }
  countDysphasie({String ensignantId})async{
    FirebaseUser user = await _auth.currentUser();
    dysphasie = await _testServices.countDysphasie(id:user.uid);
    notifyListeners();
  }

  countMyopie({String ensignantId})async{
    FirebaseUser user = await _auth.currentUser();
    myopie = await _testServices.countMyopie(id:user.uid);
    notifyListeners();
  }
  countDaltonisme({String ensignantId})async{
    FirebaseUser user = await _auth.currentUser();
    daltonisme = await _testServices.countDaltonisme(id:user.uid);
    notifyListeners();
  }
  countStudentsByEnseignant({String ensignantId})async{
    FirebaseUser user = await _auth.currentUser();
    students = await _testServices.countStudentsByEnseignant(id:user.uid);
    notifyListeners();
  }
  countDyslexieByClass({String ensignantId,String ClassId})async{
    FirebaseUser user = await _auth.currentUser();
    dyslexieByClass = await _testServices.countDyslexieByClass(id:user.uid,classe:ClassId);
    notifyListeners();
  }
  countMyopieByClass({String ensignantId,String ClassId})async{
    FirebaseUser user = await _auth.currentUser();
    myopieByClass = await _testServices.countMyopieByClass(id:user.uid,classe:ClassId);
    notifyListeners();
  }
  countDaltonismeByClass({String ensignantId,String ClassId})async{
    FirebaseUser user = await _auth.currentUser();
    daltonismeByClass = await _testServices.countDaltoByClass(id:user.uid,classe:ClassId);
    notifyListeners();
  }
  countDyspraxieByClass({String ensignantId,String ClassId})async{
    FirebaseUser user = await _auth.currentUser();
    dyspraxieByClass = await _testServices.countDyspraxieByClass(id:user.uid,classe:ClassId);
    notifyListeners();
  }
  countDysphasieByClass({String ensignantId,String ClassId})async{
    FirebaseUser user = await _auth.currentUser();
    dysphasieByClass = await _testServices.countDysphasieByClass(id:user.uid,classe:ClassId);
    notifyListeners();
  }
  countDyscalculieByClass({String ensignantId,String ClassId})async{
    FirebaseUser user = await _auth.currentUser();
    dyscalculieByClass = await _testServices.countDyscalculieByClass(id:user.uid,classe:ClassId);
    notifyListeners();
  }

  countTestsByClass({String ensignantId,String ClassId})async{
    FirebaseUser user = await _auth.currentUser();
    testsByClass = await _testServices.countTestsByClass(id:user.uid,classe:ClassId);
    notifyListeners();
  }
  countNegativesByClass({String ensignantId,String ClassId})async{
    FirebaseUser user = await _auth.currentUser();
   negativesByClass = await _testServices.countNegativesByClass(id:user.uid,classe:ClassId);
    notifyListeners();
  }
}