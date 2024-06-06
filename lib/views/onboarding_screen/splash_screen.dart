import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'carousel_1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward().whenComplete(() {
      // Navigate to  next page
      // Navigator.pushReplacementNamed(context, OnboardingPageOne()); 
      Navigator.push(context, MaterialPageRoute(builder:(context) => OnboardingPageOne()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background dots animation
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return CustomPaint(
                  painter: DotsPainter(_animation.value),
                  size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
                );
              },
            ),
            
            // App Logo
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Container(
                  width: 100,
                  height: 100,
                  
                  decoration: BoxDecoration(
                    color: Color(0xFF13B156), // Green background
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child:  SvgPicture.asset(
                      'assets/icons/svg/logo.svg', 
                      width: 60,
                      height: 60,
                    ),
                ),
               
                const SizedBox(height: 50),
                // Loading indicator
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF13B156)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Custom painter for background dots animation
class DotsPainter extends CustomPainter {
  final double progress;

  DotsPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Color(0xFFE8F5E9); // Light green color
    final center = Offset(size.width / 2, size.height / 2);

    // Draw dots with varying sizes and opacity based on progress
    for (var i = 0; i < 10; i++) {
      final radius = (10 + 15 * i) * progress;
      final opacity = (1 - progress * 0.5).clamp(0.0, 1.0);
      paint.color = paint.color.withOpacity(opacity);
      canvas.drawCircle(center + Offset(0, -100 * i * progress), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}