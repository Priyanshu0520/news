import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news/pages/authentication/login.dart';

import 'pages/authentication/loginScreen.dart';
import 'pages/home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Hide the status bar and set the app to full-screen mode
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Wait for 3 seconds and navigate to the home screen
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }
  
 
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          SizedBox(height: 300,),

          
          FadeInImage(
            
            placeholder : AssetImage("lib/assets/taazalogo.png"),
          image: AssetImage("lib/assets/taazalogo.png") ,
          
          height: 350 , width: 350,),

          Spacer(),
          Text("Developed By\nPriyanshu" ,textAlign: TextAlign.center ,style: TextStyle(fontSize: 12 , fontWeight: FontWeight.bold),),
          SizedBox(height: 20,),
        ],
      )),
    );
  }
}