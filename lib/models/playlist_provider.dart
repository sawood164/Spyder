import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:spyder/models/song.dart';

class PlaylistProvider extends ChangeNotifier{
  // playlist of songs
  final List<Song>_playlist = [

    //song 1
    Song(songName: "O Maahi",
      artistName: "Arjit Singh",
      albumArtImagePath: "assets/images/album_artwork_1.png.jpeg",
      audioPath: "audio/O_ maahi.mp3.mpeg",
    ),

// song2
    Song(songName: "Saware",
      artistName: "Arjit Singh",
      albumArtImagePath: "assets/images/album_artwork_2.png.jpeg",
      audioPath: "audio/Saware.mp3.mpeg",
    ),
    //song 3
    Song(songName: "Clam Down",
      artistName: "Selena Gomez",
      albumArtImagePath: "assets/images/album_artwork_3.png.jpeg",
      audioPath: "audio/Calm_down.mp3.mpeg",
    ),
    // song 4
    Song(songName: "Husn",
      artistName: "Anuv Jain",
      albumArtImagePath: "assets/images/album_artwork_4.png.jpeg",
      audioPath: "audio/Husn.mp3.mpeg",
    ),
    // song 5
    Song(songName: "Choo Lo",
      artistName: "The Local Train",
      albumArtImagePath: "assets/images/album_artwork_5.png.jpeg",
      audioPath: "audio/Choo_lo.mp3.mpeg",
    ),
    // song 6
    Song(songName: "Let Her Go",
      artistName: "Passenger",
      albumArtImagePath: "assets/images/album_artwork_6.png.jpeg",
      audioPath: "audio/Let_Her_Go.mp3.mpeg",
    ),
    // song 7
    Song(songName: "Tose Naina",
      artistName: "Arjit Singh",
      albumArtImagePath: "assets/images/album_artwork_7.png.jpeg",
      audioPath: "audio/Tose_Naina.mp3.mpeg",
    ),
    // song 8
    Song(songName: "Raabta",
      artistName: "Arjit Singh",
      albumArtImagePath: "assets/images/album_artwork_8.png.jpeg",
      audioPath: "audio/Raabta.mp3.mpeg",
    ),
    // song 9
    Song(songName: "Rang Lageya",
      artistName: "Mohit Chauhan",
      albumArtImagePath: "assets/images/album_artwork_9.png.jpeg",
      audioPath: "audio/Rang_lageya.mp3.mpeg",
    ),
    // song 10
    Song(songName: "Manjha",
      artistName: "Vishal Mishra",
      albumArtImagePath: "assets/images/album_artwork_10.png.jpeg",
      audioPath: "audio/Manjha.mp3.mpeg",
    ),
    // song 11
    Song(songName: "Kabira",
      artistName: "Arjit Singh",
      albumArtImagePath: "assets/images/album_artwork_11.png.jpeg",
      audioPath: "audio/Kabira.mp3.mpeg",
    ),
    // song 12
    Song(songName: "Tum Se Hi",
      artistName: "Gaurav Talreja",
      albumArtImagePath: "assets/images/album_artwork_12.png.jpeg",
      audioPath: "audio/Tum_se_hi.mp3.mpeg",
    ),
    // song 13
    Song(songName: "Dil Ye Bekarar Kyun Hai",
      artistName: "Shreya Ghoshal & Mohit Chauhan",
      albumArtImagePath: "assets/images/album_artwork_13.png.jpeg",
      audioPath: "audio/Dil_Ye_Bekarar.mp3.mpeg",
    ),
    // song 14
    Song(songName: "Phele Bhi Main",
      artistName: "Vishal Mishra",
      albumArtImagePath: "assets/images/album_artwork_14.png.jpeg",
      audioPath: "audio/Phele_bhi_main.mp3.mpeg",
    ),
    // song 15
    Song(songName: "Vaaste",
      artistName: "Dhvani Bhanushali & Nikhil",
      albumArtImagePath: "assets/images/album_artwork_15.png.jpeg",
      audioPath: "audio/Vaaste.mp3.mpeg",
    ),
  ];
  // current song playing mode
int? _currentSongIndex;
/*
A U D I O P L A Y E R

 */

  // audio player
final AudioPlayer _audioPlayer = AudioPlayer();

  // duration
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // constructor
PlaylistProvider() {
    listenToDuration();
}
  // initially not playing
bool _isPlaying = false;

  // play the song
void play () async {
  final String path = _playlist[_currentSongIndex!].audioPath;
  await _audioPlayer.stop(); // stop the current song
  await _audioPlayer.play(AssetSource(path)); // play the new song
  _isPlaying = true;
  notifyListeners();
}
  // pause current song
  void pause () async {
  await _audioPlayer.pause();
  _isPlaying = false;
  notifyListeners();
  }

  // resume playing
  void resume () async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }
  // pause or resume
  void pauseOrResume() async {
  if (_isPlaying) {
    pause();
  } else {
    resume();
  }
  notifyListeners();
  }

  //seek to a specific position in the current song
void seek (Duration position) async {
  await _audioPlayer.seek(position);
}
  // play next song
  void playNextSong() {
  if (_currentSongIndex != null) {
    if (_currentSongIndex ! <_playlist.length - 1) {
      // go to the next song if it's not the last song
      currentSongIndex = _currentSongIndex! + 1;
    } else {
      // if it's the last song, loop back to the first song
      currentSongIndex = 0;
    }
  }
  }

  // play previous song
  void playPreviousSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex ! <_playlist.length - 1) {
        seek(Duration.zero);
        // go to the next song if it's not the last song
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        // if it's the last song, loop back to the first song
        currentSongIndex = 0;
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
  // listen for song completion
  _audioPlayer.onPlayerComplete.listen((event) {
    playNextSong();
  });

}
  // dispose audio player

/*
G E T T E R S

 */
List<Song> get playlist => _playlist;
int? get currentSongIndex => _currentSongIndex;
bool get isPlaying => _isPlaying;
Duration get currentDuration => _currentDuration;
Duration get totalDuration => _totalDuration;

/*

S E T T E R S
 */
set currentSongIndex(int? newIndex) {
  // update current song
  _currentSongIndex = newIndex;

  if (newIndex != null) {
    play(); // play the song at the new index
  }
//update UI
  notifyListeners();
}
}