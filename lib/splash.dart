import 'package:flutter/material.dart';

import 'form_generator.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigatetohome();
  }
  
  _navigatetohome()async{
    await Future.delayed(Duration(milliseconds: 2500), () {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FormGenerator()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.indigoAccent,
        child: Center(
          child: Image(
              image: AssetImage('assets/app_icon.png'),
              width: 200,
            height: 200,
          ),
      ),
        ),
      );
  }
}
