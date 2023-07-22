import 'package:flutter/material.dart';
import 'package:sellandhelp/constants/routes.dart';
import 'package:sellandhelp/utilities/utils.dart';
import 'package:sellandhelp/views/home_page.dart';
import 'package:sellandhelp/widgets/image_list_vew.dart';


class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 27, 27, 27),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -10,
            left: -150,
            child: Row(
              children: [
                ImageListView(startIndex: 0,),
                ImageListView(startIndex: 1,),
                ImageListView(startIndex: 2,),
                ],
            ),
            ),

            //title
            Positioned(
              top: MediaQuery.of(context).size.height * 0.08,
              child: Text("SELL&HELP", textAlign: TextAlign.center,
              style: kTitleStyle,
              ),
            ),

            //information screen
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.60,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.white60,
                      Colors.white,
                      Colors.white,
                    ], 
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                    ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Your Craft \nShows Your Quality",
                    style: kNormalStyle.copyWith(fontSize: 30, height: 1.3),
                    textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30,),
                    Text("Change Your Lifestyle \nTo Natural With SELL&HELP",
                    style: kNormalStyle.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: bulidIndicator(),
                      ),
                  ],
                ),
              ),
            ),

            //bottom Button
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: SizedBox(
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)
                    ),
                  ),
                  onPressed:(){
                    // Navigator.push(context, MaterialPageRoute(builder: ((context) => const HomeScreen())) );
                    Navigator.of(context).pushNamedAndRemoveUntil(HomeScreenRoute, (_) => false);
                  },
                  child: const Text("Let's Begin"), 
                  ), 
                ) ,
            ),
        ],
        ),
    );
  }
}