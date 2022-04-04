import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class test extends StatefulWidget {
  const test({Key? key}) : super(key: key);

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  Future getData() async {
    var url = "https://jsonplaceholder.typicode.com/posts";
    var response = await http.get(Uri.parse(url));
    var responsebody = convert.json.decode(response.body);
    return responsebody;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('test'),
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Text(snapshot.data[0]['title']),
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
