import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player/models/song.dart';

class PlayListProvider extends ChangeNotifier {
  // playlist of songs

  final List<Song> _playList = [
    // song 1
    Song(
      songName: 'Mirrorball',
      artistName: 'Burgundy',
      albumArtImagePath: 'assets/images/1.jpg',
      audioPath: 'assets/audio/1_Burgundy_Mirrorball.mp3',
    ),

    //song 2
    Song(
      songName: 'Your Fingers',
      artistName: 'Aylex Snap',
      albumArtImagePath: 'assets/images/2.jpg',
      audioPath: 'assets/audio/2_Aylex_Snap_Your Fingers.mp3',
    ),

    //song 3
    Song(
      songName: 'Retrowave',
      artistName: 'walen',
      albumArtImagePath: 'assets/images/3.jpg',
      audioPath: 'assets/audio/3_walen_Retrowave.mp3',
    ),
  ];

  // current song palying index
  int? _currentSongIndex;

  /*

  A U D I O P L A Y E R

  */

  // audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  // durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // constructor
  PlayListProvider() {
    listenToDuration();
  }

  // initialliy not playing
  bool _isPlaying = false;

  // play the song
  void play() async {
    final String path = _playList[_currentSongIndex!].audioPath;
    await _audioPlayer.stop(); // stop current song
    await _audioPlayer.play(AssetSource(path)); // play the new song
    _isPlaying = true;
    notifyListeners();
  }

  // pause current song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // pause or resume
  void pauseOrResume() async {
    if (_isPlaying) {
      // pause current song
      pause();
    } else {
      // resume playing
      resume();
    }
    notifyListeners();
  }

  // seek to a specific position in the current song
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  // play next song
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playList.length - 1) {
        // go to the next song if it's not the last song
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        // if it's the last song, loop back to the first song
        currentSongIndex = 0;
      }
    }
  }

  // play previous song
  void playPreviousSong() async {
    // if more than 2 seconds have passed, restart the current song
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    }
    // if it's within first 2 second of the song, go to the previous song
    else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        // if it's the first song, loop back to last song
        currentSongIndex = _playList.length - 1;
      }
    }
  }

  // list to duration
  void listenToDuration() {
    // listen for total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    // listen for current duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    // lsiten for song completion
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  // dispose audio player

  /*
  G E T T E R S
  */

  List<Song> get playList => _playList;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  /*
  S E T T E R S
  */
  set currentSongIndex(int? newIndex) {
    // update current song index
    _currentSongIndex = newIndex;

    if (newIndex != null) {
      play(); // play the song at the new index
    }

    // update UI
    notifyListeners();
  }
}
