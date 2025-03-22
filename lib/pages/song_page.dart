import 'package:flutter/material.dart';
import 'package:music_player/components/neu_box.dart';
import 'package:music_player/components/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  String formatTime(Duration duration){
    String twoDigitSeconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0').padRight(2, '0');
    String formattedTime = "${duration.inMinutes}: $twoDigitSeconds";
    
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) {
        //get playlist
        final playList = value.playList;

        //get current song index
        final currentSong = playList[value.currentSongIndex ?? 0];

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "S O N G   L I S T",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30, bottom: 5, right: 20, left: 20),
                  child: NeuBox(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(currentSong.albumImagePath),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 8, left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentSong.artistName,
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      currentSong.songName
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(formatTime(value.currentDuration)),
                            Icon(Icons.shuffle),
                            Icon(Icons.repeat),
                            Text(formatTime(value.totalDuration))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:15),
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0)
                          ),
                          child: Slider(
                              min: 0,
                              max: value.totalDuration.inSeconds.toDouble(),
                              value: value.currentDuration.inSeconds.toDouble(),
                              activeColor: Colors.green,
                              inactiveColor: Colors.grey,
                              onChanged: (double double) {

                              },
                              onChangeEnd:(double double){
                                value.seek(Duration(seconds: double.toInt()));
                              } ,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: value.playPreviousSong,
                          child: NeuBox(
                              child:Icon(Icons.skip_previous)
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: GestureDetector(
                          onTap: value.pauseOrPlay,
                          child: NeuBox(
                              child:Icon(value.isPlaying ? Icons.pause: Icons.play_arrow)
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: GestureDetector(
                          onTap: value.playNextSong,
                          child: NeuBox(
                              child:Icon(Icons.skip_next)
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
