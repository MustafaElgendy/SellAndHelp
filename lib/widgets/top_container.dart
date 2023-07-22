import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sellandhelp/utilities/utils.dart';

class TopContainer extends StatelessWidget {
  final String title;
  final String searchBarTitle;
  const TopContainer({super.key, required this.title, required this.searchBarTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //title
        Row(
          children: [
            Text(
              title,
              style: kNormalStyle.copyWith(fontSize: 22, fontWeight: FontWeight.w500,),
            ),
            const Spacer(),
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[350]
                ),
                child: Stack(
                  children: [
                    const Icon(FontAwesomeIcons.bell, color: Colors.black87, size: 20,
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        height: 8,
                        width: 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.orange
                        ),
                      ),
                    ),
                  ],
                  ),
            ),
            const SizedBox(width: 10,),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: CachedNetworkImage(
                imageUrl:"https://avatars.githubusercontent.com/u/49105493?v=4",
                height: 40,
                width: 40, 
                fit: BoxFit.cover,
                ),
            ),
          ],
        ),

        //search bar
        Container(
          margin: const EdgeInsets.symmetric(vertical: 30),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.grey[350]
          ),
          child: Row(
            children: [
              const Icon(FontAwesomeIcons.magnifyingGlass,size: 20,),
              const SizedBox(width: 10,),
              Text(searchBarTitle, 
              style: const TextStyle(
                color: Colors.black38, 
                fontWeight: FontWeight.w400,
              ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}