import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quick_click/utils/connections.dart';
import 'package:quick_click/utils/projects.dart';
import 'package:quick_click/utils/some_lines.dart';
import 'package:quick_click/utils/tools.dart';

final descriptionGradient =
    LinearGradient(colors: [Colors.grey.shade700, Colors.black]);

final endPunchLineGradient =
    LinearGradient(colors: [Colors.blue.shade700, Colors.red]);

class UIBuilderWidget extends StatefulWidget {
  final BoxConstraints constraints;

  const UIBuilderWidget({Key? key, required this.constraints})
      : super(key: key);

  @override
  State<UIBuilderWidget> createState() => UIBuilderWidgetState();
}

class UIBuilderWidgetState extends State<UIBuilderWidget> {
  dynamic jsonData = jsonDecode("""
{
    "avatar": "https://raw.githubusercontent.com/omegaui/omegaide/main/res/omega_ide_icon128.png",
    "name-title": "Hi! I'm Arham",
    "username": "omegaui",
    "short-description": "A passionate programmer and student from India",
    "show-country-icon": "true",
    "country-icon": "https://img.icons8.com/external-vitaliy-gorbachev-flat-vitaly-gorbachev/58/000000/external-india-flags-vitaliy-gorbachev-flat-vitaly-gorbachev.png",

    "end-punch-line": "Collaboration Never Ends!",

    "show-lottie-animation": "true",
    "lottie-animation-url": "https://assets2.lottiefiles.com/packages/lf20_n9ryrmts.json",
    "repeat-lottie-animation": "true",
    
    "show-some-lines": "true",
    "some-lines": [
      "I'm in 💖 with programming",
      "And thats why I don't have any 👧 ...",
      "Well, putting it aside 🤧",
      "Together, We can make #gitcards better."
    ],

    "languages-and-tools-title": "My Team 💪",
    "languages-and-tools": [
      "https://img.icons8.com/fluency/48/000000/python.png",
      "https://img.icons8.com/color/48/000000/dart.png",
      "https://img.icons8.com/color/48/000000/java-coffee-cup-logo--v2.png",
      "https://img.icons8.com/color/48/000000/kotlin.png",
      "https://img.icons8.com/color/48/000000/javascript--v1.png",
      "https://img.icons8.com/fluency/48/000000/windows-10.png",
      "https://img.icons8.com/color/48/000000/linux--v1.png",
      "https://img.icons8.com/color/48/000000/visual-studio-code-2019.png",
      "https://img.icons8.com/color/48/000000/intellij-idea.png",
      "https://raw.githubusercontent.com/omegaui/omegaide/main/res/omega_ide_icon128.png"
    ],
    "connect-title": "Connect With Me",
    "connect-links": [
      {
        "icon": "https://img.icons8.com/fluency/48/000000/github.png",
        "link": "https://github.com/omegaui"
      },
      {
        "icon": "https://img.icons8.com/fluency/48/000000/instagram-new.png",
        "link": "https://instagram.com/the_open_source_guy"
      }
    ],
    "projects": {
      "title": "My Shameless Projects",
      "links": [ 
        {
          "title": "omegaide",
          "icon": "https://raw.githubusercontent.com/omegaui/omegaide/main/res/omega_ide_icon128.png",
          "link": "https://github.com/omegaui/omegaide",
          "stars": "33",
          "description": "The Blazing Fast Java IDE and an Instant IDE for any programming lanugage.",
          "primary-programming-language": "Java",
          "primary-programming-language-icon": "https://raw.githubusercontent.com/omegaui/omegaide/main/res/fluent-icons/icons8-java-48.png"
        },
        {
          "title": "gedit_flutter_hot_reload",
          "icon": "https://img.icons8.com/color/48/000000/flutter.png",
          "link": "https://github.com/omegaui/gedit_flutter_hot_reload",
          "stars": "3",
          "description": "Flutter Automatic Hot Reload Plugin for Gnome's Gedit.",
          "primary-programming-language": "Python",
          "primary-programming-language-icon": "https://img.icons8.com/fluency/48/000000/python.png"
        },
        {
          "title": "dynamic-database",
          "icon": "https://img.icons8.com/fluency/48/000000/database.png",
          "link": "https://github.com/omegaui/dynamic-database",
          "stars": "2",
          "description": "Fully Code Integrated Dynamic DBMS for the JVM.",
          "primary-programming-language": "Java",
          "primary-programming-language-icon": "https://raw.githubusercontent.com/omegaui/omegaide/main/res/fluent-icons/icons8-java-48.png"
        },
        {
          "title": "keystrokelistener",
          "icon": "https://img.icons8.com/color/48/000000/key.png",
          "link": "https://github.com/omegaui/keystrokelistener",
          "stars": "1",
          "description": "The Advanced Swing UI KeyListener.",
          "primary-programming-language": "Java",
          "primary-programming-language-icon": "https://raw.githubusercontent.com/omegaui/omegaide/main/res/fluent-icons/icons8-java-48.png"
        }
      ]
    }
}
""");

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        CircleAvatar(
          foregroundImage: Image.network(jsonData['avatar']).image,
          radius: 32,
          backgroundColor: Colors.grey.withOpacity(0.2),
        ),
        Text(
          jsonData['name-title'],
          style: TextStyle(
            color: Colors.grey[800],
            fontFamily: "UbuntuMono",
            fontSize: 28,
          ),
        ),
        SizedBox(height: 5),
        ShaderMask(
          blendMode: BlendMode.srcIn,
          child: Text(
            jsonData['short-description'],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "UbuntuMono",
              fontSize: 14,
            ),
          ),
          shaderCallback: (bounds) => descriptionGradient
              .createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
        ),
        SizedBox(height: 5),
        if (jsonData['show-country-icon'] == "true")
          Image.network(
            jsonData['country-icon'],
            width: 32,
            height: 32,
          ),
        SizedBox(height: 10),
        SomeLineList(constraints: widget.constraints, jsonData: jsonData),
        SizedBox(height: 10),
        ToolList(constraints: widget.constraints, jsonData: jsonData),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Row(
            children: [
              Text(
                jsonData['projects']['title'],
                style: TextStyle(
                  fontFamily: "Helvetica",
                  color: Colors.grey[700],
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        ProjectList(
          constraints: widget.constraints,
          links: jsonData['projects']['links'],
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Row(
            children: [
              Text(
                jsonData['connect-title'],
                style: TextStyle(
                  fontFamily: "Helvetica",
                  color: Colors.grey[700],
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        ConnectionList(
          constraints: widget.constraints,
          jsonData: jsonData,
        ),
        if (jsonData['show-lottie-animation'] == 'true')
          Lottie.network(
            jsonData['lottie-animation-url'],
            width: 135,
            height: 135,
            repeat: jsonData['repeat-lottie-animation'] == 'true',
          ),
        ShaderMask(
          blendMode: BlendMode.srcIn,
          child: Text(
            jsonData['end-punch-line'],
            style: TextStyle(
              fontFamily: "UbuntuMono",
              fontSize: 16,
            ),
          ),
          shaderCallback: (bounds) => endPunchLineGradient
              .createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
