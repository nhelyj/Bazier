import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'media.dart';



class BezierControlPanel extends StatefulWidget {
  @override
  _BezierControlPanelState createState() => _BezierControlPanelState();
}

class _BezierControlPanelState extends State<BezierControlPanel> {
  double t = 1.0;
  List<Widget> containers = [];

  @override
  void initState() {
    super.initState();
    containers.add(buildContainer(1));
  }

  void addContainer() {
    setState(() {
      containers.add(buildContainer(containers.length + 1));
    });
  }

  Widget buildContainer(int number) {
    return Container(

       width: 500,
      height: 45,
      decoration: const BoxDecoration(
        color: Color_1,
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
     // padding: const EdgeInsets.symmetric(vertical: 2.5),
      margin: const EdgeInsets.symmetric(vertical: 5.5),

      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[

                  Text(
                    '$number',
                    style: const TextStyle(color: Color_2, fontSize: 20),
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 2.5),
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    width: 100,
                    decoration: const BoxDecoration(
                      color: Color_2,
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                    child: const TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'x',
                        border: InputBorder.none,
                      ),
                    ),

                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 2.5),
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    width: 100,
                    decoration: const BoxDecoration(
                      color: Color_2,
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                    child: const TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'y',
                        border: InputBorder.none,
                      ),
                    ),

                  ),

                ],
              ),




    );
  }


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
  }
}
