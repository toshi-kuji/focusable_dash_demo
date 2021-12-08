import 'package:flutter/material.dart';

import 'app_intents.dart';
import 'widgets/focusable_dash.dart';
import 'widgets/game_instruction.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const initialAlignments = <int, Alignment>{
    0: Alignment(0, -0.6),
    1: Alignment(0, -0.2),
    2: Alignment(0, 0.2),
    3: Alignment(0, 0.6),
  };

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _duration = const Duration(milliseconds: 1000);
  final _curve = Curves.decelerate;
  final _alignments = Map.of(HomePage.initialAlignments);

  final _focusNode = FocusNode(skipTraversal: true);
  late final _gameActions = {
    ResetIntent: CallbackAction(onInvoke: (intent) {
      setState(() {
        _alignments.addAll(Map.of(HomePage.initialAlignments));
      });
    }),
  };

  void _move(int index, Direction direction) {
    final alignment = _alignments[index]!;
    setState(() {
      switch (direction) {
        case Direction.up:
          _alignments[index] = alignment + const Alignment(0, -0.1);
          break;
        case Direction.down:
          _alignments[index] = alignment + const Alignment(0, 0.1);
          break;
        case Direction.left:
          _alignments[index] = alignment + const Alignment(-0.1, 0);
          break;
        case Direction.right:
          _alignments[index] = alignment + const Alignment(0.1, 0);
      }
    });
  }

  void _bump(int index, Direction direction) {
    final alignment = _alignments[index]!;
    setState(() {
      switch (direction) {
        case Direction.up:
          _alignments[index] = Alignment(alignment.x, -1);
          break;
        case Direction.down:
          _alignments[index] = Alignment(alignment.x, 1);
          break;
        case Direction.left:
          _alignments[index] = Alignment(-1, alignment.y);
          break;
        case Direction.right:
          _alignments[index] = Alignment(1, alignment.y);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      focusNode: _focusNode,
      shortcuts: AppIntents.gameShortcuts,
      actions: _gameActions,
      child: Scaffold(
        body: FocusScope(
          child: Stack(
            children: <Widget>[
              const GameInstruction(),
              AnimatedAlign(
                duration: _duration,
                curve: _curve,
                alignment: _alignments[0]!,
                child: FocusableDash(
                  key: const ValueKey<int>(0),
                  autoFocus: true,
                  onMoveAction: _move,
                  onBumpAction: _bump,
                ),
              ),
              AnimatedAlign(
                duration: _duration,
                curve: _curve,
                alignment: _alignments[1]!,
                child: FocusableDash(
                  key: const ValueKey<int>(1),
                  color: Colors.red,
                  onMoveAction: _move,
                  onBumpAction: _bump,
                ),
              ),
              AnimatedAlign(
                duration: _duration,
                curve: _curve,
                alignment: _alignments[2]!,
                child: FocusableDash(
                  key: const ValueKey<int>(2),
                  color: Colors.blue,
                  onMoveAction: _move,
                  onBumpAction: _bump,
                ),
              ),
              AnimatedAlign(
                duration: _duration,
                curve: _curve,
                alignment: _alignments[3]!,
                child: FocusableDash(
                  key: const ValueKey<int>(3),
                  color: Colors.green,
                  onMoveAction: _move,
                  onBumpAction: _bump,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
