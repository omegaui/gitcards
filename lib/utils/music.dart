import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MusicPlaylist extends StatelessWidget {
  final jsonData;

  const MusicPlaylist({Key? key, required this.jsonData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        child: IconButton(
          onPressed: () {
            launch(jsonData['music-playlist-data']['playlist-link']);
          },
          icon: Image.network(
            jsonData['music-playlist-data']['app-icon'],
            width: 64,
            height: 64,
          ),
          splashRadius: 64,
        ),
      ),
    );
  }
}
