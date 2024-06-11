import 'package:flutter/material.dart';
import 'schedule.dart';
import "media.dart";
import 'slidingPanel.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.login, color: Color_2),
          onPressed: () {
            // Действие при нажатии на кнопку меню
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color_2),
            onPressed: () async {
              // Действие при нажатии на кнопку поиска
              FilePickerResult? result = await FilePicker.platform.pickFiles();

              if (result != null) {
                PlatformFile file = result.files.first;
                String? path = file.path;

                if (path != null) {
                  String contents = await File(path).readAsString();
                  List<Offset> newPoints = parseCoordinates(contents);

                  setState(() {
                    points = newPoints;
                  });
                }
              }
            },
          ),
        ],
        title: const Center(
          child: Text(
            "bazier",
            style: TextStyle(color: Color_2),
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
}

