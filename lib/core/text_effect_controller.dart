import 'package:flutter/animation.dart';

class TextEffectController {
  AnimationController? animationController;

  bool get isPlaying => animationController?.isAnimating ?? false;
  bool get isCompleted => animationController?.isCompleted ?? false;
  double get progress => animationController?.value ?? 0.0;

  void play() => animationController?.forward();
  void pause() => animationController?.stop();
  void stop() {
    animationController?.stop();
    animationController?.reset();
  }

  void repeat({int? count, bool reverse = false}) =>
      animationController?.repeat(count: count, reverse: reverse);

  void seekTo(double value) {
    animationController?.value = value.clamp(0.0, 1.0);
  }

  void dispose() => animationController = null;
}
