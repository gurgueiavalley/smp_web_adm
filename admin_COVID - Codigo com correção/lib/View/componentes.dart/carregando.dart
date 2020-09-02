import 'package:flutter/material.dart';

class Carregando extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
              Colors.blue,
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Text('Aguarde...'),
        ],
      ),
    );
  }
}
