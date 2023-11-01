import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ShowDataScreen extends StatefulWidget {
  @override
  _ShowDataScreenState createState() => _ShowDataScreenState();
}

class _ShowDataScreenState extends State<ShowDataScreen> {
  TextEditingController _rollNoController = TextEditingController();
  String resultText = '';

  Future<Map<String, dynamic>> executeCommand(String reqString, String dbBaseUrl, String apiEndPointUrl) async {
    final url = '$dbBaseUrl$apiEndPointUrl';
    Map<String, dynamic> jsonObj;

    final response = await http.post(
      Uri.parse(url),
      body: reqString,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      jsonObj = json.decode(response.body);
    } else {
      final dataJsonObj = response.body;
      jsonObj = json.decode(dataJsonObj);
    }
    return jsonObj;
  }

  String createGETRequest(String token, String dbName, String relationName, String jsonStr) {
    final reqString = '''
{
  "token": "$token",
  "dbName": "$dbName",
  "rel": "$relationName",
  "cmd": "GET",
  "jsonStr": $jsonStr
}
    ''';
    return reqString;
  }

  Future<void> showData() async {
    final token = "90931532|-31949330751556883|90959874";
    final dbname = "Student";
    final relationName = "Std-Details";
    final roll = _rollNoController.text;

    final jsonStr = {
      "RollNo": roll,
    };

    final reqString = createGETRequest(token, dbname, relationName, json.encode(jsonStr));

    final resultObj = await executeCommand(
      reqString,
      "http://api.login2explore.com:5577",
      "/api/irl",
    );

    final data = json.encode(resultObj);
    final res = data.split("\"");

    final showText = "Name : ${res[18].replaceAll("\\", "")}      Email : ${res[10].replaceAll("\\", "")}" +
        "     Course : ${res[22].replaceAll("\\", "")}        Branch : ${res[14].replaceAll("\\", "")}";

    setState(() {
      resultText = showText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Data Form'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Center(
              child: Text('Show Data', style: TextStyle(fontSize: 24)),
            ),
            TextField(
              controller: _rollNoController,
              decoration: InputDecoration(
                labelText: 'Roll No',
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: showData,
                child: Text('SHOW DATA'),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(resultText),
            ),
          ],
        ),
      ),
    );
  }
}
