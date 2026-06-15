import 'package:flutter/animation.dart';

/// External playback controller for [AnimatedText].
///
/// Allows a separate widget or service to control animation playback
/// (play, pause, stop, seek, repeat) independently of the widget lifecycle.
///
/// Use [attach] and [detach] to persist animation progress across widget
/// mount/unmount cycles, enabling scroll persistence.
class TextEffectController {
  AnimationController? _controller;
  VoidCallback? _listener;
  double _savedProgress = 0.0;
  bool _wasAnimating = false;

  /// The underlying [AnimationController], if attached.
  AnimationController? get animationController => _controller;

  /// Whether the animation is currently running.
  bool get isPlaying => _controller?.isAnimating ?? false;

  /// Whether the animation has reached 1.0.
  bool get isCompleted => _controller?.isCompleted ?? false;

  /// Current animation progress from 0.0 to 1.0.
  double get progress => _controller?.value ?? _savedProgress;

  /// Attaches this controller to a [TickerProvider] (usually a [State]).
  ///
  /// Restores the previous progress and playback state if [detach] was
  /// called earlier.
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

  /// Detaches from the [TickerProvider], saving progress and state.
  ///
  /// Call before the widget is disposed to preserve animation state.
  void detach() {
    if (_controller != null) {
      _savedProgress = _controller!.value;
      _wasAnimating = _controller!.isAnimating;
      _controller!.removeListener(_listener!);
      _controller!.stop();
      _listener = null;
    }
  }

  /// Starts or resumes forward playback.
  void play() => _controller?.forward();

  /// Pauses playback at the current position.
  void pause() => _controller?.stop();

  /// Stops playback and resets progress to 0.0.
  void stop() {
    _controller?.stop();
    _controller?.reset();
  }

  /// Repeats the animation, optionally a specific [count] and [reverse].
  ///
  /// [count] — number of repetitions (null = infinite). When set, the
  /// animation stops after [count] completions.
  /// [reverse] — when true, each cycle plays forward then backward,
  /// doubling the effective duration per cycle.
  void repeat({int? count, bool reverse = false}) =>
      _controller?.repeat(count: count, reverse: reverse);

  /// Seeks to a specific [value] (0.0–1.0) without animation.
  void seekTo(double value) {
    _controller?.value = value.clamp(0.0, 1.0);
  }

  /// Disposes the internal [AnimationController] and releases resources.
  void dispose() {
    _controller?.dispose();
    _controller = null;
    _listener = null;
  }
}
