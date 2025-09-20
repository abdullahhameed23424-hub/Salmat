import 'package:animate_do/animate_do.dart';
import 'package:flutter/widgets.dart';
import 'package:salamat/Animation/animation_do_state.dart';

class FadeInDown extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;
  final Function(AnimateDoDirection direction)? onFinish;
  final Curve curve;

  FadeInDown(
      {key,
      required this.child,
      this.duration = const Duration(milliseconds: 800),
      this.delay = Duration.zero,
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.from = 100,
      this.onFinish,
      this.curve = Curves.easeOut})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  FadeInDownState createState() => FadeInDownState();
}

/// FadeState class
/// The animation magic happens here
class FadeInDownState extends State<FadeInDown>
    with SingleTickerProviderStateMixin, AnimateDoState {
  /// Animation for movement
  late Animation<double> animation;

  /// Animation for opacity
  late Animation<double> opacity;

  @override
  void dispose() {
    disposed = true;
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    animation = Tween<double>(begin: widget.from * -1, end: 0)
        .animate(CurvedAnimation(parent: controller, curve: widget.curve));

    opacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: const Interval(0, 0.65)));

    /// Provided by the mixin [AnimateDoState]
    configAnimation(
      delay: widget.delay,
      animate: widget.animate,
      manualTrigger: widget.manualTrigger,
      infinite: false,
      onFinish: widget.onFinish,
      controllerCallback: widget.controller,
    );
  }

  /// Public method to trigger reverse animation
  void reverse(   {required void Function() onPressed}) {
    if (!disposed && controller.isCompleted) {
      reverseAnimation(onPressed: onPressed  );
    }
  }

  void forward({void Function()? onPressed}) {
    if (!disposed && controller.isCompleted) {
      forwardAnimation(onPressed: onPressed);
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Provided by the mixin [AnimateDoState]
    buildAnimation(
      delay: widget.delay,
      animate: widget.animate,
      manualTrigger: widget.manualTrigger,
      infinite: false,
      onFinish: widget.onFinish,
      controllerCallback: widget.controller,
    );

    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          offset: Offset(0, animation.value),
          child: Opacity(
            opacity: opacity.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}
