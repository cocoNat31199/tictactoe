import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/screen/tictactoe.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final number = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            minimum: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Text(
                  'Tic Tac Toe',
                  style: GoogleFonts.roboto(fontSize: 32),
                )),
                SizedBox(
                  height: 8,
                ),
                Text('Plese enter the number of rows and columns',
                    style: GoogleFonts.roboto(fontSize: 16)),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: 64,
                  child: TextFormField(
                    controller: number,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    onPressed: () {
                      var matrixnumber = int.parse(number.text);
                      if (matrixnumber < 3 || matrixnumber > 9) {
                        Fluttertoast.showToast(
                            msg: 'Please enter 3 - 9',
                            gravity: ToastGravity.BOTTOM);
                      } else if (number.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: 'Please enter number',
                            gravity: ToastGravity.BOTTOM);
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Tictactoe(
                                      number: matrixnumber,
                                    )));
                      }
                    },
                    child: Text('Start'))
              ],
            )));
  }
}
