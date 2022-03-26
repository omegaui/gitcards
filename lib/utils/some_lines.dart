import 'package:flutter/material.dart';

final pointGradient =
    LinearGradient(colors: [Colors.deepOrange, Colors.purple]);

class SomeLineList extends StatelessWidget {
  final BoxConstraints constraints;
  final jsonData;

  const SomeLineList(
      {Key? key, required this.constraints, required this.jsonData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: constraints.maxWidth - 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.grey.withOpacity(0.1),
          Colors.grey.withOpacity(0.2)
        ]),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: (jsonData['some-lines'] as List<dynamic>)
              .map((someLineData) => SomeLineTile(someLineData: someLineData))
              .toList(),
        ),
      ),
    );
  }
}

class SomeLineTile extends StatelessWidget {
  final someLineData;

  const SomeLineTile({Key? key, required this.someLineData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShaderMask(
          blendMode: BlendMode.srcIn,
          child: Icon(
            Icons.lens_rounded,
            size: 10,
          ),
          shaderCallback: (bounds) => pointGradient
              .createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
        ),
        SizedBox(width: 5),
        Expanded(
          child: Text(
            someLineData,
            style: TextStyle(
              fontFamily: "UbuntuMono",
              fontSize: 12,
              color: Colors.grey.shade800,
            ),
          ),
        ),
      ],
    );
  }
}
