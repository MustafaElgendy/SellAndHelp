
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sellandhelp/firebase_options.dart';
import 'dart:developer' as devtools show log;


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Column(
              children: [
                TextField(controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: "Enter your email here"
                ),),
                TextField(controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  hintText: "Enter your password here"
                ),),
                TextButton(onPressed: () async {
       
                  final email = _email.text;
                  final password = _password.text;
                  try{
                    final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email, password: password);
                  print(user);
                  }on FirebaseAuthException catch (e){
                    if (e.code == "user-not-found"){
                      print("User not found");
                    }else if(e.code == "wrong-password"){
                      print("Wrong password");
                    }else if(e.code == "unknown"){
                      print("Unknown!!!");
                    }else print(e.code);
                  }
                  final user2 = FirebaseAuth.instance.currentUser;
                  if (user2 != null){
                  if (user2.emailVerified){
                    Navigator.of(context).pushNamedAndRemoveUntil("/mainui/", (route) => false);
                  }else{
                    Navigator.of(context).pushNamedAndRemoveUntil("/verification/", (route) => false);
                  }
                }else{
                  devtools.log("Erorr!!");
                }
                  
                },
                child: const Text("Login"),
                ),
                TextButton(onPressed: (){
                  Navigator.of(context).pushNamedAndRemoveUntil("/register/", (route) => false);
                }, 
                child: const Text("Not registered yet! Register here.")),
              ],
            ),
    );
  }
 
}