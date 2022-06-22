import 'dart:math';

import 'package:coast/coast.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:test_animations_quiziuq_rhum/core/viewmodels/home_model.dart';
import 'package:test_animations_quiziuq_rhum/ui/shared/globals.dart';
import 'package:provider/provider.dart';

import '../../core/viewmodels/home_model.dart';
import '../../widgets/animated_circle.dart';
import '../../widgets/category.dart';
import '../../widgets/error_page.dart';
import '../../widgets/observer_page.dart';
import '../../widgets/players_list.dart';
import '../../widgets/question_screen.dart';
import '../../widgets/success_page.dart';
import '../shared/globals.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> startAnimation;
  late Animation<double> endAnimation;
  late Animation<double> horizontalAnimation;
  double multiplier = 1;
  bool reverseAnimation = false;

  //late PageController pageController;
  final coastController = CoastController(initialPage: 0);

  bool showSuccessPage = true;

  // LIST PLAYERS PAGE
  bool showListPlayersCountdown = false;

  // CATEGORY PAGE
  late AnimationController categoryController;



  @override
  void initState() {
    super.initState();

    //pageController = PageController();
    animationController = AnimationController(
        duration: Duration(milliseconds: (750 * multiplier).round()), vsync: this);

    startAnimation = CurvedAnimation(
      parent: animationController,
      curve: Interval(0.000, 0.500 * multiplier, curve: Curves.easeInExpo),
    );

    endAnimation = CurvedAnimation(
      parent: animationController,
      curve: Interval(0.500 * multiplier, 1.000 * multiplier, curve: Curves.easeOutExpo),
    );

    horizontalAnimation = CurvedAnimation(
      parent: animationController,
      curve: Interval(0.750 * multiplier, 1.000 * multiplier, curve: Curves.easeInOutQuad),
    );

    animationController
      ..addStatusListener((status) async {
        final model = Provider.of<HomeModel>(context, listen: false);
        if (status == AnimationStatus.completed) {
          model.swapColors();
          animationController.reset();
          setState(() {
            //reverseAnimation = false;
          });
          model.isCompleted = true;
        } else {
          model.isCompleted = false;
        }
      })
      ..addListener(() {
        final model = Provider.of<HomeModel>(context, listen: false);
        if (animationController.value > 0.55) {
          model.isHalfWay = true;
        } else {
          model.isHalfWay = false;
        }
      });

    categoryController = AnimationController(vsync: this);
  }

  void simulateCategoryPage() async {
    setState(() {
      showListPlayersCountdown = true;
    });

    await Future.delayed(const Duration(seconds: 3)).then((_) {
      final model = Provider.of<HomeModel>(context, listen: false);
      model.status = HomeModelStatus.category;
      coastController.animateTo(
          beach: 1,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutQuad);
      animationController.forward();
    });

    setState(() {
      showListPlayersCountdown = false;
    });

    await Future.delayed(const Duration(seconds: 3)).then((_) {
      final model = Provider.of<HomeModel>(context, listen: false);
      model.status = HomeModelStatus.question;
      coastController.animateTo(
          beach: 2,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutQuad);
      animationController.forward();
    });

    /*await Future.delayed(const Duration(seconds: 3)).then((_) {
      final model = Provider.of<HomeModel>(context, listen: false);
      model.status = HomeModelStatus.success;
      pageController.animateToPage(3,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutQuad);
      animationController.forward();
    });*/
  }

  @override
  void dispose() {
    animationController.dispose();
    categoryController.dispose();
    coastController.dispose();
    super.dispose();
  }

  void onSuccessAnswer() async {
    final model = Provider.of<HomeModel>(context, listen: false);
    model.status = HomeModelStatus.success;
    coastController.animateTo(
        beach: 3,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutQuad);
    animationController.forward();

    await Future.delayed(const Duration(seconds: 3)).then((_) {
      leaveSuccessPage();
    });
  }

  onErrorAnswer() async {
    setState(() {
      showSuccessPage = false;
    });

    final model = Provider.of<HomeModel>(context, listen: false);
    model.status = HomeModelStatus.error;
    coastController.animateTo(
        beach: 3,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutQuad);
    animationController.forward();

    await Future.delayed(const Duration(seconds: 3)).then((_) {
      goToObserverPage();
    });
  }

  leaveSuccessPage() async {
    final model = Provider.of<HomeModel>(context, listen: false);
    setState(() {
      reverseAnimation = true;
    });
    model.status = HomeModelStatus.category;
    coastController.animateTo(
        beach: 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutQuad);
    animationController.forward();

    setState(() {
      reverseAnimation = false;
    });

    await Future.delayed(const Duration(seconds: 3)).then((_) {
      final model = Provider.of<HomeModel>(context, listen: false);
      model.status = HomeModelStatus.question;
      coastController.animateTo(
          beach: 2,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutQuad);
      animationController.forward();
    });
  }

  goToObserverPage() {
    final model = Provider.of<HomeModel>(context, listen: false);
    model.status = HomeModelStatus.observer;
    coastController.animateTo(
        beach: 4,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutQuad);
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeModel>(context, listen: true);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor:
          model.isHalfWay ? model.foreGroundColor : model.backGroundColor,
      body: Coast(
        physics: const NeverScrollableScrollPhysics(),
        controller: coastController,
        reverse: reverseAnimation,
        beaches: [
          Beach(
            builder: (context) => PlayersList(
              countdownRadius: screenWidth * 0.2,
              onPlayPressed: () => simulateCategoryPage(),
              showCountDown: showListPlayersCountdown,
            ),
          ),
          Beach(
            builder: (context) => Category(
              animationController: animationController,
              categoryController: categoryController,
              startAnimation: startAnimation,
            ),
          ),
          Beach(
            builder: (context) => QuestionScreen(
              animationController: animationController,
              startAnimation: startAnimation,
              onSuccessAnswer: () => onSuccessAnswer(),
              onErrorAnswer: () => onErrorAnswer(),
            ),
          ),
          if (showSuccessPage)
          Beach(
            builder: (context) => SuccessPage(),
          ),
          Beach(
            builder: (context) => ErrorPage(
              startAnimation: startAnimation,
              animationController: animationController,
            ),
          ),
          Beach(
            builder: (context) => ObserverPage(),
          ),
        ],
        //observers: [CrabController()],
      ),
    );
  }
}
