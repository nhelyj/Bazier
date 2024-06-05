import 'package:flutter/material.dart' ;
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'media.dart';

class BezierControlPanel extends StatefulWidget {
  const BezierControlPanel({super.key});

  @override
  _BezierControlPanelState createState() => _BezierControlPanelState();
}

class _BezierControlPanelState extends State<BezierControlPanel> {
  double t = 1.0;
  List<Widget> containers = [];

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
            max: 10,
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
            child: Text('тут  что то  потом  будет ',
            style:TextStyle(color: Color_1),),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...containers,
                  IconButton(
                    icon: const Icon(
                      Icons.add_circle_sharp,
                      size: 35,),
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
      color: Color_2,
    );
  }/// тело всплывающего виджита

  @override
  void initState() {
    super.initState();
    containers.add(buildContainer(1));
  }///  создаёт  1 виджет с полем для ввода

  void addContainer() {
    setState(() {
      containers.add(buildContainer(containers.length + 1));
    });
  }/// при нажатии создат ещё  виджет с полем для ввода

  Widget buildContainer(int number) {
    return Container(

      width: 500,
      //height: 45,
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

          const SizedBox(
            width: 100,
            height: 50,
            child: TextField(
              style: TextStyle(
                color: Color_2,
              ),
              keyboardType:  TextInputType.number,
              decoration: InputDecoration(
                labelText: "x",
                labelStyle: TextStyle(
                  color: Color_2,),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    borderSide: BorderSide(
                        color: Color_2,
                        style: BorderStyle.solid
                    )
                ),
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
                      style: BorderStyle.solid
                  ),
                ),
              ),

            ),

          ),

          const SizedBox(
            width: 100,
            height: 50,
            child: TextField(

              style: TextStyle(
                color: Color_2,
              ),
              keyboardType:  TextInputType.number,
              decoration: InputDecoration(
                labelText: "y",
                labelStyle: TextStyle(
                  color: Color_2,),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    borderSide: BorderSide(
                        color: Color_2,
                        style: BorderStyle.solid
                    )
                ),
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
                      style: BorderStyle.solid
                  ),
                ),
              ),

            ),

          ),
        ],
      ),




    );
  }/// сам  виджет


}
