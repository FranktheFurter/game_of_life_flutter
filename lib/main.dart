// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //hide debug banner
      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',
      theme: ThemeData(
        //darkmode
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    var iconSize = 24;
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Game of Life'),
        // ),
        body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Container(
              height: 50,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Row(
                  children: [
                    Text(
                      "Iteration: ",
                      style: TextStyle(color: Colors.white.withOpacity(0.50)),
                    ),
                    Text('data')
                  ],
                ),
              ),
            ),
          ),
          Expanded(flex: 7, child: Container()),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OutlinedButton(onPressed: () {}, child: Icon(Icons.play_arrow)),
                          OutlinedButton(onPressed: () {}, child: Icon(Icons.pause)),
                          OutlinedButton(onPressed: () {}, child: Icon(Icons.restore)),
                        ],
                      ),
                      SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Slider(
                          value: 10,
                          label: _currentSliderValue.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              _currentSliderValue = _currentSliderValue;
                            });
                          },
                          min: 0,
                          max: 100,
                        ),
                      )
                    ],
                  ),
                ),
                Row(),
                Row(),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  blub() {}
}
