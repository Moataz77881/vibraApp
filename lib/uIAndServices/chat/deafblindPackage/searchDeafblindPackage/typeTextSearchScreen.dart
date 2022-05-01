import 'package:flutter/material.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/VibrateMorseText/vibrationInAction.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/searchDeafblindPackage/searchScreenList.dart';
import 'package:morse/morse.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class typeTextSearchScreen extends StatelessWidget {
  static const String routName = 'typeTextSearchScreen';
  String contentSearch = '';
  final vibrationInAction _vibrateInAction = vibrationInAction();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 87, 207),
        title: Image.asset(
          'assets/images/vibra.png',
          width: 120,
          height: 120,
        ),
        centerTitle: true,
      ),
      body: SimpleGestureDetector(
        child: InkWell(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 1, 87, 207)),
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.elliptical(15, 15))))),
                    child: const Text(
                      'Search',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      //todo
                      contentSearch += '.';
                      _vibrateInAction.vibrationTheText('.');
                    },
                  ),
                ),
              )
            ],
          ),
          onLongPress: () {
            contentSearch += '-';
            _vibrateInAction.vibrationTheText('-');
          },
          onDoubleTap: () {
            Morse morse = Morse(contentSearch);
            var searchTextMorse = morse.decode();
            Navigator.pushNamed(context, searchScreenList.routName,
                arguments: searchTextMorse);
            _vibrateInAction.vibrateInAction();
            contentSearch = '';
          },
        ),
        onHorizontalSwipe: (SwipeDirection direction) {
          if (direction == SwipeDirection.left) {
            Navigator.pop(context);
            _vibrateInAction.vibrateInAction();
          } else if (direction == SwipeDirection.right) {
            if (contentSearch.isNotEmpty) {
              contentSearch =
                  contentSearch.substring(0, contentSearch.length - 1);
              _vibrateInAction.vibrateInAction();
            }
          }
        },
        onVerticalSwipe: (SwipeDirection direction) {
          if (direction == SwipeDirection.down) {
            contentSearch += ' / ';
            _vibrateInAction.vibrateInAction();
          } else if (direction == SwipeDirection.up) {
            contentSearch += ' ';
            _vibrateInAction.vibrateInAction();
          }
        },
      ),
    );
  }
}
