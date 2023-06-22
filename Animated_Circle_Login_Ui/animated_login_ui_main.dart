import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animation_beautiful_uis/Screens/circle_Login_beautiful_page/Animated_Circle_Login_Ui/Constant_File/colors_file.dart';

import 'animated_login_widget.dart';

void main(List<String> args) {
  runApp(const AnimatedLoginScreen());

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
}

class AnimatedLoginScreen extends StatelessWidget {
  const AnimatedLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const CircleAnimatedUi(),
    );
  }
}

class CircleAnimatedUi extends StatefulWidget {
  const CircleAnimatedUi({super.key});

  @override
  State<CircleAnimatedUi> createState() => _CircleAnimatedUiState();
}

class _CircleAnimatedUiState extends State<CircleAnimatedUi> with TickerProviderStateMixin {
  
  late Animation<Offset> offsetFirstContainerAnimation;
  late Animation<Offset> offsetRowFirstContainerAnimation;
  late Animation<Offset> offsetRowSecondContainerAnimation;
  late Animation<Offset> offsetThirdContainerAnimation;
  late Animation<Offset> offsetForthContainerAnimation;
  
  // **AnimationController 
  late AnimationController firstAnimationController;
  late AnimationController secondAnimationController;

  @override
  void initState() {
    super.initState();
    // ** FIRST ANIMATION CONTROLLER .
    firstAnimationController =AnimationController(vsync: this, duration: const Duration(seconds: 6))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              firstAnimationController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              firstAnimationController.forward();
            }
          });
    // ** SECOND ANIMATION CONTROLLER .
    secondAnimationController =AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              secondAnimationController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              secondAnimationController.forward();
            }
          });
          

    //** (offsetFirstContainerAnimation).
    offsetFirstContainerAnimation = Tween<Offset>(begin: const Offset(0.4, -0.5), end: const Offset(0.3, -0.6)).animate(firstAnimationController);
    //** (offsetRowFirstContainerAnimation) .
    offsetRowFirstContainerAnimation = Tween<Offset>(begin: const Offset(0.1, 0.0), end: const Offset(0.0, 0.2)).animate(firstAnimationController);
    //** (offsetRowSecondContainerAnimation) .
    offsetRowSecondContainerAnimation = Tween<Offset>(begin: const Offset(0.2, 0.0), end: const Offset(0.0, 0.1)).animate(secondAnimationController);
    // ** (offsetThirdContainerAnimation) .
    offsetThirdContainerAnimation = Tween<Offset>(begin: const Offset(0.2, 0.0), end: const Offset(0.0, 0.2)).animate(secondAnimationController);
    // ** (offsetForthContainerAnimation) .
    offsetForthContainerAnimation = Tween<Offset>(begin: const Offset(-0.8, 0.4), end: const Offset(-0.5, 0.4)).animate(firstAnimationController);


    // ** ya wala First (AnimationController) ko start krny ka laya hm ny AnimationController ka method (forward) use kya ha .
    firstAnimationController.forward();
    // ** ya wala Second (AnimationController) ko start krny ka laya hm ny AnimationController ka method (forward) use kya ha .
    secondAnimationController.forward();
  }

  @override
  void dispose() {
    firstAnimationController.dispose();
    secondAnimationController.dispose()
;    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var heightMediaQuery = MediaQuery.of(context).size.height;
    var widthMediaQuery = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          // ** Benefit of (Alignment.center): hm jo bhi work kry ga wo center sa start ho ga 
          alignment: Alignment.center,
          children: [
            // Todo :  Animated Circle Container Boxes .
            Column(
              children: [
                SlideTransition(
                  position: offsetFirstContainerAnimation,
                  child: SizedBox(
                    height: heightMediaQuery*0.35,
                    width: widthMediaQuery*0.8,
                    child: AnimatedCircleContainer(
                      height: heightMediaQuery * 0.5,
                      width: widthMediaQuery * 0.85,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SlideTransition(
                      position: offsetRowFirstContainerAnimation,
                      child: AnimatedCircleContainer(
                          height: heightMediaQuery * 0.16,
                          width: widthMediaQuery * 0.35),
                    ),
                    SlideTransition(
                      position: offsetRowSecondContainerAnimation,
                      child: AnimatedCircleContainer(
                          height: heightMediaQuery * 0.085,
                          width: widthMediaQuery * 0.18),
                    ),
                  ],
                ),
                    // ** ya hm ny height dany ka laya use kya ha .
                    SizedBox(height: heightMediaQuery*0.050,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SlideTransition(
                            position: offsetThirdContainerAnimation,
                            child: AnimatedCircleContainer(
                                height: heightMediaQuery * 0.12,
                                width: widthMediaQuery * 0.26),
                          ),
                        ],
                      ),
                    ),   
         
                
                SlideTransition(
                  position: offsetForthContainerAnimation,
                  child: SizedBox(
                    height: heightMediaQuery*0.35,
                    width: widthMediaQuery*0.8,
                    child: AnimatedCircleContainer(
                      height: heightMediaQuery * 0.5,
                      width: widthMediaQuery * 0.85,
                    ),
                  ),
                ),
              ],
            ),
      
            
            // Todo : Upper Stack Blur TextField Layer.
            Container(
              height: heightMediaQuery*0.8,
              width: widthMediaQuery*0.8,
              color: Colors.transparent,
              child: Column(children: [
                // ** Login Text.
                    textAppName(),
                    SizedBox(height: heightMediaQuery*0.2,),
                    // ** First TextField.
                    const BlurTextField(
                      hintText: "User name",
                      hintStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w100,),
                      prefixIcon: Icon(Icons.person_pin,color: Colors.white,),
                    ),
                    // ** Second TextField.
                    SizedBox(height: heightMediaQuery*0.060,),
                    const BlurTextField(
                      hintText: "Email...",
                      hintStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w100,),
                      prefixIcon: Icon(Icons.mark_email_read,color: Colors.white,),
                    ),
                    // ** Third TextField.
                    SizedBox(height: heightMediaQuery*0.060,),
                    const BlurTextField(
                      hintText: "Password...",
                      hintStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w100,),
                      prefixIcon: Icon(Icons.password_rounded,color: Colors.white,),
                    ),
                    
                    SizedBox(height: heightMediaQuery*0.040,),
                    // ** Blur Buttons.
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      BlurButtons(
                        title: "LOGIN",
                      ),
                      BlurButtons(
                        width: 150,
                        title: "Forgotten Password",
                      )
                    ],),

                   SizedBox(height: heightMediaQuery*0.1,),
                    BlurButtons(
                    width: widthMediaQuery*0.5,
                       title: "Create Account",
                   )
              ],),
              
              )
          ],
        ),
      ),
    );
  }
}
