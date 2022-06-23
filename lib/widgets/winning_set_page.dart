import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../core/viewmodels/home_model.dart';
import '../ui/shared/globals.dart';
import 'animated_circle.dart';

class WinningSetPage extends StatelessWidget {
  final AnimationController animationController;
  final Animation<double> startAnimation;

  const WinningSetPage(
      {Key? key,
      required this.animationController,
      required this.startAnimation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeModel>(context, listen: false);

    return SafeArea(
      child: Stack(
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
          if (animationController.isAnimating && !model.isHalfWay)
            Container()
          else
            SafeArea(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(
                      'assets/lotties/trophy.json',
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.width * 0.6,
                      fit: BoxFit.fill,
                      repeat: false,
                    ),
                    Text(
                      'Bonne réponse champion ! Attends les autres...',
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
