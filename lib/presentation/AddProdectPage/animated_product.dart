import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:petdot/presentation/HomePage/Home.dart';
import 'package:petdot/presentation/HomePage/bottem_navigaton_bar.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  void initState() {
    _showAddScreen();
    // TODO: implement initState
    super.initState();
  }

  void _showAddScreen() {
    // Delay the screen disappearance after 3 seconds
    Future.delayed(Duration(seconds: 3), () async {}).then((value) =>
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => BottemNavigaton())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset('assets/images/transistor-fast-delivery-1.gif'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Image.asset('assets/images/flame-53.gif'),
          )
        ],
      )),
    );
  }
}
