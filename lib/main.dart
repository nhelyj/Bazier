import 'package:flutter/material.dart';
import 'schedule.dart';
import "media.dart";
import 'slidingPanel.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Color_1

      ),
      debugShowCheckedModeBanner: false,
      home: App(),
    );
  }
}/// экран

class App extends StatefulWidget {

  @override
  _App createState() => _App();
}


class _App extends  State<App> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Center(
          child: Text("bazier",
            style: TextStyle(color: Color_2),),
        ),
      ),

      body: Stack(
          children: [
            CustomPaint(
              size: const Size(double.infinity, double.infinity),
              painter: schedule(), /// экран для  рисовния => schedule
            ),

            BezierControlPanel(),///всплывающий экран => SildingPanel
          ]
      ),

    );
  }
}/// структура экрана


