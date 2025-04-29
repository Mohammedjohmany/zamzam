import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zamzam/features/auth_feature/screen/sign_up_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Duration _splashDuration = const Duration(seconds: 6);
  final double _textSize = 48.0;
  final Color _baseShimmerColor = Colors.white.withOpacity(0.6);
  final Color _highlightShimmerColor = Colors.white;
  final Duration _shimmerDuration = const Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(_splashDuration);
    FlutterNativeSplash.remove();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue, 
        child: Stack(
          children: [
            Center(
              child: Container(
                width: 300, 
                height: 300, 
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/ss.jpg'),
                    fit: BoxFit.cover, 
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Shimmer.fromColors(
                  baseColor: _baseShimmerColor,
                  highlightColor: _highlightShimmerColor,
                  period: _shimmerDuration,
                  child: Text(
                    "ZamZam",
                    style: TextStyle(
                      fontSize: _textSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // تعديل اللون ليكون أكثر وضوحًا
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
