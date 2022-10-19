import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Colors.black,
        //visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String result = "0.0";
  String equation = "0.0";
  String operator = "";
  double num1 = 0.0;
  double num2 = 0.0;
  buttonPressed(btntxt) {
    setState(() {
      if (equation.length == 120) {
        Fluttertoast.showToast(
            msg: "Equation length can't exceed 140", timeInSecForIosWeb: 2);
        equation = "0.0";
        result = "0.0";
      }
      if (btntxt == "Clear") {
        equation = "";
        result = "0.0";
      } else if (btntxt == "=") {
        String expression = equation;
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "error";
        }
      } else if (btntxt == "DEL") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = '0.0';
        }
      } else {
        equation = equation + btntxt;
      }
    });
  }

  Widget buttonwidget(String btntxt) {
    // ignore: deprecated_member_use
    return RaisedButton(
      onPressed: () => buttonPressed(btntxt),
      padding: EdgeInsets.all(20.0),
      child: Text(
        btntxt,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
      ),
      color: Colors.green,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
                //padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 24.0),
                child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                equation,
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0),
              ),
            )),
            Container(
              height: 10.0,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 24.0),
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    result,
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0),
                  ),
                )),
            Divider(
              height: 210,
            ),
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buttonwidget('='),
                          buttonwidget('Clear'),
                          buttonwidget('DEL'),
                          buttonwidget('.'),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buttonwidget('1'),
                          buttonwidget('2'),
                          buttonwidget('3'),
                          buttonwidget('/'),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buttonwidget('4'),
                          buttonwidget('5'),
                          buttonwidget('6'),
                          buttonwidget('+'),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buttonwidget('7'),
                          buttonwidget('8'),
                          buttonwidget('9'),
                          buttonwidget('-'),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buttonwidget('0'),
                          buttonwidget('00'),
                          buttonwidget('%'),
                          buttonwidget('*'),
                        ]),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
