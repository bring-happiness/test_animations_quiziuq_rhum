import 'package:coast/coast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/viewmodels/home_model.dart';
import '../ui/shared/globals.dart';
import 'animated_circle.dart';

class QuestionScreen extends StatelessWidget {
  final AnimationController animationController;
  final Animation<double> startAnimation;
  final Function onSuccessAnswer;
  final Function onErrorAnswer;

  const QuestionScreen(
      {Key? key,
        required this.animationController,
        required this.startAnimation,
        required this.onSuccessAnswer,
        required this.onErrorAnswer})
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
        /*Positioned(
          top: 0,
          left: 0,
          child: Crab(
            tag: 'test',
            child: GestureDetector(
              onTap: () => onSuccessAnswer(),
              child: Container(width: 100, height: 100, color: Colors.green),
            ),
          ),
        ),*/
        if (animationController.isAnimating && !model.isHalfWay)
          Container()
        else
          SafeArea(
            child: Center(
              child: Column(
                children: [
                  Text(animationController.isDismissed.toString()),
                  Spacer(),
                  Text(
                    'Quel âge a le père fouras ?',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  Spacer(),
                  Column(
                    children: [
                      ElevatedButton(
                        child: Container(
                          child: Center(
                            child: Text(
                              '78',
                            ),
                          ),
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.8,
                          height: 50,
                        ),
                        onPressed: () => onErrorAnswer(),
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.white),
                          foregroundColor:
                          MaterialStateProperty.all(Colors.blue),
                        ),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Crab(
                        tag: 'successAnswer',
                        child: ElevatedButton(
                          child: Container(
                            child: Center(
                              child: Text(
                                '99',
                              ),
                            ),
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.8,
                            height: 50,
                          ),
                          onPressed: () => onSuccessAnswer(),
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                            foregroundColor:
                            MaterialStateProperty.all(Colors.blue),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      ElevatedButton(
                        child: Container(
                          child: Center(
                            child: Text(
                              '13',
                            ),
                          ),
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.8,
                          height: 50,
                        ),
                        onPressed: () => onErrorAnswer(),
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.white),
                          foregroundColor:
                          MaterialStateProperty.all(Colors.blue),
                        ),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      ElevatedButton(
                        child: Container(
                          child: Center(
                            child: Text(
                              '45',
                            ),
                          ),
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.8,
                          height: 50,
                        ),
                        onPressed: () => onErrorAnswer(),
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.white),
                          foregroundColor:
                          MaterialStateProperty.all(Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
      ],
    );
  }
}