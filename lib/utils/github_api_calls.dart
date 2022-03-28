import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> getStarCount(String username, String repo) async {
  final response = await http
      .get(Uri.parse("https://api.github.com/users/${username}/repos"));
  if (response.statusCode == 200) {
    final repos = jsonDecode(response.body);
    for (dynamic repoData in repos) {
      if (repoData['name'] == repo)
        return repoData['stargazers_count'].toString();
    }
  }
  return "🤔";
}
