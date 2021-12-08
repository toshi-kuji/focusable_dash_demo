import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameInstruction extends StatelessWidget {
  const GameInstruction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: DefaultTextStyle(
        style: GoogleFonts.kosugiMaru(
          color: Colors.black26,
          fontSize: 30,
          fontWeight: FontWeight.bold,
          height: 2.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('Tabキーかクリックでキャラを選びます'),
            Text('矢印キーでキャラを動かします'),
            Text('cmd(win) + 矢印キーでキャラを画面端へ '),
            Text('cmd(win) + 0 で全キャラの位置を戻します'),
          ],
        ),
      ),
    );
  }
}
