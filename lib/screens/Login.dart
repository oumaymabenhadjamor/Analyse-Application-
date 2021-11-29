
import 'package:analyse_app/helpers/AppColor.dart';
import 'package:analyse_app/helpers/AppTextStyle.dart';
import 'package:analyse_app/providers/user.dart';
import 'package:analyse_app/screens/helloScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';
import 'loading.dart';
import 'restMotDePasse.dart';
import 'screen_navigation.dart';
Color lightBlue = Color(0xffdbf0f1);
class Log extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Log> {

  final _key =GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final authProvider =Provider.of<UserProvider>(context);
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
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: Colors.black,
              size: 30,

            ),
          )
        ],
      ),
      body: authProvider.status == Status.Authenticating? Loading() :SingleChildScrollView(

        child: Container(
          color: lightBlue,
          /*decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [lightBlue, AppColor.primary]),
          ),*/
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    child:  Padding(
                      padding: const EdgeInsets.only(bottom:54.0),
                      child: Image.asset("assets/splash2.png"),
                    )

                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        SizedBox(height: 40),
                        Text(
                          "مرحبا أستاذ",
                          style: AppTextStyle.style(
                              fontSize: 34, fontWeight: FontWeight.w600
                              ,color: Colors.black),
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
                              lightBlue,
                              AppColor.primary.withOpacity(0.7)
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
                                  if(!await authProvider.signIn()) {
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
                                      'تسجيل الدخول',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (ctx) => ResetPassword()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 190),
                              child: Text(
                                'هل نسيت كلمة السر؟',
                                  textAlign: TextAlign.right,
                                style: AppTextStyle.style(
                                  color: Colors.black.withOpacity(0.8),

                                ),
                              ),
                            ),
                          )
                        ],
                      )
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