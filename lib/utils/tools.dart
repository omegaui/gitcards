import 'package:flutter/material.dart';

class ToolList extends StatelessWidget {
  final constraints;
  final jsonData;

  const ToolList({Key? key, required this.jsonData, required this.constraints})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: constraints.maxWidth - 50,
      height: 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            jsonData['languages-and-tools-title'],
            style: TextStyle(
              color: Colors.grey.shade700,
              fontFamily: "Helvetica",
              fontSize: 18,
            ),
          ),
          SizedBox(height: 5),
          Wrap(
            alignment: WrapAlignment.center,
            children: (jsonData['languages-and-tools'] as List<dynamic>)
                .map((toolIcon) => ToolTile(toolIcon: toolIcon))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class ToolTile extends StatelessWidget {
  final String toolIcon;

  const ToolTile({Key? key, required this.toolIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      toolIcon,
      width: 32,
      height: 32,
    );
  }
}
