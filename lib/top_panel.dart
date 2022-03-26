import 'package:flutter/material.dart';

class TopPanel extends StatelessWidget {
  final VoidCallback onLoading;
  const TopPanel({Key? key, required this.onLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            onLoading.call();
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(Colors.grey.shade200),
          ),
          child: Text(
            "JSON",
            style: TextStyle(
              color: Colors.grey[800],
              fontFamily: "Helvetica",
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
