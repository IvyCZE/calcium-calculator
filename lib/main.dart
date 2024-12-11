import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:calc/calc.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(scaffoldBackgroundColor: const Color.fromARGB(10, 255, 228, 200)),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';
  String _visibleinput = '';
  String _result = '';
  String _result2 = '';
  String _result3 = '';
  String _result4 = '';
  String _memorycheck = '';


  void _buttonPressed(String value) {
    setState(() {
      if (value == '=') {
        try {
          Parser parser = Parser();
          Expression expression = parser.parse(_input);
          ContextModel contextModel = ContextModel();
          _memorycheck = expression.evaluate(EvaluationType.REAL, contextModel).toString();
          if (_memorycheck != '') {
            if (_memorycheck != 'Error') {
              if (_memorycheck != 'Infinity') {
                if (_memorycheck != '-Infinity') {
                  _result4 = _result3.toString();
                  _result3 = _result2.toString();
                  _result2 = _result.toString();
                }
              }
            }
          }
          _result = expression.evaluate(EvaluationType.REAL, contextModel).toString();
          if (_result.endsWith('.0')) {
            _result = _result.substring(0, _result.length - 2);
          };
          if (_result == 'Infinity') {
            _result = 'Not defined';
          }
        } catch (e) {
          _result = 'Error';
        }
      } else if (value == 'C') {
        _input = '';
        _visibleinput = '';
        _result = '';
      } else if (value == '<') {
        if (_input.isNotEmpty) {
          setState(() {
            if (_input.endsWith('sqrt(')) {
              _input = _input.substring(0, _input.length - 5);
            } else if (_input.endsWith('3.141593')) {
              _input = _input.substring(0, _input.length - 8);
            } else if (_input.endsWith('^(1/')) {
              _input = _input.substring(0, _input.length - 4);
            } else {
              _input = _input.substring(0, _input.length - 1);
              _visibleinput = _visibleinput.substring(0, _visibleinput.length - 1);
            }
          });
        }
      } else if (value == '√') {
          _input += 'sqrt(';
          _visibleinput += value;
      } else if (value == 'π') {
        _input += '3.141593';
        _visibleinput += value;
      } else if (value == 'n√') {
        _input += '^(1/';
        _visibleinput += value;
      } else {
        _input += value;
        _visibleinput += value;
      }
    });
  }

  Widget _buildButton(String text, Color color) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _buttonPressed(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.all(20),
          shape: CircleBorder()
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: const Color(0xFFFFFFFF)),
        ),
      ),
    );
  }

  Widget _buildButton2(String text, Color color) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _buttonPressed(text),
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            )
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildButton3(String text, Color color) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _buttonPressed(text),
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            )
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 50.0), // Add 10 pixels of padding at the bottom
          ),
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ca Calculator',
                  style: TextStyle(fontSize: 20, color: const Color.fromARGB(160, 255, 200, 170)),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _result4,
                    style: TextStyle(fontSize: 20, color: const Color.fromARGB(160, 255, 200, 170)),
                  ),
                  Text(
                    _result3,
                    style: TextStyle(fontSize: 20, color: const Color.fromARGB(170, 255, 200, 170)),
                  ),
                  Text(
                    _result2,
                    style: TextStyle(fontSize: 20, color: const Color.fromARGB(200, 255, 200, 170)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0), // Add 10 pixels of padding at the bottom
                  ),
                  Text(
                    _result,
                    style: TextStyle(fontSize: 35, color: const Color.fromARGB(255, 255, 150, 138)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _input,
                    style: TextStyle(fontSize: 27, color: const Color.fromARGB(255, 255, 205, 200)),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color.fromARGB(20, 255, 228, 200),
                border: Border(
                  left: BorderSide(
                    color: Colors.black,
                    width: 10,
                  ),
                  right: BorderSide(
                    color: Colors.black,
                    width: 10,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 50.0), // Add 10 pixels of padding at the bottom
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(11.0), // Adjust padding here
              ),
              _buildButton3('n√', Color.fromARGB(255, 230, 160, 149)),
              Padding(
                padding: EdgeInsets.all(8.0), // Adjust padding here
              ),
              _buildButton3('*10^', Color.fromARGB(255, 230, 160, 149)),
              Padding(
                padding: EdgeInsets.all(8.0), // Adjust padding here
              ),
              _buildButton3('!', Color.fromARGB(255, 230, 160, 149)),
              Padding(
                padding: EdgeInsets.all(8.0), // Adjust padding here
              ),
              _buildButton3('π', Color.fromARGB(255, 230, 160, 149)),
              Padding(
                padding: EdgeInsets.all(11.0), // Adjust padding here
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8.0), // Adjust padding here
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(11.0), // Adjust padding here
              ),
              _buildButton3('√', Color.fromARGB(255, 230, 160, 149)),
              Padding(
                padding: EdgeInsets.all(8.0), // Adjust padding here
              ),
              _buildButton3('^', Color.fromARGB(255, 230, 160, 149)),
              Padding(
                padding: EdgeInsets.all(8.0), // Adjust padding here
              ),
              _buildButton3('(', Color.fromARGB(255, 230, 160, 149)),
              Padding(
                padding: EdgeInsets.all(8.0), // Adjust padding here
              ),
              _buildButton3(')', Color.fromARGB(255, 230, 160, 149)),
              Padding(
                padding: EdgeInsets.all(11.0), // Adjust padding here
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8.0), // Adjust padding here
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0), // Adjust padding here
              ),
              _buildButton('7', Color.fromARGB(255, 214, 101, 81)),
              _buildButton('8', Color.fromARGB(255, 214, 101, 81)),
              _buildButton('9', Color.fromARGB(255, 214, 101, 81)),
              Padding(
                padding: EdgeInsets.all(8.0), // Adjust padding here
              ),
              _buildButton('/', Color.fromARGB(255, 186, 121, 110)),
              _buildButton('*', Color.fromARGB(255, 186, 121, 110)),
              Padding(
                padding: EdgeInsets.all(8.0), // Adjust padding here
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8.0), // Adjust padding here
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0), // Adjust padding here
              ),
              _buildButton('4', Color.fromARGB(255, 214, 101, 81)),
              _buildButton('5', Color.fromARGB(255, 214, 101, 81)),
              _buildButton('6', Color.fromARGB(255, 214, 101, 81)),
              Padding(
                padding: EdgeInsets.all(8.0), // Adjust padding here
              ),
              _buildButton('-', Color.fromARGB(255, 186, 121, 110)),
              _buildButton('+', Color.fromARGB(255, 186, 121, 110)),
              Padding(
                padding: EdgeInsets.all(8.0), // Adjust padding here
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8.0), // Adjust padding here
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0), // Adjust padding here
              ),
              _buildButton('1', Color.fromARGB(255, 214, 101, 81)),
              _buildButton('2', Color.fromARGB(255, 214, 101, 81)),
              _buildButton('3', Color.fromARGB(255, 214, 101, 81)),
              Padding(
                padding: EdgeInsets.all(8.0), // Adjust padding here
              ),
              _buildButton('<', Color.fromARGB(255, 186, 121, 110)),
              _buildButton('C', Color.fromARGB(255, 186, 121, 110)),
              Padding(
                padding: EdgeInsets.all(8.0), // Adjust padding here
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8.0), // Adjust padding here
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0), // Adjust padding here
              ),
              _buildButton2('0', Color.fromARGB(255, 214, 101, 81)),
              _buildButton('.', Color.fromARGB(255, 214, 101, 81)),
              Padding(
                padding: EdgeInsets.all(3.0), // Adjust padding here
              ),
              _buildButton2('=', Color.fromARGB(230, 219, 160, 149)),
              Padding(
                padding: EdgeInsets.all(15.5), // Adjust padding here
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8.0), // Adjust padding here
          ),
        ],
      ),
    );
  }
}
