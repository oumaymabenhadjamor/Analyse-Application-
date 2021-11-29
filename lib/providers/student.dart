
import 'package:analyse_app/helpers/student.dart';
import 'package:analyse_app/helpers/user.dart';
import 'package:analyse_app/models/Testes.dart';
import 'package:analyse_app/models/students.dart';
import 'package:analyse_app/providers/app.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class StudentProvider with ChangeNotifier {
int counts;
  List<StudentModel> searchedStudents = [];
  List<StudentModel> students = [];
  List<StudentModel> studentss = [];
List<StudentModel> studentsByLevel = [];
List<StudentModel> studentsByID = [];
  List<TestModel> testes = [];
  FirebaseAuth _auth;
  FirebaseUser _user;

  Firestore _firestore = Firestore.instance;
  StudentServices _studentService = StudentServices();

  StudentModel _studentModel;
  StudentModel get studentModel => _studentModel;

  FirebaseUser get user => _user;
  List<StudentModel> studentsByClass  = [];
  String classe ="";
  String image="";
  int niveau ;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController age = TextEditingController();
  StudentProvider.initialize(): _auth = FirebaseAuth.instance{
  //? != null

    loadStudents();
  }
//

  Future loadStudentsByClass( {String classId})async{
    studentsByClass = await _studentService.getStudentsByClass(id:classId);
    notifyListeners();
  }
  Future loadCountStudentsByClass({String classId})async{
    counts = await _studentService.getCountStudentsByClass(id:classId);
    notifyListeners();
  }



  Future<bool> signUpStudent()async{
    try{
      var uuid = Uuid();
      String id = uuid.v4();
      FirebaseUser user = await _auth.currentUser();
     // await _auth.createUserWithEmailAndPassword(email: email.text.trim()+"@3Dwave.com", password: password.text.trim()+"1996");
        _firestore.collection('users').document(id).setData({
          'name':name.text,
          'email':email.text.trim()+"@3Dwave.com",
          'uid':id,
          'id':id,
          'age':age.text,
          'classId':classe,
          'password': password.text.trim()+"1996",
          'image':image,
          'niveau':niveau,
          'ud':id,
          'enseignant':user.uid,

      });
      return true;
    }catch(e){


      print(e.toString());
      return false;
    }
  }





  void clearController(){
    name.text = "";
    email.text = "";
    password.text = "";
    age.text="";
  }



  Future search({String name,String id})async{
    searchedStudents = await _studentService.searchStudent(name: name,id:id);
    print("RESTOS ARE: ${searchedStudents.length}");
    notifyListeners();
  }

   removeStudent({String id})async{

     await _studentService.deleteStudent(id:id);
      notifyListeners();

  }


  loadStudents()async{
    students = await _studentService.getStudents();
    notifyListeners();
  }
  loadStudentsByLevel()async{
    FirebaseUser user = await _auth.currentUser();
    studentsByLevel = await _studentService.getStudentsByLevel(id:user.uid);
    notifyListeners();
  }
  loadStudentsByID({String id})async{
    FirebaseUser user = await _auth.currentUser();
    studentsByID = await _studentService.getStudentsByID(id:id);
    notifyListeners();
  }


}