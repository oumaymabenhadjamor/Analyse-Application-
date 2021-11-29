import 'package:analyse_app/helpers/class.dart';
import 'package:analyse_app/models/class.dart';
import 'package:analyse_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';


class ClassProvider with ChangeNotifier{
  ClassServices _classServices = ClassServices();
  List<ClassModel> classes = [];
  List<ClassModel> classesByUser=[];
  List<ClassModel> searchedClasses=[];
  FirebaseUser _user;
  ClassModel classe;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController name = TextEditingController();

  ClassProvider.initialize() {
    loadClasses();

  }

  loadClasses()async{
    classes = await _classServices.getClasses();
    notifyListeners();
  }

  loadSingleClass({String classId}) async{
    classe = await _classServices.getClassById(id: classId);
    notifyListeners();
  }



  Future<bool> createClass()async{
    notifyListeners();
    try{
      var uuid = Uuid();
      String classId = uuid.v4();
      final FirebaseUser user = await _auth.currentUser();

      _classServices.createClass(id:classId ,classname:name.text,enseignantId:user.uid);


      return true;
    }catch(e){
      print("THE ERROR ${e.toString()}");
      return false;
    }

  }
  void clearController(){
    name.text = "";

  }

   removeClass({String id})async{

    await _classServices.deleteClass(id:id);
    notifyListeners();

  }

  Future loadClassesByUser({String enseignantId})async{
    FirebaseUser user = await _auth.currentUser();
    classesByUser = await _classServices.getClassByUser(id:user.uid);
    notifyListeners();
  }

  Future search({String name ,String id})async{
    FirebaseUser user = await _auth.currentUser();
    searchedClasses = await _classServices.searchClass(classname: name,id: user.uid);
    print("RESTOS ARE: ${searchedClasses.length}");
    notifyListeners();
  }

}