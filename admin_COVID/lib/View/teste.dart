import 'package:flutter/material.dart';

class Teste extends StatefulWidget {
  @override
  _TesteState createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Card(
            child: Wrap(
              children: [
                Container(
                  height: 350,
                  width: 350,
                  color: Colors.red,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .7,
                  height: 350,
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
