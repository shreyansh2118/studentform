import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _courseController = TextEditingController();
  TextEditingController _branchController = TextEditingController();
  TextEditingController _rollNoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> registerCandidate() async {
    final name = _nameController.text;
    final course = _courseController.text;
    final branch = _branchController.text;
    final rollNo = _rollNoController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    final jsonStrObj = {
      'CandidateName': name,
      'Course': course,
      'Branch': branch,
      'RollNo': rollNo,
      'Email': email,
      'Password': password,
    };

    final jsonStr = json.encode(jsonStrObj);

    if (jsonStr.isEmpty) {
      return;
    }

    final putReqStr = createPUTRequest(
      '90931532|-31949330751556883|90959874',
      jsonStr,
      'Student',
      'Std-Details',
    );
    final resultObj = await executeCommand(
      putReqStr,
      'http://api.login2explore.com:5577',
      '/api/iml',
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Registration Result'),
          content: Text('INSERTED: ${json.encode(resultObj)}'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  String createPUTRequest(String connToken, String jsonObj, String dbName, String relName) {
    final putRequest = '''
{
  "token": "$connToken",
  "dbName": "$dbName",
  "cmd": "PUT",
  "rel": "$relName",
  "jsonStr": $jsonObj
}
    ''';
    return putRequest;
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Form'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextFormField(
              controller: _courseController,
              decoration: InputDecoration(labelText: 'Course'),
            ),
            TextFormField(
              controller: _branchController,
              decoration: InputDecoration(labelText: 'Branch'),
            ),
            TextFormField(
              controller: _rollNoController,
              decoration: InputDecoration(labelText: 'Roll No'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email Address'),
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: registerCandidate,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
