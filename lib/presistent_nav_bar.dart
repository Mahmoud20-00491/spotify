import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:spotify/favorite.dart';
import 'package:spotify/homepage.dart';
import 'package:spotify/search.dart';
import 'package:spotify/settings.dart';

class Navbar extends StatefulWidget {
  final Color homeIconColor;
  final Color favoriteIconColor;
  final Color searchIconColor;
  final Color settingsIconColor;

  const Navbar({
    Key? key,
    required this.homeIconColor,
    required this.favoriteIconColor,
    required this.searchIconColor,
    required this.settingsIconColor,
  }) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                    alignment: Alignment.bottomCenter,
                    child: const HomePage(),
                    type: PageTransitionType.scale,
                  ));
            },
            icon: Icon(
              Icons.home,
              color: widget.homeIconColor,
            ),
            iconSize: 30,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                    alignment: Alignment.bottomCenter,
                    child: Favorite(),
                    type: PageTransitionType.scale,
                  ));
            },
            icon: Icon(
              Icons.favorite,
              color: widget.favoriteIconColor,
            ),
            iconSize: 30,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                    alignment: Alignment.bottomCenter,
                    child: Search(),
                    type: PageTransitionType.scale,
                  ));
            },
            icon: Icon(
              Icons.search,
              color: widget.searchIconColor,
            ),
            iconSize: 30,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                    alignment: Alignment.bottomCenter,
                    child: Settings(),
                    type: PageTransitionType.scale,
                  ));
            },
            iconSize: 30,
            icon: Icon(
              Icons.settings,
              color: widget.settingsIconColor,
            ),
          ),
        ],
      ),
    );
  }
}
