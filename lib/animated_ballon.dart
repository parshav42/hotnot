import "package:flutter/animation.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class AnimatedBalloonWidget extends StatefulWidget {
  const AnimatedBalloonWidget({super.key});

  @override
  State<AnimatedBalloonWidget> createState() => _AnimatedBalloonWidgetState();
}

class _AnimatedBalloonWidgetState extends State<AnimatedBalloonWidget>
    with TickerProviderStateMixin {
  late AnimationController _controllerFloatUp;
  late AnimationController _controllerGrowSize;
  late Animation<double> _animationFloatUp;
  late Animation<double> _animationGrowSize;

  @override
  void initState() {
    super.initState();
    _controllerFloatUp =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    _controllerGrowSize =
        AnimationController(duration: const Duration(seconds: 4), vsync: this);
  }

  @override
  void dispose() {
    _controllerFloatUp.dispose();
    _controllerGrowSize.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double balloonHeight = MediaQuery.of(context).size.height / 2;
    double balloonWidth = MediaQuery.of(context).size.width / 3; // Changed to width for better aspect ratio
    double balloonBottomLocation =
        MediaQuery.of(context).size.height - balloonHeight;

    _animationFloatUp =
        Tween<double>(begin: balloonBottomLocation, end: 0.0).animate(
      CurvedAnimation(
        parent: _controllerFloatUp,
        curve: Curves.fastOutSlowIn, // Corrected Canvas to Curves
      ),
    );
    _animationGrowSize = Tween<double>(begin: 50, end: balloonWidth).animate( // Start with a small size
      CurvedAnimation(
        parent: _controllerGrowSize,
        curve: Curves.fastOutSlowIn, // Corrected Canvas to Curves
      ),
    );

    // Start animations if they haven't been started
    if (!_controllerFloatUp.isAnimating) {
      _controllerFloatUp.forward();
    }
    if (!_controllerGrowSize.isAnimating) {
      _controllerGrowSize.forward();
    }

    return AnimatedBuilder(
      animation: _animationFloatUp, // Corrected 'animaion' to 'animation'
      builder: (context, child) {
        return Container(
          margin: EdgeInsets.only(
            top: _animationFloatUp.value,
          ),
          width: _animationGrowSize.value, // Apply grow animation to width
          child: child,
        );
      },
      child: GestureDetector(
        onTap: () {
          if (_controllerFloatUp.isCompleted) {
            _controllerFloatUp.reverse();
            _controllerGrowSize.reverse();
          } else {
            _controllerFloatUp.forward();
            _controllerGrowSize.forward();
          }
        },
        child: Image.asset( // Corrected 'image.asset' to 'Image.asset'
          'assets/imges/—Pngtree—party colorful fluttering balloons_4892115.png', // Assuming image is in assets folder
          height: balloonHeight, // Use the calculated balloonHeight
          // width is now controlled by _animationGrowSize in the AnimatedBuilder
        ),
      ),
    );
  }
}