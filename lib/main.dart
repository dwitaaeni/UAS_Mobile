import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<dynamic> provinces = [];

  @override
  void initState() {
    super.initState();
    getDataFromApi();
  }

  Future<void> getDataFromApi() async {
    Uri apiUrl = Uri.parse('http://dev.farizdotid.com/api/daerahindonesia/provinsi');

    try {
      final response = await http.get(apiUrl);
      if (response.statusCode == 200) {
        setState(() {
          provinces = json.decode(response.body)['provinsi'];
        });
      } else {
        print('Failed to load data from API');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Daftar Provinsi di Indonesia'),
        ),
        body: ListView.builder(
          itemCount: provinces.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(provinces[index]['nama']),
            );
          },
        ),
      ),
    );
  }
}
