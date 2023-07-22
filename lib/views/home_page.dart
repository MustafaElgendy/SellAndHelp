import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sellandhelp/constants/routes.dart';
import 'package:sellandhelp/services/auth/auth_service.dart';
import 'package:sellandhelp/views/category_display_screen.dart';
import 'package:sellandhelp/views/product_display_screen.dart';

import '../enums/menu_action.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int currentIndex = 0;
  final pageController = PageController(initialPage: 0);

  final tabBarIcons = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.compass,
    FontAwesomeIcons.cartShopping,
    FontAwesomeIcons.user,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page"),
      actions: [
        PopupMenuButton<MenuAction>(
          onSelected: (value) async{
            switch (value){
              case MenuAction.logout:
              final shouldLogOut = await showLogOutDialog(context);
              if(shouldLogOut){
                await AuthService.firebase().logOut();
                Navigator.of(context).pushNamedAndRemoveUntil(LoginRoute, (_) => false);
              }
            }
              
            },
          itemBuilder:(context) {
            return const[
              PopupMenuItem<MenuAction>(
                value: MenuAction.logout,
                child: Text("Log Out"))
            ];
          
        },)
      ],
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              children:const [
                ProductDisplayScreen(),
                CategoryDisplayScreen(),
              ],
            ),

            //bottom bar
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Container(
                alignment: Alignment.center,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0), 
                  color: Colors.green[800]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ...tabBarIcons.map((icon) => IconButton(
                        onPressed: (){
                          icon == FontAwesomeIcons.house ? pageController.jumpToPage(0): pageController.jumpToPage(1);
                        }, 
                      icon: Icon(icon, color: Colors.white60,size: 22,),
                      ),
                      ),
                    ],
                  ),
              ),
            ),
          ],
          ),
      ),
    );
  }
}


Future<bool> showLogOutDialog(BuildContext context){
  return showDialog(context: context, 
  builder:(context) {
    return AlertDialog(
      title: const Text("Sign Out"),
      content: const Text("Are tou sure you want to sign out?"),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop(false);
        }, 
        child: const Text("Cancel")),
        TextButton(onPressed: (){
          Navigator.of(context).pop(true);
        }, 
        child: const Text("Log Out")),
      ],
    );
  }
  ).then((value) => value ?? false);
}

