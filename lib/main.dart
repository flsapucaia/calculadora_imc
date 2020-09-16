//Aplicativo do curso de Flutter da Udemy.

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus Dados";

  void _resetFields(){
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus Dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void calculate(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      print(imc);

      if(imc < 18.6){
        _infoText = "Abaixo do Peso (imc: ${imc.toStringAsPrecision(3)})";
      } else if(imc >= 18.6 && imc < 25){
        _infoText = "Peso Ideal (imc: ${imc.toStringAsPrecision(3)})";
      } else if(imc >= 25 && imc < 30){
        _infoText = "Sobrepeso (imc: ${imc.toStringAsPrecision(3)})";
      } else if(imc >= 30 && imc < 35) {
        _infoText = "Obesidade Grau I (imc: ${imc.toStringAsPrecision(3)})";
      } else if(imc >= 35 && imc < 40) {
        _infoText = "Obesidade Grau II (imc: ${imc.toStringAsPrecision(3)})";
      } else if(imc >= 40) {
        _infoText = "Obesidade Grau III (imc: ${imc.toStringAsPrecision(3)})";
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.red[900],
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.person_outline,
                  size: 120,
                  color: Colors.red,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(color: Colors.red)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red, fontSize: 25),
                  controller: weightController,
                  validator: (value) {
                    if(value.isEmpty){
                      return "Insira seu Peso!";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.red)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red, fontSize: 25),
                  controller: heightController,
                  validator: (value) {
                    if(value.isEmpty){
                      return "Insira sua Altura!";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                      onPressed: () {
                        if(_formKey.currentState.validate()){
                          calculate();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      color: Colors.red,
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red, fontSize: 25),
                )
              ],
            ),
          )
        ));
  }
}
