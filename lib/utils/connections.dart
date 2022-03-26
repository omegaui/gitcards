import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectionList extends StatelessWidget {
  final constraints;
  final jsonData;

  const ConnectionList(
      {Key? key, required this.constraints, required this.jsonData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: (jsonData['connect-links'] as List<dynamic>)
          .map((connectionData) =>
              ConnectionTile(connectionData: connectionData))
          .toList(),
    );
  }
}

class ConnectionTile extends StatelessWidget {
  final connectionData;

  const ConnectionTile({Key? key, required this.connectionData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: IconButton(
        onPressed: () {
          launch(connectionData['link']);
        },
        splashRadius: 20,
        iconSize: 25,
        icon: Image.network(
          connectionData['icon'],
        ),
      ),
    );
  }
}
