
import 'package:analyse_app/models/students.dart';
import 'package:analyse_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:path/path.dart';
class StudentServices{
  String collection = "users";
  File _image;
  String url;
  Firestore _firestore = Firestore.instance;




  Future<List<StudentModel>> getStudentsByClass({String id}) async =>
      _firestore
          .collection(collection)
          .where("classId", isEqualTo: id)
          .getDocuments()
          .then((result) {
        List<StudentModel> students = [];
        for (DocumentSnapshot student in result.documents) {
          students.add(StudentModel.fromSnapshot(student));
        }
        return students;
      });
  Future<int> getCountStudentsByClass({String id}) async =>
      _firestore
          .collection(collection)
          .where("classId", isEqualTo: id)
          .getDocuments()
          .then((result) {
        List<StudentModel> students = [];
        for (DocumentSnapshot student in result.documents) {
          students.add(StudentModel.fromSnapshot(student));
        }
        return students.length;
      });
  Future<List<StudentModel>> getStudentsByLevel({String id}) async =>
      _firestore
          .collection(collection)
          .where("niveau",isGreaterThan: 0)
          .where('enseignant', isEqualTo: id)
          .getDocuments()
          .then((result) {
        List<StudentModel> students = [];
        for (DocumentSnapshot student in result.documents) {
          students.add(StudentModel.fromSnapshot(student));
        }
        return students;
      });
  Future<List<StudentModel>> getStudentsByID({String id}) async =>
      _firestore
          .collection(collection)

          .where('ud', isEqualTo: id)
          .getDocuments()
          .then((result) {
        List<StudentModel> students = [];
        for (DocumentSnapshot student in result.documents) {
          students.add(StudentModel.fromSnapshot(student));
        }
        return students;
      });

  Future<List<StudentModel>> searchStudent({String name,String id}) {

    String searchKey = name[0].toUpperCase() +name.substring(1);
    return _firestore
        .collection(collection)
        .where("classId", isEqualTo: id)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
    .limit(30)

        .getDocuments()
        .then((result) {
      List<StudentModel> student = [];
      for (DocumentSnapshot  stud in result.documents) {
        student.add(StudentModel.fromSnapshot( stud));
      }
      return  student;
    });
  }


  Future<List<StudentModel>> getStudents() async =>
      _firestore.collection(collection).getDocuments().then((result) {
        List<StudentModel> students = [];
        for (DocumentSnapshot student in result.documents) {
          students.add(StudentModel.fromSnapshot(student));
        }
        return students;
      });


  void countStudents() async {
    QuerySnapshot _myDoc = await Firestore.instance.collection('users').getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    print(_myDocCount.length);  // Count of Documents in Collection
  }
  void createStudent(Map<String, dynamic> values) {
    String id = values["idd"];
    _firestore.collection(collection).document(id).setData(values);
  }

    Future<void> deleteStudent({String id} )async
    {

      await  _firestore.collection(collection). document(id).delete();
  }

}