// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:math';

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
  bool _isRunning = false;
  int _iterationCounter = 0;

  //create a 2d array with random boolean values
  List<List<bool>> _grid = initializeGrid();

  @override
  Widget build(BuildContext context) {
    var iconSize = 24;
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Game of Life'),
        // ),
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.50),
                      ),
                    ),
                    Text(_iterationCounter.toString())
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: InteractiveViewer(
                constrained: false,
                minScale: 0.01,
                maxScale: 25.0,
                child: CustomPaint(
                  size: Size(2000, 2000),
                  painter: MyPainter(_grid),
                ),
              ),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  _grid = nextIteration(_grid);
                                  _iterationCounter++;
                                });
                                print("single step");
                              },
                              child: Icon(Icons.redo_rounded)),
                          OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  _isRunning = !_isRunning;
                                });
                                Timer mytimer = Timer.periodic(Duration(milliseconds: (1000 / (_currentSliderValue + 1)).toInt()), (timer) {
                                  if (!_isRunning) {
                                    timer.cancel();
                                  } else {
                                    print("tick");
                                    setState(() {
                                      _grid = nextIteration(_grid);
                                      _iterationCounter++;
                                    });
                                  }
                                });

                                print(_isRunning);
                              },
                              child: _isRunning ? Icon(Icons.pause) : Icon(Icons.play_arrow)),
                          OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  _grid = initializeGrid();
                                  _iterationCounter = 0;
                                });
                              },
                              child: Icon(Icons.restore)),
                        ],
                      ),
                      SizedBox(height: 32),
                      Text("Speed:"),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Slider(
                            value: _currentSliderValue,
                            max: 100,
                            divisions: 10,
                            label: _currentSliderValue.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _currentSliderValue = value;
                              });
                            },
                          ))
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
}

//Functions
List<List<bool>> initializeGrid() {
  List<List<bool>> _grid = List<List<bool>>.generate(
    250,
    (i) => List<bool>.generate(
      250,
      (j) => Random().nextBool(),
    ),
  );

  return _grid;
}

class MyPainter extends CustomPainter {
  final List<List<bool>> _grid;

  MyPainter(this._grid);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;
    for (var i = 0; i < _grid.length; i++) {
      for (var j = 0; j < _grid[i].length; j++) {
        if (_grid[i][j]) {
          canvas.drawRect(
            Rect.fromLTWH(
              i.toDouble() * 8,
              j.toDouble() * 8,
              8,
              8,
            ),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

List<List<bool>> nextIteration(List<List<bool>> grid) {
  var newGrid = List<List<bool>>.generate(
    grid.length,
    (i) => List<bool>.generate(
      grid[i].length,
      (j) => false,
    ),
  );

  for (var i = 0; i < grid.length; i++) {
    for (var j = 0; j < grid[i].length; j++) {
      var neighbors = 0;
      for (var x = i - 1; x <= i + 1; x++) {
        for (var y = j - 1; y <= j + 1; y++) {
          if (x == i && y == j) {
            continue;
          }
          if (x < 0 || x >= grid.length || y < 0 || y >= grid[i].length) {
            continue;
          }
          if (grid[x][y]) {
            neighbors++;
          }
        }
      }
      if (grid[i][j]) {
        if (neighbors < 2 || neighbors > 3) {
          newGrid[i][j] = false;
        } else {
          newGrid[i][j] = true;
        }
      } else {
        if (neighbors == 3) {
          newGrid[i][j] = true;
        }
      }
    }
  }
  return newGrid;
}
