import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:petdot/presentation/AuthPage/CommonPage/appAbout.dart';
import 'package:petdot/presentation/AuthPage/Login/ForgotPassPage/forgotpass.dart';
import 'package:petdot/presentation/AuthPage/SignUp/signinPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  final _key = GlobalKey<FormState>();
  bool ontaped = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250.h,
              width: double.infinity,
              child: FadeTransition(
                opacity: _fadeInAnimation,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: 'LOGIN ',
                          style: TextStyle(
                            color: Color(0xFF4FF9D9),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Login to continue',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            FadeTransition(
              opacity: _fadeInAnimation,
              child: Center(
                child: Container(
                    width: 1620.w,
                    height: 300.h,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/clip-1039.png"),
                    ))),
              ),
            ),
            SizedBox(height: 10.h),
            Form(
              key: _key,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: FadeTransition(
                  opacity: _fadeInAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 1760.w,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadiusDirectional.all(Radius.circular(30)),
                          // color: Color.fromARGB(176, 79, 249, 218),
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return "Please enter a valid Email";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(176, 79, 249, 218),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            hintText: 'Enter your email',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          controller: emailcontroller,
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Container(
                        width: 1760.w,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadiusDirectional.all(Radius.circular(30)),
                          // color: Color.fromARGB(176, 79, 249, 218),
                        ),
                        child: TextFormField(
                          obscureText: ontaped,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 8) {
                              return "Please enter a valid Password";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(176, 79, 249, 218),
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  if (ontaped == false) {
                                    ontaped = true;
                                  } else {
                                    ontaped = false;
                                  }
                                });
                              },
                              child: Icon(
                                ontaped == true
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.key,
                              color: Colors.black,
                            ),
                            hintText: 'Enter your password',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          controller: passcontroller,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      Center(
                        child: SizedBox(
                          width: 1247.w,
                          height: 80.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF4FF9D9), // background
                              foregroundColor: Colors.black, // foreground
                            ),
                            onPressed: () async {
                              _key.currentState!.validate();
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: emailcontroller.text.trim(),
                                      password: passcontroller.text.trim())
                                  .then((value) => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => AppAboutPage(),
                                      )));
                            },
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Center(
                        child: Text.rich(
                          TextSpan(
                              text: 'Don`t Have An Account ?',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.of(context)
                                            .pushReplacement(MaterialPageRoute(
                                          builder: (context) =>
                                              SignInSignUpPage(),
                                        )),
                                  text: "Signup",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.cyan),
                                )
                              ]),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Center(
                          child: GestureDetector(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ForgotPass(),
                        )),
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ))
                    ],
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
