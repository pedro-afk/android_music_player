import 'package:flutter/material.dart';

class AnimationManager {
  Animatable<Offset> animationTransitionTween() {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.ease;
    return Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  }
}
