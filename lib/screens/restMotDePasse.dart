import 'package:analyse_app/providers/user.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/user.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  UserServices user = UserServices();
  String email, msg = "";
  final keys = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Form(
                key: keys,
                child: Column(
                  children: [
                    Text("Login",),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (e) => email = e,
                      validator: (e) => e.isEmpty ? "Champ vide" : null,
                      decoration: InputDecoration(
                          hintText: "Entrer votre email", labelText: "Email"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      onPressed: () async {
                        if (keys.currentState.validate()) {

                          bool send = await user.resetpassword(email);
                          if (send) {
                            msg =
                            "Accéder à votre email pour reinitialiser votre mot de passe";
                            Navigator.of(context).pop();
                            setState(() {});
                          }
                        }
                      },
                      child: Text("Envoyer"),
                    ),
                    Text(msg,)
                  ],
                ),
              ),
            ),
          )),
    );
  }
}