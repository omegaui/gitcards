import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'github_api_calls.dart';

class ProjectList extends StatelessWidget {
  final BoxConstraints constraints;
  final jsonData;
  final links;

  const ProjectList(
      {Key? key, required this.constraints, required this.jsonData, this.links})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: constraints.maxWidth - 50,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 6,
            blurRadius: 6,
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: ((links as List<dynamic>).map((linkData) {
              return ProjectTile(
                  constraints: constraints,
                  jsonData: jsonData,
                  linkData: linkData);
            })).toList(),
          ),
        ),
      ),
    );
  }
}

class ProjectTile extends StatelessWidget {
  final jsonData;
  final linkData;
  final constraints;

  const ProjectTile(
      {Key? key,
      required this.jsonData,
      this.linkData,
      required this.constraints})
      : super(key: key);

  Future<String> computeStars() async {
    return linkData['stars'] != "auto"
        ? linkData['stars']
        : getStarCount(jsonData['username'], linkData['title']);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        launch(linkData['link']);
      },
      child: Container(
        width: constraints.maxWidth,
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.grey.withOpacity(0.1),
            Colors.grey.withOpacity(0.2)
          ]),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                ),
                Image.network(
                  linkData['icon'],
                  width: 25,
                  height: 25,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber[800],
                      size: 15,
                    ),
                    FutureBuilder(
                        future: computeStars(),
                        initialData: "...",
                        builder:
                            (BuildContext context, AsyncSnapshot<String> text) {
                          return Text(
                            text.data as String,
                            style: TextStyle(
                              fontFamily: "UbuntuMono",
                              color: Colors.black,
                            ),
                          );
                        }),
                  ],
                ),
              ],
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    linkData['title'],
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "UbuntuMono",
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    linkData['description'],
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: "UbuntuMono",
                      color: Colors.blueGrey[700],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Tooltip(
                  message: linkData['primary-programming-language'],
                  child: Image.network(
                    linkData['primary-programming-language-icon'],
                    width: 25,
                    height: 25,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
