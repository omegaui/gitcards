import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPanel extends StatefulWidget {
  final constraints;
  final uiBuilderKey;

  const SearchPanel(
      {Key? key, required this.constraints, required this.uiBuilderKey})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchPanelState();
}

class _SearchPanelState extends State<SearchPanel> {
  final String errorStatus_NOT_EXISTS =
      "This user haven't created a gitcard.json yet!";
  final String errorStatus_NOT_CORRECT =
      "The received gitcard.json is incorrect!";

  String status = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: SearchBar(),
          ),
          SearchBox(contentPanelState: this),
          Expanded(
            child: Container(
              color: Colors.grey.shade100,
              child: Row(
                children: [
                  SizedBox(width: 2),
                  Text(
                    status,
                    style: TextStyle(
                      fontFamily: "UbuntuMono",
                      fontSize: 12,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> search(String text) async {
    final response = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/${text}/${text}/main/git-card.json'));

    if (response.statusCode == 200) {
      try {
        final jsonData = response.body;
        widget.uiBuilderKey?.currentState.setState(() {
          widget.uiBuilderKey?.currentState.jsonData = jsonDecode(jsonData);
        });
        return true;
      } catch (e) {
        setState(() {
          status = errorStatus_NOT_CORRECT;
        });
      }
    } else {
      setState(() {
        status = errorStatus_NOT_EXISTS;
      });
    }
    return false;
  }
}

class SearchBar extends StatelessWidget {
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.chevron_left_rounded,
            color: Colors.purple.shade600,
          ),
          iconSize: 30,
          splashRadius: 20,
          splashColor: Colors.grey,
        ),
        Text(
          "Just Type in the Username",
          style: TextStyle(
            color: Colors.grey.shade800,
            fontFamily: "UbuntuMono",
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class SearchBox extends StatelessWidget {
  final _SearchPanelState contentPanelState;

  SearchBox({Key? key, required this.contentPanelState}) : super(key: key);

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: controller,
            style: TextStyle(
              fontFamily: "UbuntuMono",
              fontSize: 16,
              height: 1,
              color: Colors.grey.shade800,
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search_rounded,
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              label: Row(
                children: [
                  SizedBox(width: 5),
                  Text(
                    'Search Any GitHub User',
                    style: TextStyle(
                      fontFamily: "UbuntuMono",
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 5),
        TextButton(
          onPressed: () async {
            if (await contentPanelState.search(controller.text))
              Navigator.pop(context);
          },
          child: Text(
            'Search',
            style: TextStyle(
              fontFamily: "UbuntuMono",
              fontSize: 14,
              color: Colors.purple,
            ),
          ),
        ),
      ],
    );
  }
}
