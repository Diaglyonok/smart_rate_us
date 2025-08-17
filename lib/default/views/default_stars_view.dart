import 'package:flutter/material.dart';

class DefaultStarsView extends StatefulWidget {
  final WidgetBuilder? starBuilder;
  const DefaultStarsView({super.key, this.starBuilder});

  @override
  State<DefaultStarsView> createState() => _DefaultStarsViewState();
}

class _DefaultStarsViewState extends State<DefaultStarsView>
    with TickerProviderStateMixin {
  static const Cubic easeInOutCircZoom = Cubic(.08, .43, .67, 1.8);
  static const Cubic easeInOutCircRotate = Cubic(.08, .43, .67, 2.8);

  static const int starCount = 5;
  static const Duration animationDuration = Duration(milliseconds: 500);
  static const Duration staggerDelay = Duration(milliseconds: 150);

  late List<AnimationController> _fadeControllers;
  late List<AnimationController> _scaleControllers;
  late List<AnimationController> _rotationControllers;

  late List<Animation<double>> _fadeAnimations;
  late List<Animation<double>> _scaleAnimations;
  late List<Animation<double>> _rotationAnimations;

  bool _disposed = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startSequentialAnimations();
  }

  void _initializeAnimations() {
    _fadeControllers = List.generate(
      starCount,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this,
      ),
    );

    _scaleControllers = List.generate(
      starCount,
      (index) => AnimationController(duration: animationDuration, vsync: this),
    );

    _rotationControllers = List.generate(
      starCount,
      (index) => AnimationController(duration: animationDuration, vsync: this),
    );

    _fadeAnimations = _fadeControllers
        .map(
          (controller) => Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut)),
        )
        .toList();

    _scaleAnimations = _scaleControllers
        .map(
          (controller) => Tween<double>(begin: 0.5, end: 1.0).animate(
            CurvedAnimation(parent: controller, curve: easeInOutCircZoom),
          ),
        )
        .toList();

    _rotationAnimations = _rotationControllers
        .map(
          (controller) => Tween<double>(begin: -0.254533, end: 0.0).animate(
            CurvedAnimation(parent: controller, curve: easeInOutCircRotate),
          ),
        )
        .toList();
  }

  void _startSequentialAnimations() {
    for (int i = 0; i < starCount; i++) {
      if (_disposed) break;

      Future.delayed(
        Duration(milliseconds: staggerDelay.inMilliseconds * i),
        () {
          if (!_disposed && mounted) {
            _fadeControllers[i].forward();
            _scaleControllers[i].forward();
            _rotationControllers[i].forward();
          }
        },
      );
    }
  }

  @override
  void dispose() {
    _disposed = true;
    for (var controller in _fadeControllers) {
      controller.dispose();
    }
    for (var controller in _scaleControllers) {
      controller.dispose();
    }
    for (var controller in _rotationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 100, maxWidth: 300),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(starCount, (index) {
          return AnimatedBuilder(
            animation: Listenable.merge([
              _fadeAnimations[index],
              _scaleAnimations[index],
              _rotationAnimations[index],
            ]),
            builder: (context, child) {
              return Expanded(
                child: Opacity(
                  opacity: _fadeAnimations[index].value,
                  child: Transform.scale(
                    scale: _scaleAnimations[index].value,
                    child: Transform.rotate(
                      angle: _rotationAnimations[index].value,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        child:
                            widget.starBuilder?.call(context) ??
                            Icon(
                              Icons.star_rounded,
                              size: 48,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
