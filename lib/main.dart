import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

void main() => runApp(MyApp());
GlobalKey<_IMCResultState> globalKey = GlobalKey();
int _imc = 0;

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      theme: ThemeData(
        fontFamily: 'Lato',
        primarySwatch: Colors.teal,
        cursorColor: Colors.teal,
        buttonColor: Color(0xFF8695D2),
      ),
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: <Widget>[
            Container(
              child: Image.asset('assets/background.png'),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: TopContainer(),
                      ),
                      Expanded(
                        flex: 4,
                        child: BottomContainer(),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BottomContainer extends StatelessWidget {
  final _maskController = new MaskedTextController(mask: '0.00');
  final _weightController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CardTitle(
              title: 'Altura',
              textColor: Colors.white,
            ),
            InputCard(
              controller: _maskController,
              subTitle: 'em metros',
            ),
            CardTitle(
              title: 'Peso',
              textColor: Color(0xFF8695D2),
            ),
            InputCard(
              controller: _weightController,
              subTitle: 'em quilos',
            ),
            SizedBox(
              height: 30,
            ),
            CalculateButton(_maskController, _weightController),
            SizedBox(
              height: 10,
            ),
            IMCResult(key: globalKey),
          ],
        ),
      ),
    );
  }
}

class IMCResult extends StatefulWidget {
  IMCResult({Key key}) : super(key: key);

  @override
  _IMCResultState createState() => _IMCResultState();
}

class _IMCResultState extends State<IMCResult> {

  calculate(int result) {
    setState(() {
      _imc = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.black,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
            '$_imc',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class InputCard extends StatelessWidget {
  final String subTitle;

  const InputCard({
    Key key,
    TextEditingController controller,
    this.subTitle,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 130,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(30, 20, 10, 5),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _controller,
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'RobotoMono',
                  color: Colors.green[400],
                ),
                decoration: InputDecoration.collapsed(
                  hintText: null,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 5, 10, 5),
              child: Text(
                subTitle,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardTitle extends StatelessWidget {
  final String title;
  final Color textColor;

  const CardTitle({Key key, this.title, this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 20, 10, 0),
      child: Text(
        '$title  >',
        style: TextStyle(
            color: textColor,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
      ),
    );
  }
}

class CalculateButton extends StatelessWidget {
  CalculateButton(this._maskedTextController, this._weightController);

  final MaskedTextController _maskedTextController;
  final TextEditingController _weightController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      width: 250,
      height: 50,
      child: RaisedButton(
        elevation: 10,
        onPressed: () {
          var height = double.parse(_maskedTextController.text);
          var weight = int.parse(_weightController.text);
          var result = (int.parse((weight / (height * height)).toStringAsFixed(0)));
          globalKey.currentState.calculate(result);
        },
        child: Text(
          'Calcular',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
      ),
    );
  }
}

class TopContainer extends StatelessWidget {
  const TopContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
//        child: Text(
//          'Calcule seu IMC',
//          style: TextStyle(fontSize: 35, color: Colors.white),
//        ),
          ),
    );
  }
}
