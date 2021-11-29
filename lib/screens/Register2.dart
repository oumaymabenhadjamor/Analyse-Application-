
import 'package:analyse_app/helpers/AppColor.dart';
import 'package:analyse_app/helpers/AppTextStyle.dart';
import 'package:analyse_app/providers/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'home.dart';
import 'loading.dart';
import 'screen_navigation.dart';
import 'helloScreen.dart';
Color lightBlue = Color(0xffdbf0f1);
class Register extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Register> {
  File _image;
  String url;
  bool active1,active2;
  final _key =GlobalKey<ScaffoldState>();
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   String uri = ModalRoute.of(context).settings.arguments ;
  // print('uri'+uri);
    final authProvider =Provider.of<UserProvider>(context);
    Future uploadPic(BuildContext context) async{
      String fileName = basename(_image.path);


      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);

      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);

      StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;

      url=await taskSnapshot.ref.getDownloadURL();
      setState(() {
        print("Profile Picture uploaded");
        authProvider.image=url.toString();
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
        active1=true;
      });


      print('---------------------------------------------------------------------------------'+authProvider.image.toString());
    }
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        print('Image Path $_image');
      });
    }


    return Scaffold(
      backgroundColor: lightBlue,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
              size: 30,
            ),
            onPressed: (){ changeScreenReplacement(context, HelloScreen());}
        ),

      ),

      body: authProvider.status == Status.Authenticating? Loading() :SingleChildScrollView(

        child: Container(
          color: lightBlue,

          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height * 0.40,
                      child:  Padding(
                        padding: const EdgeInsets.only(bottom:46.0),
                        child: Image.asset("assets/splash2.png"),
                      )

                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.only(left:68.0),
                          child: Text(
                            "مرحبا أستاذ",
                            style: AppTextStyle.style(
                                fontSize: 25, fontWeight: FontWeight.w600
                                ,color: Colors.black),
                          ),
                        ),
                        Text(
                          "قم بتسجيل الدخول للمتابعة",
                          style: AppTextStyle.style(
                              fontSize: 20,
                              color: Colors.black.withOpacity(0.4),
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                  ),
                ],
              ),

              Container(

                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(38),
                    topLeft: Radius.circular(38),
                  ),
                ),

                child: Column(
                  children: [


                    SizedBox(height: 10,),
                    TextFormField(
                        controller: authProvider.name,
                        style: AppTextStyle.style(
                          color: Colors.black.withOpacity(0.8),

                        ),
                        decoration: InputDecoration(
                          hintText: 'اسم االمستخدم',
                          //  labelText: 'البريد الإلكتروني',
                          alignLabelWithHint: true,
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.black.withOpacity(0.8)),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.black.withOpacity(0.8)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.black.withOpacity(0.8)),
                          ),
                          labelStyle: AppTextStyle.style(
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ),
                        textAlign: TextAlign.right
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                        controller: authProvider.email,
                        style: AppTextStyle.style(
                          color: Colors.black.withOpacity(0.8),

                        ),
                        decoration: InputDecoration(
                          hintText: 'البريد الإلكتروني',
                          //  labelText: 'البريد الإلكتروني',
                          alignLabelWithHint: true,
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.black.withOpacity(0.8)),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.black.withOpacity(0.8)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.black.withOpacity(0.8)),
                          ),
                          labelStyle: AppTextStyle.style(
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ),
                        textAlign: TextAlign.right
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                        controller: authProvider.password,
                        style: AppTextStyle.style(
                          color: Colors.black.withOpacity(0.8),
                        ),
                        decoration: InputDecoration(
                          hintText: 'كلمه السر',




                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.black.withOpacity(0.8)),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.black.withOpacity(0.8)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.black.withOpacity(0.8)),
                          ),
                          labelStyle: AppTextStyle.style(
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ),
                        textAlign: TextAlign.right
                    ),
                    SizedBox(height: 32),
                    Container(
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [

                            AppColor.primary.withOpacity(0.4),
                            lightBlue,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(5, 5),
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(

                          child: GestureDetector(
                              onTap: ()async{
                                authProvider.image="https://firebasestorage.googleapis.com/v0/b/login-demo-37c2c.appspot.com/o/user.png?alt=media&token=ca9d7009-ad30-4318-a2b2-673ebb382e7b";

                                //uploadPic(context);
                                 if(!await authProvider.signUp()) {
                                  _key.currentState.showSnackBar(
                                      SnackBar(content: Text("فشل عملية الدخول!"))
                                  );
                                  return;
                                }

                              authProvider.clearController();
                                changeScreenReplacement(context, HomePage());
                              },
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 32),
                                  child: Text(
                                    'إنشاء حساب',
                                    style: AppTextStyle.style(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Icon(Icons.arrow_forward,
                                color: Colors.white, size: 32),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}