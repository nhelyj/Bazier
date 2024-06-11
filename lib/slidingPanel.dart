import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'media.dart';

class BezierControlPanel extends StatefulWidget {
  final Function(List<Offset>) onCoordinatesChanged;

  const BezierControlPanel({super.key, required this.onCoordinatesChanged});

  @override
  _BezierControlPanelState createState() => _BezierControlPanelState();
}

class _BezierControlPanelState extends State<BezierControlPanel> {
  List<Offset> points = [Offset(0, 0)];
  List<int> tNumbers = [1]; // Список для хранения номеров контейнеров t

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      panel: Column(
        children: <Widget>[
          Container(
            width: 40,
            height: 3,
            margin: const EdgeInsets.only(
              top: 8,
              bottom: 10,
            ),
            decoration: const BoxDecoration(
              color: Color_1,
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 15,
              bottom: 5,
            ),
            child: const Text(
              'введите значения t которые будем искать ',
              style: TextStyle(color: Color_1),
            ),
          ),
          Container(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                ...tNumbers.map((number) => buildTContainer(number)).toList(),
                if (tNumbers.length < 10)
                  Container(
                    decoration: const BoxDecoration(
                      color: Color_1_1,
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.add_circle_sharp,
                        size: 35,
                      ),
                      onPressed: addTContainer,
                      color: Color_2_1,
                    ),
                  ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 15,
              bottom: 5,
            ),
            child: const Text(
              'введите координаты',
              style: TextStyle(color: Color_1),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...points.asMap().entries.map((entry) => buildContainer(entry.key + 1)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                      color: Color_1_1,
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.add_circle_sharp,
                        size: 35,
                      ),
                      onPressed: addContainer,
                      color: Color_2_1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      minHeight: MediaQuery.of(context).size.height * 0.2,
      maxHeight: MediaQuery.of(context).size.height * 0.85,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
      color: Color_2_1,
    );
  }

  Widget buildTContainer(int number) {
    return Container(
      width: 160,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Color_1_1,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            '$number',
            style: const TextStyle(color: Color_2, fontSize: 20),
          ),
          const Center(
            child: TextField(
              style: TextStyle(color: Color_2),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "t",
                labelStyle: TextStyle(color: Color_2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  borderSide: BorderSide(color: Color_2, style: BorderStyle.solid),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  borderSide: BorderSide(color: Color_2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  borderSide: BorderSide(color: Color_2, style: BorderStyle.solid),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    points.add(Offset(0, 0));
  }

  void addTContainer() {
    setState(() {
      if (tNumbers.length < 10) {
        tNumbers.add(tNumbers.length + 1);
      }
    });
  }

  void addContainer() {
    setState(() {
      points.add(Offset(0, 0));
    });
  }

  Widget buildContainer(int number) {
    return Container(
      width: 500,
      decoration: const BoxDecoration(
        color: Color_1_1,
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      margin: const EdgeInsets.symmetric(vertical: 5.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            '$number',
            style: const TextStyle(color: Color_2, fontSize: 20),
          ),
          SizedBox(
            width: 100,
            height: 50,
            child: TextField(
              style: const TextStyle(color: Color_2),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "x",
                labelStyle: TextStyle(color: Color_2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  borderSide: BorderSide(color: Color_2, style: BorderStyle.solid),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  borderSide: BorderSide(color: Color_2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  borderSide: BorderSide(color: Color_2, style: BorderStyle.solid),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  points[number - 1] = Offset(
                    double.tryParse(value) ?? 0,
                    points[number - 1].dy,
                  );
                  widget.onCoordinatesChanged(points);
                });
              },
            ),
          ),
          SizedBox(
            width: 100,
            height: 50,
            child: TextField(
              style: const TextStyle(color: Color_2),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "y",
                labelStyle: TextStyle(color: Color_2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  borderSide: BorderSide(color: Color_2, style: BorderStyle.solid),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  borderSide: BorderSide(color: Color_2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  borderSide: BorderSide(color: Color_2, style: BorderStyle.solid),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  points[number - 1] = Offset(
                    points[number - 1].dx,
                    double.tryParse(value) ?? 0,
                  );
                  widget.onCoordinatesChanged(points);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
