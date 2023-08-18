import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:spotify/settings.dart';
import 'package:spotify/songs_json.dart';

import 'favorite.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({
    super.key,
    this.song,
    this.subtitle,
    this.index,
  });
  final dynamic song;
  final dynamic subtitle;
  final dynamic index;

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  bool isFav = false;
  Duration currentPosistion = Duration();
  Duration musicLenght = Duration();

  playMusic() async {
    if (songs.length > widget.index &&
        songs[widget.index]['song_url'] != null) {
      await audioPlayer.setSource(AssetSource(songs[widget.index]['song_url']));
      await audioPlayer.resume();
    } else {
      print('Invalid song data or index');
    }
  }

  pauseMusic() {
    audioPlayer.pause();
  }

  stopMusic() {
    audioPlayer.stop();
  }

  @override
  void initState() {
    super.initState();
    setUp();
  }

  setUp() {
    audioPlayer.onDurationChanged.listen((Duration dd) {
      setState(() {
        musicLenght = dd;
      });
    });
    audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() {
        currentPosistion = p;
      });
    });
  }

  void updateAudioPosition(double value) {
    setState(() {
      currentPosistion = Duration(milliseconds: value.toInt());
    });
    audioPlayer.seek(currentPosistion);
  }

  @override
  Widget build(BuildContext context) {
    musicLenght.inSeconds.toDouble();
    List songAlbums = widget.song['songs'];
    int indexing = 0;
    indexing = widget.index;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  stopMusic();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
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
            ]),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: widget.song['color'],
                      offset: Offset(-5, 5),
                      blurRadius: 20,
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage(widget.song['img']),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(25)),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (isFav) {
                          isFav = false;
                          fav_songs.remove(widget
                              .song); // Remove the song from fav_songs list
                        } else {
                          isFav = true;
                          fav_songs.add(
                              widget.song); // Add the song to fav_songs list
                        }
                        Favorite(
                          index: indexing,
                        );
                      });
                    },
                    icon: isFav
                        ? Icon(Icons.favorite)
                        : Icon(Icons.favorite_border_outlined),
                    color: isFav ? Colors.green : Colors.white,
                    iconSize: 30,
                  ),
                  Column(
                    children: [
                      Text(
                        widget.song['title'],
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(widget.subtitle,
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert_outlined),
                    color: Colors.white,
                    iconSize: 30,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${currentPosistion.inMinutes}:${(currentPosistion.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: TextStyle(color: Colors.white),
                ),
                Container(
                  width: 300,
                  child: Slider(
                    activeColor: Colors.green,
                    value: currentPosistion.inMilliseconds.toDouble(),
                    max: musicLenght.inMilliseconds.toDouble(),
                    onChanged: (val) {
                      updateAudioPosition(val);
                    },
                  ),
                ),
                Text(
                  '${musicLenght.inMinutes - currentPosistion.inMinutes}:${((musicLenght.inSeconds - currentPosistion.inSeconds) % 60).toString().padLeft(2, '0')}',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Next: ",
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600)),
                Text(songAlbums[widget.index + 1]['title'],
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_circle_left_outlined,
                    color: Colors.white,
                  ),
                  iconSize: 50,
                ),
                CircleAvatar(
                  radius: 26,
                  backgroundColor: isPlaying ? Colors.green : Colors.white,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        if (isPlaying) {
                          pauseMusic();
                          isPlaying = false;
                        } else {
                          isPlaying = true;
                          playMusic();
                        }
                      });
                    },
                    icon: isPlaying
                        ? const Icon(
                            Icons.pause,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.play_arrow,
                            color: Colors.black,
                          ),
                    iconSize: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_circle_right_outlined,
                    color: Colors.white,
                  ),
                  iconSize: 50,
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
