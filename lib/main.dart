import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sellandhelp/views/login_view.dart';
import 'package:sellandhelp/views/register_view.dart';
import 'package:sellandhelp/views/verify_email_view.dart';
import 'firebase_options.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(),
      routes: {
        "/login/":(context) => const LoginPage(),
        "/register/":(context) => const RegisterPage(),
        "/verification/":(context) => const VerifyEmailView(),
      },
    ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

 @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body:FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ), builder: 
        (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) { 
           switch (snapshot.connectionState){
                case ConnectionState.done:
                final user = FirebaseAuth.instance.currentUser;
                if (user != null){
                  if (user.emailVerified){
                    print("Email is verified");
                  }else{
                    return const VerifyEmailView();
                  }
                }else{
                  return const LoginPage();
                }
                return const Text("done");
               
          default:
          return Scaffold(body: Center(child: const CircularProgressIndicator()));
            }
         },
        ),
    );
  }
}

