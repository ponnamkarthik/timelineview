import 'package:flutter/material.dart';
import 'package:timelineview/timelineview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TimelineView(
              activeIndex: activeIndex,
              showLabels: true,
              circleRadius: 7.0,
              lineHeight: 2.0,
              selectedWidget: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
              ), // selected widget
              unSelectedWidget: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.red, width: 1),
                ),
              ), // unselected widget
              onChanged: (index) {
                setState(() {
                  activeIndex = index;
                });
              },
              labelWidgets: <Widget>[
                Text("One"),
                Text("TwoThree"),
                Text("Four"),
              ],
              iconWidgets: <Widget>[
                Icon(Icons.home),
                Icon(Icons.ac_unit),
                Icon(Icons.access_alarm),
              ],
              hasFinished: true,
              unFinishedLineColor: Colors.red[100],
              finishedLineColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
