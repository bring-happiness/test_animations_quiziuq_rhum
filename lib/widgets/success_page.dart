import 'package:coast/coast.dart';
import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Text(
            'Bonne réponse champion, attends les autres...',
          ),
          Positioned(
            child: Align(
              alignment: Alignment.topCenter,
              child: Crab(
                tag: 'successAnswer',
                child: ElevatedButton(
                  child: Container(
                    child: Center(
                      child: Text(
                        '99',
                      ),
                    ),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 50,
                  ),
                  onPressed: null,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    foregroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}