import 'package:flutter/animation.dart';

class TextEffectController {
  AnimationController? _controller;
  VoidCallback? _listener;
  double _savedProgress = 0.0;
  bool _wasAnimating = false;

  AnimationController? get animationController => _controller;
  bool get isPlaying => _controller?.isAnimating ?? false;
  bool get isCompleted => _controller?.isCompleted ?? false;
  double get progress => _controller?.value ?? _savedProgress;

  void attach(TickerProvider vsync, Duration duration, VoidCallback listener) {
    if (_controller != null) {
      final oldValue = _controller!.value;
      if (_listener != null) {
        _controller!.removeListener(_listener!);
      }
      _controller!.dispose();
      _controller = AnimationController(vsync: vsync, duration: duration);
      _controller!.value = oldValue.clamp(0.0, 1.0);
      _listener = listener;
      _controller!.addListener(listener);
      if (_wasAnimating) {
        _controller!.forward();
        _wasAnimating = false;
      }
    } else {
      _controller = AnimationController(vsync: vsync, duration: duration);
      _controller!.value = _savedProgress.clamp(0.0, 1.0);
      _listener = listener;
      _controller!.addListener(listener);
      if (_wasAnimating) {
        _controller!.forward();
        _wasAnimating = false;
      }
    }
  }

  void detach() {
    if (_controller != null) {
      _savedProgress = _controller!.value;
      _wasAnimating = _controller!.isAnimating;
      _controller!.removeListener(_listener!);
      _controller!.stop();
      _listener = null;
    }
  }

  void play() => _controller?.forward();
  void pause() => _controller?.stop();
  void stop() {
    _controller?.stop();
    _controller?.reset();
  }

  void repeat({int? count, bool reverse = false}) =>
      _controller?.repeat(count: count, reverse: reverse);

  void seekTo(double value) {
    _controller?.value = value.clamp(0.0, 1.0);
  }

  void dispose() {
    _controller?.dispose();
    _controller = null;
    _listener = null;
  }
}
