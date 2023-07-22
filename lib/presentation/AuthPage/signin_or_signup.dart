// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:petdot/presentation/AuthPage/Login/loginpage.dart';
import 'package:petdot/presentation/AuthPage/SignUp/signinPage.dart';

class SigninOrSignup extends StatelessWidget {
  const SigninOrSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 80.h,
              ),
              Center(
                child: SizedBox(
                  width: 700.w,
                  child: Center(
                    child: Image(
                        image: AssetImage(
                            'assets/images/Picsart_23-06-21_13-50-48-550.png')),
                  ),
                ),
              ),
              Text.rich(
                TextSpan(
                    text: 'Welcome To ',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: "petDot",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyan),
                      )
                    ]),
              ),
              SizedBox(
                height: 80.h,
              ),
              SizedBox(
                width: 1600.w,
                child: Image(
                    image: AssetImage(
                        'assets/images/Screenshot_2023-07-06_143814-removebg-preview.png')),
              ),
              SizedBox(
                height: 80.h,
              ),
              SizedBox(
                width: 1500.w,
                height: 80.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color.fromRGBO(79, 249, 217, 1), // background
                    foregroundColor: Colors.black, // foreground
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ));
                  },
                  child: Text(
                    'LOGIN',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 60.h,
                child: Center(
                  child: Text(
                    'or',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 1500.w,
                height: 80.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color.fromRGBO(177, 128, 248, 1), // background
                    foregroundColor: Colors.black, // foreground
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SignInSignUpPage(),
                    ));
                  },
                  child: Text(
                    'SIGNUP',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
