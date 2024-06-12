import 'package:flutter/material.dart';
import 'schedule.dart';
import "media.dart";
import 'slidingPanel.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color_1,
      ),
      debugShowCheckedModeBanner: false,
      home: App(),
    );
  }
}

class App extends StatefulWidget {
  @override
  _App createState() => _App();
}

class _App extends State<App> {
  List<Offset> points = [];
  TextEditingController filenameController = TextEditingController();
  final GlobalKey<BezierControlPanelState> _bezierKey = GlobalKey<BezierControlPanelState>();
  String? saveDirectory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.folder_open, color: Color_2),
          onPressed: () async {
            String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
            if (selectedDirectory != null) {
              setState(() {
                saveDirectory = selectedDirectory;
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Selected Directory: $selectedDirectory')));
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save, color: Color_2),
            onPressed: () {
              saveToFile();
            },
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Color_2),
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();

              if (result != null) {
                PlatformFile file = result.files.first;
                String? filePath = file.path;

                if (filePath != null) {
                  String contents = await File(filePath).readAsString();
                  List<Offset> newPoints = parseCoordinates(contents);

                  setState(() {
                    points = newPoints;
                  });
                }
              }
            },
          ),
        ],
        title: Center(
          child: SizedBox(
            width: 250,
            child: TextField(
              controller: filenameController,
              style: const TextStyle(color: Color_2),
              decoration: const InputDecoration(
                labelText: 'название',
                labelStyle: TextStyle(color: Color_2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  borderSide: BorderSide(color: Color_2, style: BorderStyle.none),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  borderSide: BorderSide(color: Color_2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  borderSide: BorderSide(color: Color_2, style: BorderStyle.none),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          CustomPaint(
            size: const Size(double.infinity, double.infinity),
            painter: schedule(points: points, t: 1.0),
          ),
          BezierControlPanel(
            key: _bezierKey,
            onCoordinatesChanged: (newPoints) {
              setState(() {
                points = newPoints;
              });
            },
          ),
        ],
      ),
    );
  }

  List<Offset> parseCoordinates(String contents) {
    List<Offset> newPoints = [];
    List<String> lines = contents.split('\n');
    for (String line in lines) {
      line = line.trim();
      if (line.isNotEmpty) {
        List<String> parts = line.split(RegExp(r'[ ,]+'));
        if (parts.length == 2) {
          double? x = double.tryParse(parts[0]);
          double? y = double.tryParse(parts[1]);
          if (x != null && y != null) {
            newPoints.add(Offset(x, y));
          }
        }
      }
    }
    return newPoints;
  }

  void saveToFile() async {
    if (saveDirectory == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select a directory first')));
      return;
    }

    String filename = filenameController.text;
    if (filename.isEmpty) {
      filename = "базье";
    }
    filename = "$filename.txt";

    List<int> tValues = _bezierKey.currentState?.tValues.map((t) => t ).toList() ?? [];

    List<Offset> interpolatedPoints = bezierInterpolation(tValues);

    String content = interpolatedPoints.map((point) => "${point.dx}, ${point.dy}").join("\n");
    final file = File(path.join(saveDirectory!, filename));
    await file.writeAsString(content);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Saved to $filename')));
  }

  List<Offset> bezierInterpolation(List<int> tValues) {
    return tValues.map((t) => Offset(t.toDouble(), t.toDouble())).toList();
  }
}

