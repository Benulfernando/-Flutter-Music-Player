import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player/components/song.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playList = [
    Song(
      songName: "2002",
      artistName: "Anne Marie",
      albumImagePath: "assets/cover/2002Cover.jpg",
      audioPath: "audio/AnneMarie2002.mp3",
    ),
    Song(
      songName: "Die With a Smile",
      artistName: "Bruno Mars",
      albumImagePath: "assets/cover/DieWithASmileCover.jpg",
      audioPath: "audio/DieWithASmile.mp3",
    ),
    Song(
      songName: "Espresso",
      artistName: "Sabrina Carpenter",
      albumImagePath: "assets/cover/EspressoCover.jpg",
      audioPath: "audio/Espresso.mp3",
    ),
    Song(
      songName: "One In A Million",
      artistName: "Ne Yo",
      albumImagePath: "assets/cover/OneInAMillionCover.jpg",
      audioPath: "audio/OneinaMillion.mp3",
    ),
    Song(
      songName: "Until I Found You",
      artistName: "Stephen Sanchez",
      albumImagePath: "assets/cover/UntilIFoundYouCover.jpg",
      audioPath: "audio/UntilIFoundYou.mp3",
    ),
  ];

  int? _currentSongIndex;
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;
  bool _isPlaying = false;

  PlaylistProvider() {
    listenToDuration();
  }

  // Play the song
  void play() async {
    if (_currentSongIndex == null) return;

    final String path = _playList[_currentSongIndex!].audioPath;

    await _audioPlayer.stop();

    try {
      await _audioPlayer.play(AssetSource(path)); // Correct way to play assets
      _isPlaying = true;
    } catch (e) {
      debugPrint("Error playing audio: $e");
    }

    notifyListeners();
  }


  // Pause the current song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // Resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // Toggle pause or play
  void pauseOrPlay() {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
  }

  // Seek to a specific position
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  // Play next song
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playList.length - 1) {
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        currentSongIndex = 0;
      }
    }
  }

  // Play previous song
  void playPreviousSong() {
    if (_currentSongIndex == null) return;

    if (_currentDuration.inSeconds > 2) {
      play();
    } else if (_currentSongIndex! > 0) {
      currentSongIndex = _currentSongIndex! - 1;
    } else {
      currentSongIndex = _playList.length - 1;
    }
  }

  // Listen to duration changes
  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  // Dispose audio player
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // Getters
  List<Song> get playList => _playList;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  // Setter
  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    if (newIndex != null) {
      play();
    }
    notifyListeners();
  }
}
