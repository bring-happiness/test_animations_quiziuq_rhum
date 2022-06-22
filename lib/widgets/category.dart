import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../core/viewmodels/home_model.dart';
import '../ui/shared/globals.dart';
import 'animated_circle.dart';

class Category extends StatelessWidget {
  final AnimationController categoryController;
  final AnimationController animationController;
  final Animation<double> startAnimation;

  const Category(
      {Key? key,
      required this.categoryController,
      required this.animationController,
      required this.startAnimation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeModel>(context, listen: false);

    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Column(
            children: [
              SafeArea(
                child: AnimatedCircle(
                  animation: startAnimation,
                  color: model.foreGroundColor,
                  flip: 1.0,
                  tween: Tween<double>(begin: 1.0, end: Global.radius),
                  isAnimating: animationController.isAnimating,
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 60,
                ),
              ),
            ],
          ),
        ),
        animationController.isAnimating && !model.isHalfWay
            ? Container()
            : SafeArea(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset(
                        'assets/lotties/geography.json',
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.width * 0.85,
                        fit: BoxFit.fill,
                        controller: categoryController,
                        onLoaded: (composition) {
                          // Configure the AnimationController with the duration of the
                          // Lottie file and start the animation.
                          categoryController
                            ..duration = Duration(
                                milliseconds:
                                    (composition.duration.inMilliseconds / 2)
                                        .round())
                            ..forward(from: Random().nextInt(6) / 10);
                        },
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        'Géographie',
                        style: TextStyle(fontSize: 50, color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              )
      ],
    );
  }
}
