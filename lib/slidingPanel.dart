import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'media.dart';

class BezierControlPanel extends StatefulWidget {
  final Function(List<Offset>) onCoordinatesChanged;

  const BezierControlPanel({super.key, required this.onCoordinatesChanged});

  @override
  _BezierControlPanelState createState() => _BezierControlPanelState();
}

class _BezierControlPanelState extends State<BezierControlPanel> {
  double t = 1.0;
  List<Offset> points = [Offset(50, 300),];

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(

      panel: Column(
        children: <Widget>[
          Container(
            width: 40,
            height: 3,
            margin: const EdgeInsets.only(
              top: 8,
              bottom: 20,
            ),
            decoration: const BoxDecoration(
              color: Color_1,
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
          ),
          Slider(
            value: t,
            min: 0,
            max: 1,
            onChanged: (value) {
              setState(() {
                t = value;
              });
            },
            activeColor: Color_1,
            inactiveColor: Colors.transparent,
          ),
          const SizedBox(
            height: 50,
            child: Text(
              'тут что то потом будет',
              style: TextStyle(color: Color_1),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...points
                      .asMap()
                      .entries
                      .map((entry) => buildContainer(entry.key + 1))
                      .toList(),
                  IconButton(
                    icon: const Icon(
                      Icons.add_circle_sharp,
                      size: 35,
                    ),
                    onPressed: addContainer,
                    color: Color_1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      minHeight: MediaQuery.of(context).size.height * 0.15,
      maxHeight: MediaQuery.of(context).size.height * 0.85,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
      color: Color_2.withOpacity(0.5),
      border:Border.all(width: 1.5,color: Color_2)

    );
  }

  @override
  void initState() {
    super.initState();
    points.add(Offset(0, 0));
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
        color: Color_1,
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
              controller: TextEditingController(text: points[1].dx.toString()),
              style: const TextStyle(color: Color_2),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "x",
                labelStyle: TextStyle(color: Color_2),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    borderSide: BorderSide(
                        color: Color_2,
                        style: BorderStyle.solid)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  borderSide: BorderSide(
                    color: Color_2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  borderSide: BorderSide(
                      color: Color_2,
                      style: BorderStyle.solid),
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
              controller: TextEditingController(text: points[1].dy.toString()),
              style: const TextStyle(color: Color_2),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "y",
                labelStyle: TextStyle(color: Color_2),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    borderSide: BorderSide(
                        color: Color_2,
                        style: BorderStyle.solid)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  borderSide: BorderSide(
                    color: Color_2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  borderSide: BorderSide(
                      color: Color_2,
                      style: BorderStyle.solid),
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
