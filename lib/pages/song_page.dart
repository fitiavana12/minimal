import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:minimal_music_player/components/neu_box.dart';
import 'package:minimal_music_player/models/playlist_provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  String formatTime(Duration duration){
    String twoDigitSeconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "${duration.inMinutes}:$twoDigitSeconds";
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) {
        final playlist = value.playlist;
        final currentSong = playlist[value.currentSongIndex ?? 0];

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
              child: Column(
                children: [
                  // App bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_back),
                      ),
                      // Playlist
                      Text("P L A Y L I S T"),
                      // menu button
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.menu),
                      ),
                    ],
                  ),

                  // Album artwork
                  NeuBox(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(currentSong.albumImagePath),
                    ),
                  ),

                  // Song and artist information
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Song and artist name
                        Column(
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

                        // Heart icon
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),

                  // Song duration
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Start time
                            Text(formatTime(value.currentDuration)),

                            // Shuffle icon
                            Icon(Icons.shuffle),

                            // Repeat icon
                            Icon(Icons.repeat),

                            // End time
                            Text(formatTime(value.totalDuration)),
                          ],
                        ),
                        SliderTheme(
                          data: SliderThemeData(
                            thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 0,
                            ),
                          ),
                          child: Slider(
                              min: 0,
                              max: value.totalDuration.inSeconds.toDouble(),
                              value: value.currentDuration.inSeconds.toDouble(),
                              activeColor: Colors.green,
                              onChanged: (double value) {},
                              onChangeEnd: (double value){
                                value.seek(Duration(seconds: value.toInt()));
                              }
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Playback controls
                  Row(
                    children: [
                      // Skip previous
                      Expanded(
                        child: GestureDetector(
                          onTap: value.playPreviousSong,
                          child: Icon(Icons.skip_previous),
                        ),
                      ),

                      const SizedBox(width: 25),

                      // Play/pause
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: value.pauseOrResume,
                          child: Icon(value.isPlaying ? Icons.pause: Icons.play_arrow),
                        ),
                      ),

                      const SizedBox(width: 25),

                      // Skip forward
                      Expanded(
                        child: GestureDetector(
                          onTap: value.playNextSong,
                          child: Icon(Icons.skip_next),
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
