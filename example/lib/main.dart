import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _openResult = 'Unknown';

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<String> get _localFileName async {
    final String path = await _localPath;
    return '$path/counter.txt';
  }

  Future<File> get _localFile async {
    final fileName = await _localFileName;
    return File(fileName);
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$counter');
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<Null> init() async {
    final filePath = await _localFileName;

    await writeCounter(10);
    final result = await openFile(filePath);
    setState(() {
      _openResult = result;
    });
  }

  Future<String> openFile(filePath) async {
    return await OpenFile.open(filePath);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Center(
          child: new Text('open result: $_openResult\n'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.open_in_new),
          onPressed: () => init(),
        ),
      ),
    );
  }
}
