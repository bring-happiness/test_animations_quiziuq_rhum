import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/viewmodels/home_model.dart';
import '../ui/shared/globals.dart';

class AnimatedCircle extends AnimatedWidget {
  final Tween<dynamic> tween;
  final Tween<dynamic>? horizontalTween;
  final Animation<double> animation;
  final Animation<double>? horizontalAnimation;
  final double flip;
  final Color color;
  final bool isAnimating;
  final Widget? child;
  final double width;
  final double height;

  const AnimatedCircle({
    Key? key,
    required this.animation,
    this.horizontalTween,
    this.horizontalAnimation,
    required this.color,
    required this.flip,
    required this.tween,
    required this.isAnimating,
    this.child,
    this.width = Global.radius,
    this.height = Global.radius,
  })  : assert(flip == 1 || flip == -1),
        super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeModel>(context, listen: true);
    return Stack(children: [
      Transform(
        alignment: FractionalOffset.centerLeft,
        transform: Matrix4.identity()
          ..scale(
            tween.evaluate(animation) * flip,
            tween.evaluate(animation),
          ),
        child: Transform(
          transform: Matrix4.identity()
            ..translate(
              horizontalTween != null
                  ? horizontalTween!.evaluate(horizontalAnimation!)
                  : 0.0,
            ),
          child: model.isCompleted
              ? Container()
              : Container(
                  //width: width,
                  width: 100,
                  //height: height,
                  height: 100,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(
                      height / 2.0 - tween.evaluate(animation) / (height / 2.0),
                    ),
                  ),
                  child: Icon(
                    flip == 1
                        ? Icons.keyboard_arrow_right
                        : Icons.keyboard_arrow_left,
                    color: isAnimating
                        ? model.foreGroundColor
                        : model.backGroundColor,
                  ),
                ),
        ),
      ),
    ]);
  }
}
