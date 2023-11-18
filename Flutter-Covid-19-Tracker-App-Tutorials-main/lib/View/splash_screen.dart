import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: 3),
    vsync: this)..repeat();

    @override
    void initState() {
      super.initState();
      Future.delayed(Duration(seconds: 3),(){
        Navigator.pushNamed(context, 'demo');
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              AnimatedBuilder(
                animation: _controller, 
                child: Container(
                  width: 100,
                  height: 100,
                  child: Image(image: AssetImage(
                    'images/virus.png'
                  )),
                ),
                builder: (BuildContext context, Widget?chid){
                  return Transform.rotate(
                    angle: _controller.value * 2.0 * math.pi,
                    child: chid,
                    );
                }),
                SizedBox(height: 20,),
                Text('Covid-19\nTrackers',style: TextStyle(fontSize: 10),)
                
              
            ],
          ),
        ),
      ),
    );
  }
}
