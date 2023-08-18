import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:spotify/presistent_nav_bar.dart';
import 'package:spotify/settings.dart';
import 'package:spotify/songs_json.dart';

import 'music_page.dart';

class Favorite extends StatefulWidget {
  const Favorite({
    Key? key,
    this.index,
  }) : super(key: key);

  final dynamic index;

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  int indexing = 0;

  @override
  void initState() {
    super.initState();
    if (widget.index is int &&
        widget.index >= 0 &&
        widget.index < fav_songs.length) {
      indexing = widget.index;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (fav_songs.isEmpty) {
      return Scaffold(
        bottomNavigationBar: const Navbar(
          favoriteIconColor: Color.fromARGB(255, 26, 199, 32),
          homeIconColor: Colors.white,
          searchIconColor: Colors.white,
          settingsIconColor: Colors.white,
        ),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Your Library",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                alignment: Alignment.bottomCenter,
                                child: Settings(),
                                type: PageTransitionType.scale));
                      },
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage("assets/images/user.jpg"),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 300,
                ),
                Text(
                  'There are no favorite songs yet!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    List<dynamic> subtitle = fav_songs[indexing]['songs'];

    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: const Navbar(
        favoriteIconColor: Color.fromARGB(255, 26, 199, 32),
        homeIconColor: Colors.white,
        searchIconColor: Colors.white,
        settingsIconColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Your Library",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("assets/images/user.jpg"),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: fav_songs.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                alignment: Alignment.bottomCenter,
                                child: MusicPage(
                                  song: fav_songs[index],
                                  index: index,
                                  subtitle: subtitle[index]['title'],
                                ),
                                type: PageTransitionType.scale));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage(fav_songs[index]['img']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    fav_songs[index]['title'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    subtitle[index]['title'],
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.green,
                              ),
                              iconSize: 30,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.play_circle,
                                color: Colors.white,
                              ),
                              iconSize: 35,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
