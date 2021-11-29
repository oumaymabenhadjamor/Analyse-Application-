import 'package:analyse_app/models/class.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClassServices {
  String collection = "classes";
  Firestore _firestore = Firestore.instance;
  Future<void> deleteClass({String id} )async
  {

      await  _firestore.collection(collection). document(id).delete();


  }
  void createClass({String id,String classname,String enseignantId}) {


    Firestore.instance
        .collection('classes').document(id).setData({
      "id": id,
      "classname": classname,
      "enseignantId": enseignantId,

    });
  }
  Future<List<ClassModel>> getClasses() async =>
      _firestore.collection(collection).getDocuments().then((result) {
        List<ClassModel> classes = [];
        for(DocumentSnapshot classe in result.documents){
          classes.add(ClassModel.fromSnapshot(classe));
        }
        return classes;
      });

  Future<ClassModel> getClassById({String id}) => _firestore.collection(collection).document(id.toString()).get().then((doc){
    return ClassModel.fromSnapshot(doc);
  });

  Future<List<ClassModel>> getClassByUser({String id}) async =>
      _firestore
          .collection(collection)
          .where("enseignantId", isEqualTo: id)
          .getDocuments()
          .then((result) {
        List<ClassModel> classes = [];
        for (DocumentSnapshot classe in result.documents) {
          classes.add(ClassModel.fromSnapshot(classe));
        }
        return classes;
      });


  Future<List<ClassModel>> searchClass({String classname,String id}) {

    String searchKey = classname[0].toUpperCase() + classname.substring(1);
    return _firestore
        .collection(collection)
        .orderBy("classname")
        .where("enseignantId", isEqualTo: id)
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
     .limit(20)
        .getDocuments()
        .then((result) {
      List<ClassModel> classes = [];
      for (DocumentSnapshot classe in result.documents) {
        classes.add(ClassModel.fromSnapshot(classe));
      }
      return classes;
    });
  }
}