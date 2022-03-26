import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quick_click/ui_builder.dart';
import 'package:quick_click/utils/search.dart';
import 'package:slide_drawer/slide_drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

final appTitleGradient = LinearGradient(colors: [
  Colors.white,
  Colors.grey.shade200,
]);

dynamic initialJsonData = null;

final uiBuilderKey = GlobalKey<UIBuilderWidgetState>();

void main() async {
  final response = await http.get(Uri.parse(
      'https://raw.githubusercontent.com/omegaui/omegaui/main/git-card.json'));

  if (response.statusCode == 200) {
    initialJsonData = jsonDecode(response.body);
  }
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(
        backgroundColor: Colors.red.shade600,
      )),
      home: SlideDrawer(
        backgroundColor: Colors.white,
        contentDrawer: Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey.withOpacity(0.2),
                        child: Image.asset("assets/omegaui-128.png"),
                        radius: 64,
                      ),
                      Text(
                        'written with ❤️ by',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontFamily: "UbuntuMono",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'omegaui',
                        style: TextStyle(
                          color: Colors.pink[800],
                          fontSize: 24,
                          fontFamily: "UbuntuMono",
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'proudly hosted on',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontFamily: "UbuntuMono",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          launch("https://github.com/omegaui");
                        },
                        child: Text(
                          'GitHub',
                          style: TextStyle(
                            color: Colors.blue[800],
                            fontSize: 24,
                            fontFamily: "UbuntuMono",
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Text(
                        '#opensourcerules',
                        style: TextStyle(
                          color: Colors.purple[800],
                          fontSize: 26,
                          fontFamily: "UbuntuMono",
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        child: const ContentPanel(),
      ),
    );
  }
}

class ContentPanel extends StatefulWidget {
  const ContentPanel({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ContentPanelState();
}

class _ContentPanelState extends State<ContentPanel> {
  List<GitHubUser> users = [];

  void showSearchDialog(final constraints) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: constraints.maxWidth - 50,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 6,
                  blurRadius: 6,
                ),
              ],
            ),
            child: SearchPanel(
                constraints: constraints, uiBuilderKey: uiBuilderKey),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (initialJsonData == null) {
      return Container(
        child: Expanded(
          child: Text(
            "Internet is required to access remote git-card! Close the App, Connect to a network and Restart.",
            style: TextStyle(
              color: Colors.grey.shade700,
              fontFamily: "UbuntuMono",
            ),
          ),
        ),
      );
    }
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue.shade700, Colors.red.shade700]),
        ),
        child: Column(
          children: [
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Image.network(
                    "https://img.icons8.com/fluency/48/000000/github.png",
                    width: 32,
                    height: 32,
                  ),
                  SizedBox(width: 10),
                  ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) => appTitleGradient.createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                    child: Text(
                      '#gitcards',
                      style: TextStyle(
                        fontFamily: "Helvetica",
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: IconButton(
                            onPressed: () {
                              showSearchDialog(constraints);
                            },
                            tooltip: "Search Any GitHub User",
                            icon: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            iconSize: 20,
                            splashRadius: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: constraints.maxWidth - 30,
                height: constraints.maxHeight - 100,
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
                  child: LayoutBuilder(builder: (context, constraints) {
                    return UIBuilderWidget(
                      key: uiBuilderKey,
                      constraints: constraints,
                      jsonData: initialJsonData,
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class GitHubUser {
  final String name;
  const GitHubUser(this.name);
}
