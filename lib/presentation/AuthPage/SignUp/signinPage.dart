import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:petdot/presentation/AuthPage/CommonPage/appAbout.dart';

import 'package:petdot/presentation/AuthPage/Login/loginpage.dart';

class SignInSignUpPage extends StatefulWidget {
  @override
  _SignInSignUpPageState createState() => _SignInSignUpPageState();
}

class _SignInSignUpPageState extends State<SignInSignUpPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  TextEditingController singupemailcontroller = TextEditingController();
  TextEditingController signupPasswordcontroller = TextEditingController();
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

  // final snapshot1 = FirebaseAuth.instance.currentUser.isNull;c
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
                          text: 'SIGNUP ',
                          style: TextStyle(
                            color: Color.fromARGB(255, 178, 128, 248),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'sign up to continue',
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
                    width: 1650.w,
                    height: 300.h,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/clip-1427.png"),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 1760.w,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadiusDirectional.all(Radius.circular(30)),
                          // color: Color.fromARGB(158, 178, 128, 248),
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return "Please enter a valid Email";
                            } else {
                              return null;
                            }
                          },
                          controller: singupemailcontroller,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(158, 178, 128, 248),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            hintText: 'Enter your email',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Container(
                        width: 1760.w,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadiusDirectional.all(Radius.circular(30)),
                          // color: Color.fromARGB(158, 178, 128, 248),
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty || value.length < 8) {
                              return "Please enter a valid Password";
                            } else {
                              return null;
                            }
                          },
                          controller: signupPasswordcontroller,
                          obscureText: ontaped,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(158, 178, 128, 248),
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
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Center(
                        child: SizedBox(
                          width: 280.h,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromRGBO(
                                  177, 128, 248, 1), // background
                              foregroundColor: Colors.black, // foreground
                            ),
                            onPressed: () async {
                              _key.currentState!.validate();
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: singupemailcontroller.text.trim(),
                                      password:
                                          signupPasswordcontroller.text.trim());

                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                animType: AnimType.rightSlide,
                                title: 'Dialog Title',
                                desc: 'Dialog description here.............',
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {},
                              )..show();
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SignInSignUpPage(),
                              ));
                            },
                            child: Text(
                              'SIGNUP',
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
                              text: 'Alredy have an accoount ? ',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.of(context)
                                            .pushReplacement(MaterialPageRoute(
                                          builder: (context) => LoginPage(),
                                        )),
                                  text: "Login",
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
                      Center(child: Text("OR")),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () => signInWithGoogle(),
                              child: Container(
                                  width: 155.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        "assets/images/icons8-google-48.png"),
                                  ))),
                            ),
                            Container(
                                width: 155.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                      "assets/images/icons8-facebook-48.png"),
                                ))),
                            Container(
                                width: 155.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                      "assets/images/icons8-twitter-48.png"),
                                ))),
                          ]),
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

  signUpWithEmailPass(singupemailcontroller, signupPasswordcontroller) async {
    try {
      String email = singupemailcontroller.text.trim();
      String password = signupPasswordcontroller.text.trim();

      // Register user with Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Add user details to Firestore
      String userId = userCredential.user!.uid;

      Map<String, dynamic> userData = {
        'email': email,
        // Add other user-related fields here
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('userlist')
          .add(userData);

      print('User registered successfully!');
    } catch (e) {
      print('Error registering user: $e');
      // Handle registration errors
    }
    // await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //     email: singupemailcontroller, password: signupPasswordcontroller);
  }

  signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      AuthCredential credentionl = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredentiol =
          await FirebaseAuth.instance.signInWithCredential(credentionl);
      print(userCredentiol.user?.displayName);

      // Add user details to Firestore
      String userId = userCredentiol.user!.uid;

      Map<String, dynamic> userData = {
        'email': userCredentiol.user?.email,
        // Add other user-related fields here
      };
      if (userCredentiol.user != null) {
        return FirebaseFirestore.instance
            .collection('user')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection(userId)
            .add(userData)
            .then((value) =>
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => AppAboutPage(),
                )));
      }

      print('User registered successfully!');
    } catch (e) {
      print('Error registering user: $e');
      // Handle registration errors
    }
    // GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    // AuthCredential credentionl = GoogleAuthProvider.credential(
    //   accessToken: googleAuth?.accessToken,
    //   idToken: googleAuth?.idToken,
    // );
    // UserCredential userCredentiol =
    //     await FirebaseAuth.instance.signInWithCredential(credentionl);
    // print(userCredentiol.user?.displayName);
  }
}
