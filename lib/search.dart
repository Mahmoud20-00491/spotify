import 'package:flutter/material.dart';
import 'package:spotify/presistent_nav_bar.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: Navbar(
        favoriteIconColor: Colors.white,
        homeIconColor: Colors.white,
        searchIconColor: Color.fromARGB(255, 26, 199, 32),
        settingsIconColor: Colors.white,
      ),
      body: Center(
        child: Text(
          'Search',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
