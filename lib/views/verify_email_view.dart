
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text("Verify Email Address")),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(children: [
              const Text("Please verify your email address...",style: TextStyle(color: Colors.red,fontSize: 20.0
        ,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
              TextButton(onPressed: ()async{
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
                Navigator.of(context).pushNamedAndRemoveUntil("/login/", (route) => false);
              }, 
              child: const Text("Send Verification",
              ),
              style: TextButton.styleFrom(
                foregroundColor: Colors.green,
                padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(fontSize: 20.0),
              )
              ),
            ]
            ),
        ),
      ),
    );
  }
}