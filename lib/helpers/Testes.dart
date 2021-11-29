import 'package:analyse_app/models/Testes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class TestServices{
  String collection = "Testes";
  Firestore _firestore = Firestore.instance;


  Future<List<TestModel>> getTestes() async =>
      _firestore.collection(collection).getDocuments().then((result) {
        List<TestModel> testes = [];
        for(DocumentSnapshot test in result.documents){
          testes.add(TestModel.fromSnapshot(test));
        }
        return testes;
      });

  Future<List<TestModel>> getTestsByUser({String id}) async =>
      _firestore
          .collection(collection)
          .where("userId", isEqualTo: id)
                .getDocuments()
          .then((result) {
        List<TestModel> testes = [];
        for (DocumentSnapshot test in result.documents) {
          testes.add(TestModel.fromSnapshot(test));
        }
        return testes;
      });

  void createStudent(Map<String, dynamic> values) {
    String id = values["id"];
    _firestore.collection(collection).document(id).setData(values);
  }

  Future<List<TestModel>> countDyslexie({String id})  {

    return   _firestore
        .collection("Testes")
        .where("scoreDyslexie", isLessThanOrEqualTo: 2)
        .where('enseignantId', isEqualTo: id)
        .getDocuments()
        .then((result) {
      List<TestModel> test = [];
      for (DocumentSnapshot  stud in result.documents) {
        test.add(TestModel.fromSnapshot(stud));
      }
      return test;
    });

    // Count of Documents in Collection
  }
  Future<List<TestModel>> countMyopie({String id})  {

    return   _firestore
        .collection("Testes")
        .where("scoreMyopie", isLessThanOrEqualTo: 3)
        .where('enseignantId', isEqualTo: id)
        .getDocuments()
        .then((result) {
      List<TestModel> test = [];
      for (DocumentSnapshot  stud in result.documents) {
        test.add(TestModel.fromSnapshot(stud));
      }
      return test;
    });

    // Count of Documents in Collection
  }

  Future<List<TestModel>> countDaltonisme({String id})  {

    return   _firestore
        .collection("Testes")
        .where("scoreColorBlind", isLessThanOrEqualTo: 4)
        .where('enseignantId', isEqualTo: id)
        .getDocuments()
        .then((result) {
      List<TestModel> test = [];
      for (DocumentSnapshot  stud in result.documents) {
        test.add(TestModel.fromSnapshot(stud));
      }
      return test;
    });

    // Count of Documents in Collection
  }
  Future<List<TestModel>> countDysphasie({String id})  {

    return   _firestore
        .collection("Testes")
        .where("scoreDysphasie", isLessThanOrEqualTo: 1)
        .where('enseignantId', isEqualTo: id)
        .getDocuments()
        .then((result) {
      List<TestModel> test = [];
      for (DocumentSnapshot  stud in result.documents) {
        test.add(TestModel.fromSnapshot(stud));
      }
      return test;
    });

    // Count of Documents in Collection
  }

  Future<List<TestModel>> countDyspraxie({String id})  {

    return   _firestore
        .collection("Testes")
        .where("scoreDyspraxie", isLessThanOrEqualTo: 2)
        .where('enseignantId', isEqualTo: id)
        .getDocuments()
        .then((result) {
      List<TestModel> test = [];
      for (DocumentSnapshot  stud in result.documents) {
        test.add(TestModel.fromSnapshot(stud));
      }
      return test;
    });

    // Count of Documents in Collection
  }

  Future<List<TestModel>> countDyscalculie({String id})  {

    return   _firestore
        .collection("Testes")
        .where("scoreDyscalculie", isLessThanOrEqualTo: 3)
        .where('enseignantId', isEqualTo: id)
        .getDocuments()
        .then((result) {
      List<TestModel> test = [];
      for (DocumentSnapshot  stud in result.documents) {
        test.add(TestModel.fromSnapshot(stud));
      }
      return test;
    });

    // Count of Documents in Collection
  }
  Future<List<TestModel>> countStudentsByEnseignant({String id})  {

    return   _firestore
        .collection("Testes")
        .where("enseignantId", isEqualTo: id)
        .getDocuments()
        .then((result) {
      List<TestModel> test = [];
      for (DocumentSnapshot  stud in result.documents) {
        test.add(TestModel.fromSnapshot(stud));
      }
      return test;
    });

    // Count of Documents in Collection
  }

  Future<List<TestModel>> countDaltoByClass({String id,String classe,String maladie})  {

    return   _firestore
        .collection("Testes")
        .where("scoreColorBlind", isLessThanOrEqualTo: 4)
        .where('enseignantId', isEqualTo: id)
        .where('classId', isEqualTo: classe)
        .getDocuments()
        .then((result) {
      List<TestModel> test = [];
      for (DocumentSnapshot  stud in result.documents) {
        test.add(TestModel.fromSnapshot(stud));
      }
      return test;
    });

    // Count of Documents in Collection
  }
  Future<List<TestModel>> countDyscalculieByClass({String id,String classe,String maladie})  {

    return   _firestore
        .collection("Testes")
        .where("scoreDyscalculie", isLessThanOrEqualTo: 3)
        .where('enseignantId', isEqualTo: id)
        .where('classId', isEqualTo: classe)
        .getDocuments()
        .then((result) {
      List<TestModel> test = [];
      for (DocumentSnapshot  stud in result.documents) {
        test.add(TestModel.fromSnapshot(stud));
      }
      return test;
    });

    // Count of Documents in Collection
  }
  Future<List<TestModel>> countDysphasieByClass({String id,String classe,String maladie})  {

    return   _firestore
        .collection("Testes")
        .where("scoreDysphasie", isLessThanOrEqualTo: 1)
        .where('enseignantId', isEqualTo: id)
        .where('classId', isEqualTo: classe)
        .getDocuments()
        .then((result) {
      List<TestModel> test = [];
      for (DocumentSnapshot  stud in result.documents) {
        test.add(TestModel.fromSnapshot(stud));
      }
      return test;
    });

    // Count of Documents in Collection
  }
  Future<List<TestModel>> countDyspraxieByClass({String id,String classe,String maladie})  {

    return   _firestore
        .collection("Testes")
        .where("scoreDyspraxie", isLessThanOrEqualTo: 2)
        .where('enseignantId', isEqualTo: id)
        .where('classId', isEqualTo: classe)
        .getDocuments()
        .then((result) {
      List<TestModel> test = [];
      for (DocumentSnapshot  stud in result.documents) {
        test.add(TestModel.fromSnapshot(stud));
      }
      return test;
    });

    // Count of Documents in Collection
  }
  Future<List<TestModel>> countDyslexieByClass({String id,String classe,String maladie})  {

    return   _firestore
        .collection("Testes")
        .where("scoreDyslexie", isLessThanOrEqualTo: 2)
        .where('enseignantId', isEqualTo: id)
        .where('classId', isEqualTo: classe)
        .getDocuments()
        .then((result) {
      List<TestModel> test = [];
      for (DocumentSnapshot  stud in result.documents) {
        test.add(TestModel.fromSnapshot(stud));
      }
      return test;
    });

    // Count of Documents in Collection
  }

  Future<List<TestModel>> countMyopieByClass({String id,String classe})  {

    return   _firestore
        .collection("Testes")
        .where("scoreMyopie", isLessThanOrEqualTo: 3)
        .where('enseignantId', isEqualTo: id)
        .where('classId', isEqualTo: classe)
        .getDocuments()
        .then((result) {
      List<TestModel> test = [];
      for (DocumentSnapshot  stud in result.documents) {
        test.add(TestModel.fromSnapshot(stud));
      }
      return test;
    });

    // Count of Documents in Collection
  }
  Future<List<TestModel>> countTestsByClass({String id,String classe})  {

    return   _firestore
        .collection("Testes")
        .where('enseignantId', isEqualTo: id)
        .where('classId', isEqualTo: classe)
        .getDocuments()
        .then((result) {
      List<TestModel> test = [];
      for (DocumentSnapshot  stud in result.documents) {
        test.add(TestModel.fromSnapshot(stud));
      }
      return test;
    });

    // Count of Documents in Collection
  }
  Future<List<TestModel>> countNegativesByClass({String id,String classe})  {

    return   _firestore
        .collection("Testes")
        .where("scoreColorBlind", isGreaterThanOrEqualTo: 4)
        .where("scoreMyopie", isGreaterThanOrEqualTo: 3)
        .where("scoreDyslexie", isGreaterThanOrEqualTo: 1)
        .where("scoreDyspraxie", isEqualTo:1)
        .where("scoreDysphasie", isEqualTo: 1)
        .where("scoreDyscalculie", isGreaterThanOrEqualTo: 3)

        .where('enseignantId', isEqualTo: id)
        .where('classId', isEqualTo: classe)
        .getDocuments()
        .then((result) {
      List<TestModel> test = [];
      for (DocumentSnapshot  stud in result.documents) {
        test.add(TestModel.fromSnapshot(stud));
      }
      return test;
    });

    // Count of Documents in Collection
  }
  }


