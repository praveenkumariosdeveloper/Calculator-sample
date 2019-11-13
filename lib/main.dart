import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
String strInput = "";
final textControllerInput = TextEditingController();
final textControllerResult = TextEditingController();

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    textControllerInput.addListener(() {});
    textControllerResult.addListener(() {});
  }
  @override
  void dispose() {
    textControllerInput.dispose();
    textControllerResult.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.indigo[300]),
      backgroundColor: Colors.blueGrey[900],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: new TextField(
                decoration: new InputDecoration.collapsed(
                    hintText: "0",
                    hintStyle: TextStyle(
                      fontSize: 30,
                      fontFamily: 'RobotoMono',
                      color: Colors.white,
                    )),
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'RobotoMono',
                  color: Colors.white,

                ),
                textAlign: TextAlign.right,
                controller: textControllerInput,
                onTap: () =>
                    FocusScope.of(context).requestFocus(new FocusNode()),
              )),
          new Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                decoration: new InputDecoration.collapsed(
                    hintText: "Result",
                    hintStyle: TextStyle(fontFamily: 'RobotoMono',color: Colors.white,)),
                textInputAction: TextInputAction.none,
                keyboardType: TextInputType.number,
                style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'RobotoMono',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    ),
                textAlign: TextAlign.right,
                controller: textControllerResult,
                onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());

                },)),
          SizedBox( height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              btnAC('AC',const Color(0xFFF5F7F9),),
              btnClear(),
              btn('%',Colors.brown[400],),
              btn('/',Colors.deepPurpleAccent),],),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              btn('7', Colors.brown[200]),
              btn('8', Colors.brown[200]),
              btn('9', Colors.brown[200]),
              btn('*',Colors.deepPurpleAccent),],),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              btn('4', Colors.brown[200]),
              btn('5', Colors.brown[200]),
              btn('6', Colors.brown[200]),
              btn('-',Colors.deepPurpleAccent),],),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              btn('1', Colors.brown[200]),
              btn('2', Colors.brown[200]),
              btn('3', Colors.brown[200]),
              btn('+', Colors.deepPurpleAccent),],),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              btn('0', Colors.brown[200]),
              btn('.', Colors.brown[400]),
              btnEqual('=', Colors.deepPurpleAccent),],),
          SizedBox(height: 10.0,)],),
    );
  }
  Widget btn(btntext, Color btnColor) {
    return Container(
      padding: EdgeInsets.only(bottom: 5.0),
      child: FlatButton(
        child: Text(
          btntext,
          style: TextStyle(
              fontSize: 28.0, color: Colors.white, fontFamily: 'RobotoMono'),
        ),
        onPressed: () {
          setState(() {
            textControllerInput.text = textControllerInput.text + btntext;
          });
        },
        color: btnColor,
        padding: EdgeInsets.all(18.0),
        splashColor: Colors.white,
        shape: RoundedRectangleBorder(),
      ),
    );
  }

  Widget btnClear() {
    return Container(
      padding: EdgeInsets.only(bottom: 5.0),
      child: FlatButton(
        child: Icon(Icons.backspace, size: 31, color: Colors.white),
        onPressed: () {
          textControllerInput.text = (textControllerInput.text.length > 0)
              ? (textControllerInput.text
                  .substring(0, textControllerInput.text.length - 1))
              : "";
        },
        color: Colors.brown[400],
        padding: EdgeInsets.all(18.0),
        splashColor: Colors.white,
        shape: RoundedRectangleBorder(),
      ),
    );
  }
  Widget btnAC(btntext, Color btnColor) {
    return Container(
      padding: EdgeInsets.only(bottom: 5.0,),
      child: FlatButton(
        child: Text(
          btntext,
          style: TextStyle(
              fontSize: 28.0, color: Colors.white, fontFamily: 'RobotoMono'),
        ),
        onPressed: () {
          setState(() {
            textControllerInput.text = "";
            textControllerResult.text = "";
          });
        },
        color: Colors.brown[400],
        padding: EdgeInsets.all(18.0),
        splashColor: Colors.white,
        shape: RoundedRectangleBorder(),
      ),
    );
  }
  Widget btnEqual(btnText,Color btnColor) {
    return Container(
      padding: EdgeInsets.only(bottom: 5.0),
      child: FlatButton(
        child: Text(
        btnText,
        style: TextStyle(fontSize: 28.0, color: Colors.white, fontFamily: 'RobotoMono'),
      ),

      onPressed: () {
        Parser p = new Parser();
        ContextModel cm = new ContextModel();
        Expression exp = p.parse(textControllerInput.text);
        setState(() {
          textControllerResult.text =
              exp.evaluate(EvaluationType.REAL, cm).toString();
              });
      },
        color: Colors.brown[400],
        padding: EdgeInsets.all(18.0),
        splashColor: Colors.white,
        shape: RoundedRectangleBorder(),
      ),

    );
  }
}
