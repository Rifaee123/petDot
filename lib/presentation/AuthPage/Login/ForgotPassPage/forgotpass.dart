import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petdot/presentation/AuthPage/Login/loginpage.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  TextEditingController emailcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Enter your Email Id',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 80.h,
              width: 1800.w,
              decoration: BoxDecoration(
                color: Color.fromRGBO(177, 128, 248, 1),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: TextFormField(
                obscureText: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                  hintText: 'Enter your Email',
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30)),
                ),
                controller: emailcontroller,
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            SizedBox(
              width: 1247.w,
              height: 80.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color.fromRGBO(177, 128, 248, 1), // background
                  foregroundColor: Colors.black, // foreground
                ),
                onPressed: () async {
                  await FirebaseAuth.instance
                      .sendPasswordResetEmail(
                          email: emailcontroller.text.trim().toLowerCase())
                      .then((value) =>
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          )));
                },
                child: Text(
                  'LOGIN',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
