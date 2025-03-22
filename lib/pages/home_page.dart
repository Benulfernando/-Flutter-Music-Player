import 'package:flutter/material.dart';
import 'package:music_player/components/drawer_file.dart';
import 'package:music_player/components/playlist_provider.dart';
import 'package:music_player/components/song.dart';
import 'package:music_player/pages/song_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late final dynamic playListProvider;

  @override
  void initState() {
    super.initState();

    playListProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  void goToSong(int songIndex){
    //update current song
    playListProvider.currentSongIndex = songIndex;
    Navigator.push(context, MaterialPageRoute(builder: (context) => SongPage()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          "S O N G   L I S T",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      drawer: const Drawer(
        child: DrawerFile(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Consumer<PlaylistProvider>(
          builder: (context, value, child) {
            final List<Song> playList = value.playList;
            return ListView.builder(
              itemCount: playList.length,
              itemBuilder: (context, index){
                final Song song = playList[index];
                return ListTile(
                  title: Text(song.songName),
                  subtitle: Text(song.artistName),
                  leading: Image.asset(song.albumImagePath),
                  onTap: () => goToSong(index),
                );
              }
            );
          },
        ),
      ),
    );
  }
}
