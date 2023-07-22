import 'package:flutter/material.dart';
import 'package:sellandhelp/constants/routes.dart';
import 'package:sellandhelp/services/auth/auth_service.dart';
import 'package:sellandhelp/views/home_page.dart';
import 'package:sellandhelp/views/login_view.dart';
import 'package:sellandhelp/views/main_ui.dart';
import 'package:sellandhelp/views/register_view.dart';
import 'package:sellandhelp/views/verify_email_view.dart';

import 'dart:developer' as devtools show log;


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
        LoginRoute:(context) => const LoginPage(),
        RegisterRoute:(context) => const RegisterPage(),
        VerifyRoute:(context) => const VerifyEmailView(),
        MainUIRoute:(context) => const MainUI(),
        HomeScreenRoute:(context) => const HomeScreen(),
      },
    ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

 @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body:FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: 
        (BuildContext context, snapshot) { 
           switch (snapshot.connectionState){
                case ConnectionState.done:
                final user = AuthService.firebase().currentUser;
                devtools.log(user.toString());
                if (user != null){
                  if (user.isEmailVerified){
                    return const MainUI();
                  }else{
                    return const VerifyEmailView();
                  }
                }else{
                  return const LoginPage();
                }
                
          default:
          return Scaffold(body: Center(child: const CircularProgressIndicator()));
            }
         },
        ),
    );
  }
}




