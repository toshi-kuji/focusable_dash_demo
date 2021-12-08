import 'package:flutter/material.dart';

import '../app_intents.dart';

class FocusableDash extends StatefulWidget {
  FocusableDash({
    required ValueKey<int> key,
    required this.onMoveAction,
    required this.onBumpAction,
    this.color = Colors.black,
    this.autoFocus = false,
  })  : index = key.value,
        super(key: key);

  final int index;
  final void Function(int index, Direction direction) onMoveAction;
  final void Function(int index, Direction direction) onBumpAction;
  final Color color;
  final bool autoFocus;

  @override
  State<FocusableDash> createState() => _FocusableDashState();
}

class _FocusableDashState extends State<FocusableDash> {
  final focusNode = FocusNode();
  late bool hasFocus = widget.autoFocus;

  late final actions = <Type, Action>{
    MoveIntent: CallbackAction<MoveIntent>(onInvoke: (intent) {
      widget.onMoveAction.call(widget.index, intent.direction);
    }),
    BumpIntent: CallbackAction<BumpIntent>(onInvoke: (intent) {
      widget.onBumpAction.call(widget.index, intent.direction);
    }),
  };

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() => hasFocus = focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      autofocus: widget.autoFocus,
      focusNode: focusNode,
      shortcuts: AppIntents.characterShortcuts,
      actions: actions,
      child: InkWell(
        customBorder: const CircleBorder(),
        hoverColor: Colors.amber.withOpacity(0.3),
        canRequestFocus: false,
        onTap: focusNode.requestFocus,
        child: Icon(
          Icons.flutter_dash,
          color: hasFocus ? widget.color : widget.color.withOpacity(0.25),
          size: 150,
        ),
      ),
    );
  }
}
