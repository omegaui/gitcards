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
  final jsonData;

  const UIBuilderWidget(
      {Key? key, required this.constraints, required this.jsonData})
      : super(key: key);

  @override
  State<UIBuilderWidget> createState() => UIBuilderWidgetState();
}

class UIBuilderWidgetState extends State<UIBuilderWidget> {
  dynamic jsonData = null;

  @override
  Widget build(BuildContext context) {
    if (jsonData == null) jsonData = widget.jsonData;
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
          jsonData: jsonData,
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
