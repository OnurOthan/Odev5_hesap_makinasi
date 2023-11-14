import 'package:flutter/material.dart';
import 'calculator_buttons.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0';
  double _result = 0;
  String _currentInput = '';
  String _operation = '';
  bool _operationClicked = false;

  void _onDigitPress(String digit) {
    setState(() {
      if (_operationClicked) {
        _currentInput = digit;
        _operationClicked = false;
      } else {
        _currentInput += digit;
      }
      _display = _currentInput;
    });
  }

  void _onOperationPress(String newOperation) {
    setState(() {
      if (_operation.isNotEmpty) {
        _calculateResult();
        _operationClicked = true;
      } else {
        _result = double.parse(_currentInput);
        _operationClicked = true;
      }
      _operation = newOperation;
    });
  }

  void _calculateResult() {
    double currentInput = double.parse(_currentInput);
    switch (_operation) {
      case '+':
        _result = _result + currentInput;
        break;
      case '-':
        _result = _result - currentInput;
        break;
      case 'x':
        _result = _result * currentInput;
        break;
      case '/':
        try {
          _result = _result / currentInput;
        } catch (e) {
          _display = 'Error';
          return;
        }
        break;
    }
    _display = _result.toString();
  }

  void _onEqualPress() {
    setState(() {
      _calculateResult();
      _operation = '';
    });
  }

  void _onClearPress() {
    setState(() {
      _display = '0';
      _result = 0;
      _currentInput = '';
      _operation = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _display,
              style: TextStyle(fontSize: 40.0),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CalculatorButton(text: '7', onPressed: () => _onDigitPress('7')),
              CalculatorButton(text: '8', onPressed: () => _onDigitPress('8')),
              CalculatorButton(text: '9', onPressed: () => _onDigitPress('9')),
              CalculatorButton(text: '+', onPressed: () => _onOperationPress('+')),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CalculatorButton(text: '4', onPressed: () => _onDigitPress('4')),
              CalculatorButton(text: '5', onPressed: () => _onDigitPress('5')),
              CalculatorButton(text: '6', onPressed: () => _onDigitPress('6')),
              // Çıkarma tuşu tasarımsal olarak yer alacak, ancak işlevsel olmayacak
              CalculatorButton(text: '-', onPressed: () => {}),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CalculatorButton(text: '1', onPressed: () => _onDigitPress('1')),
              CalculatorButton(text: '2', onPressed: () => _onDigitPress('2')),
              CalculatorButton(text: '3', onPressed: () => _onDigitPress('3')),
              // Çarpma tuşu tasarımsal olarak yer alacak, ancak işlevsel olmayacak
              CalculatorButton(text: 'x', onPressed: () => {}),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CalculatorButton(text: '0', onPressed: () => _onDigitPress('0')),
              CalculatorButton(text: ',', onPressed: () => _onDigitPress('.')),
              CalculatorButton(text: '=', onPressed: () => _onEqualPress()),
              CalculatorButton(text: 'AC', onPressed: () => _onClearPress()),
            ],
          ),
        ],
      ),
    );
  }
}
