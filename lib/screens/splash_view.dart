import 'dart:async';

import 'package:flutter/material.dart';

import '../app/resource/color_manager.dart';
import '../app/resource/constants.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashScreen> {
  Timer? _timer;
  _startDelay(){
    _timer=Timer(const Duration(seconds: AppConstants.splashDelay),
            ()=>Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>HomeScreen()))
    );
  }


  @override
  void initState(){
    _startDelay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: const Center(
        child: Image(
          image: AssetImage("assets/images/logo.png"),
        ),
      ),
    );
  }

  @override
  void dispose(){
    _timer?.cancel();
    super.dispose();
  }

}