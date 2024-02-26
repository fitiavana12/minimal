import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/src/audioplayer.dart';
import 'package:minimal_music_player/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    Song(
      songName: "Tested, Approved",
      artistName: "Burna Boy",
      albumArtImagePath: "assets/images/I told them.jpg",
      audioPath: "assets/audio/05. Burna Boy - Tested, Approved & Trusted.mp3",
    ),
    Song(
      songName: "Meuda",
      artistName: "Tiakola",
      albumArtImagePath: "assets/images/melo.jpg",
      audioPath: "assets/audio/08. Tiakola - Meuda.mp3",
    ),
    Song(
      songName: "Coucher de soleil",
      artistName: "Tiakola",
      albumArtImagePath: "assets/images/melo.jpg",
      audioPath: "assets/audio/15. Tiakola - Coucher de soleil.mp3",
    ),
  ];

  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;
  bool _isPlaying = false;
  int? _currentSongIndex;

  PlaylistProvider() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    _audioPlayer.onAudioPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    _audioPlayer.onPlayerCompletion.listen((event) {
      playNextSong();
    });
  }

  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    if (newIndex != null) {
      play(newIndex);
    }
    notifyListeners();
  }

  Future<void> play(int songIndex) async {
    if (_isPlaying) {
      await _audioPlayer.stop();
    }
    final String path = _playlist[songIndex].audioPath;
    await _audioPlayer.play(path, isLocal: true);
    _isPlaying = true;
    notifyListeners();
  }

  void pause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
      _isPlaying = false;
      notifyListeners();
    }
  }

  void resume() async {
    if (!_isPlaying) {
      await _audioPlayer.resume();
      _isPlaying = true;
      notifyListeners();
    }
  }

  void pauseOrResume() {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  void playNextSong() {
    if (_currentSongIndex != null && _currentSongIndex! < _playlist.length - 1) {
      _currentSongIndex = _currentSongIndex! + 1;
    } else {
      _currentSongIndex = 0;
    }
    play(_currentSongIndex!);
  }

  void playPreviousSong() {
    if (_currentSongIndex != null) {
      if (_currentDuration.inSeconds > 2) {
        seek(Duration.zero);
      } else {
        if (_currentSongIndex! > 0) {
          _currentSongIndex = _currentSongIndex! - 1;
        } else {
          _currentSongIndex = _playlist.length - 1;
        }
      }
      play(_currentSongIndex!);
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
