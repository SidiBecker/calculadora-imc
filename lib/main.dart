import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home(), debugShowCheckedModeBanner: false));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weigthController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _info = "Informe seus dados";
  bool _validForm = false;

  void _resetFields() {
    weigthController.text = "";
    heightController.text = "";

    setState(() {
      _info = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
      _validForm = true;
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weigthController.text);
      double height = double.parse(heightController.text) / 100;

      double imc = weight / (height * height);

      String message = "";
      print(imc);
      if (imc < 18.6) {
        message = "Abaixo do peso";
      } else if (imc >= 18.6 && imc < 24.9) {
        message = "Peso Ideal";
      } else if (imc >= 24.9 && imc < 29.9) {
        message = "Levemente acima do peso";
      } else if (imc >= 29.9 && imc < 34.9) {
        message = "Obesidade grau I";
      } else if (imc >= 34.9 && imc < 40) {
        message = "Obesidade grau II";
      } else if (imc >= 40) {
        message = "Obesidade grau III";
      }

      _info = message + " (${imc.toStringAsPrecision(4)})";
    });
  }

  void _onFieldChanged(value) {
    if (!_validForm && value.isNotEmpty) {
      setState(() {
        _validForm = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Calculadora de IMC"),
            centerTitle: true,
            backgroundColor: Colors.teal[300],
            actions: <Widget>[
              IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields)
            ],
          ),
          backgroundColor: Colors.white,
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text("Powered by github.com/SidiBecker"),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10, 0.0),
            child: Column(
              children: <Widget>[
                Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.person_outline,
                          size: 120.0,
                          color: Colors.teal[300],
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Peso(kg)",
                              labelStyle: TextStyle(color: Colors.teal[300])),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.teal[300], fontSize: 25.0),
                          controller: weigthController,
                          validator: (value) {
                            return value.isEmpty ? "Insira seu Peso!" : null;
                          },
                          onChanged: _onFieldChanged,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Altura(cm)",
                              labelStyle: TextStyle(color: Colors.teal[300])),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.teal[300], fontSize: 25.0),
                          controller: heightController,
                          validator: (value) {
                            return value.isEmpty ? "Insira sua Altura!" : null;
                          },
                          onChanged: _onFieldChanged,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Container(
                            height: 50.0,
                            child: RaisedButton(
                              color: Colors.teal[300],
                              disabledColor: Colors.grey,
                              onPressed: _validForm
                                  ? () {
                                      setState(() {
                                        _validForm =
                                            _formKey.currentState.validate();
                                      });
                                      if (_validForm) {
                                        _calculate();
                                      }
                                    }
                                  : null,
                              child: Text(
                                "Calcular",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25.0),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          _info,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.teal[300], fontSize: 25.0),
                        ),
                      ],
                    )),
              ],
            ),
          )),
    );
  }
}
