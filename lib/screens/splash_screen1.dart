import 'package:fin_application/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _imageAnimation;
  late Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    final imageAnimationInterval = Interval(0.0, 0.6);
    _imageAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: imageAnimationInterval,
      ),
    );

    final textAnimationInterval = Interval(0.4, 1.0);
    _textAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: textAnimationInterval,
      ),
    );

    _animationController.forward();

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SplashScreen()));
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(98, 54, 255, 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Opacity(
                  opacity: _imageAnimation.value,
                  child: Transform.scale(
                    scale: _imageAnimation.value,
                    child: Image.asset(
                      'assets/images/new.png', // Change to your image path
                      width: 300,
                      height: 300,
                      color: Colors
                          .white, // If you want to apply color to the image
                    ),
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Opacity(
                  opacity: _textAnimation.value,
                  child: Text(
                    "Your number one solution to finance...",
                    style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                      fontSize: 15 *
                          _textAnimation
                              .value, // Adjust font size with animation
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
