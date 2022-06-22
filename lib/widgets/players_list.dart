import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PlayersList extends StatelessWidget {
  final double countdownRadius;
  final bool showCountDown;
  final Function onPlayPressed;

  const PlayersList(
      {Key? key,
        required this.countdownRadius,
        required this.onPlayPressed,
        required this.showCountDown})
      : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Stack(
      children: [
        Positioned(
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Text(
                  'Liste des joueurs',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                for (int i = 0; i < 7; i++)
                  Card(
                    color: Colors.white,
                    elevation: 6,
                    margin: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        title: Text(
                          'Bot n°$i',
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                        trailing: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        !showCountDown
            ? Container()
            : Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: countdownRadius * 1.3,
              backgroundColor: Colors.blue,
              child: CircleAvatar(
                radius: countdownRadius * 1.2,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: countdownRadius * 1.1,
                  backgroundColor: Colors.blue,
                  child: CircleAvatar(
                    child: Lottie.asset(
                      'assets/lotties/countdown-3.json',
                      fit: BoxFit.fill,
                    ),
                    backgroundColor: Colors.white,
                    radius: countdownRadius,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          child: Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () => onPlayPressed(),
              child: Lottie.asset(
                'assets/lotties/play-button.json',
                width: 150,
                height: 150,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}