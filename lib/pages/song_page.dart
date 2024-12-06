import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spyder/componenets/neu_box.dart';
import 'package:spyder/models/playlist_provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  // convert duration into min: sec

  String formatTime(Duration duration) {
    String twoDigitSecond = duration.inSeconds.remainder(60).toString().padLeft(2,'0');
    String formattedTime = "${duration.inMinutes}:$twoDigitSecond";

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(builder: (context, value, child) {
      // get the playlist

final playlist = value.playlist;

      // get current song index

final currentSong = playlist[value.currentSongIndex??0];

      // return scaffold UI

      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //appbar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // back button
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon:const Icon(Icons.arrow_back),
                    ),

                    // title
                    const Text("P L A Y L I S T"),

                    // menu button
                    IconButton(
                      onPressed: () {},
                      icon:const Icon(Icons.menu),
                    ),
                  ],
                ),
                const SizedBox(height: 25),

                // album artwork
                NeuBox(
                  child: Column(
                    children: [
                      // image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(currentSong.albumArtImagePath),
                      ),
                      // song and artist name a icon
                       Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // song and artist name
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentSong.songName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(currentSong.artistName),
                              ],
                            ),

                            // heart icon
                            const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                // song duration progress
                Column(
                  children: [
                     Padding(
                      padding: const EdgeInsets.symmetric(horizontal:25.0),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // start time
                          Text(formatTime(value.currentDuration)),

                          // shuffle icon
                        const  Icon(Icons.shuffle),

                          // repeat icon
                        const  Icon(Icons.repeat),

                          // end time
                          Text(formatTime(value.totalDuration)),
                        ],
                      ),
                    ),

                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 0),
                      ),
                      child: Slider(
                        min: 0,
                        max: value.totalDuration.inSeconds.toDouble(),
                        value: value.currentDuration.inSeconds.toDouble(),
                        activeColor: Colors.green,
                        onChanged: (double double) {
                          // during when the user is sliding around
                        },
                        onChangeEnd: (double double){
                          // sliding has finished, go to that position in song duration
                          value.seek(Duration(seconds: double.toInt()));

                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                // playback controls
                Row(
                  children: [
                    // skip previous
                    Expanded(
                      child: GestureDetector(
                        onTap: value.playPreviousSong,
                        child: const NeuBox(
                          child: Icon(Icons.skip_previous),
                        ),
                      ),
                    ),

                    const SizedBox(width: 20),
                    // play pause
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: value.pauseOrResume,
                        child:  NeuBox(
                          child: Icon(value.isPlaying ? Icons.pause: Icons.play_arrow),
                        ),
                      ),
                    ),

                    const SizedBox(width: 20),
                    // skip forward
                    Expanded(
                      child: GestureDetector(
                        onTap: value.playNextSong,
                        child: const NeuBox(
                          child: Icon(Icons.skip_next),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
    );
  }
}
