import 'package:flutter/material.dart';

class PantallaPresentacion extends StatefulWidget {
  const PantallaPresentacion({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<PantallaPresentacion> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "GFP",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 20.0),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
