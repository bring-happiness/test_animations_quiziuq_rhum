import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/viewmodels/home_model.dart';
import '../ui/shared/globals.dart';
import 'animated_circle.dart';

class ObserverPage extends StatelessWidget {
  final AnimationController animationController;
  final Animation<double> startAnimation;
  final bool reverseAnimation;

  const ObserverPage(
      {Key? key,
      required this.animationController,
      required this.startAnimation,
      required this.reverseAnimation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeModel>(context, listen: false);

    return Stack(children: [
      if (!reverseAnimation)
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
        child: const Center(
          child: Text(
            'Tu es en mode observateur',
          ),
        ),
      ),
    ]);
  }
}
