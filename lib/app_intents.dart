import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum Direction { up, down, left, right }

class AppIntents {
  static const _up = SingleActivator(LogicalKeyboardKey.arrowUp);
  static const _down = SingleActivator(LogicalKeyboardKey.arrowDown);
  static const _left = SingleActivator(LogicalKeyboardKey.arrowLeft);
  static const _right = SingleActivator(LogicalKeyboardKey.arrowRight);
  static const _cmdUp = SingleActivator(LogicalKeyboardKey.arrowUp, meta: true);
  static const _cmdDown =
      SingleActivator(LogicalKeyboardKey.arrowDown, meta: true);
  static const _cmdLeft =
      SingleActivator(LogicalKeyboardKey.arrowLeft, meta: true);
  static const _cmdRight =
      SingleActivator(LogicalKeyboardKey.arrowRight, meta: true);

  static const characterShortcuts = <ShortcutActivator, Intent>{
    _up: MoveIntent(Direction.up),
    _cmdUp: BumpIntent(Direction.up),
    _down: MoveIntent(Direction.down),
    _cmdDown: BumpIntent(Direction.down),
    _left: MoveIntent(Direction.left),
    _cmdLeft: BumpIntent(Direction.left),
    _right: MoveIntent(Direction.right),
    _cmdRight: BumpIntent(Direction.right),
  };

  static const _cmdZero =
      SingleActivator(LogicalKeyboardKey.digit0, meta: true);

  static const gameShortcuts = <ShortcutActivator, Intent>{
    _cmdZero: ResetIntent(),
  };
}

class MoveIntent extends Intent {
  const MoveIntent(this.direction);
  final Direction direction;
}

class BumpIntent extends Intent {
  const BumpIntent(this.direction);
  final Direction direction;
}

class ResetIntent extends Intent {
  const ResetIntent();
}
