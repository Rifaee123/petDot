
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'package:petdot/presentation/HomePage/bottem_navigaton_bar.dart';

class AppAboutPage extends StatefulWidget {
  const AppAboutPage({super.key});

  @override
  State<AppAboutPage> createState() => _AppAboutPageState();
}

class _AppAboutPageState extends State<AppAboutPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  bool ontaped = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);

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
      body: SingleChildScrollView(
        child: FadeTransition(
          opacity: _fadeInAnimation,
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              Center(
                child: SizedBox(
                  width: 800.w,
                  child: Center(
                    child: Image(
                        image: AssetImage(
                            'assets/images/Picsart_23-06-21_13-50-48-550.png')),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Text(
                  "We Welcome\nYou,with our\nopenHeart and\nPaws",
                  style: TextStyle(fontSize: 29),
                ),
              ),
              Center(
                child: SizedBox(
                  width: 1800.w,
                  child: Center(
                    child: Image(
                        image: AssetImage(
                            'assets/images/Screenshot 2023-06-17 125552.jpg')),
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              SizedBox(
                width: 1000.w,
                height: 80.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color.fromRGBO(79, 249, 217, 1), // background
                    foregroundColor: Colors.black, // foreground
                  ),
                  onPressed: () {
                    // FirebaseAuth.instance.signOut().then((value) =>
                    // Navigator.of(context).pushReplacement(MaterialPageRoute(
                    //   builder: (context) => SigninOrSignup(),
                    // ));
                    // GoogleSignIn().signOut().then((value) =>
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => BottemNavigaton(),
                    ));
                  },
                  child: Text(
                    'Get Start',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
