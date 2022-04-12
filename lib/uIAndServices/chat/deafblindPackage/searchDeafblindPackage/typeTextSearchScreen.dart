import 'package:flutter/material.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/VibrateMorseText/vibrationInAction.dart';
import 'package:graduation_project/uIAndServices/chat/deafblindPackage/searchDeafblindPackage/searchScreenList.dart';
import 'package:morse/morse.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class typeTextSearchScreen extends StatelessWidget {
  static const String routName = 'typeTextSearchScreen';
  String contentSearch = '';
  vibrationInAction _vibrateInAction = new vibrationInAction();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 87, 207),
        title: Image.asset(
          'assets/images/vibra.png',
          width: 120,
          height: 120,
        ),
        centerTitle: true,
      ),
      body: SimpleGestureDetector(
        child: InkWell(
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 1, 87, 207)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(15, 15))))),
                      onPressed: () {
                        //todo
                        contentSearch += '.';
                        _vibrateInAction.vibrationTheText('.');
                        print(contentSearch);
                      },
                      child: Text(
                        'Search',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          onLongPress: () {
            contentSearch += '-';
            _vibrateInAction.vibrationTheText('-');
            print(contentSearch);
          },
          onDoubleTap: () {
            Morse morse = new Morse(contentSearch);
            var searchTextMorse = morse.decode();
            Navigator.pushNamed(context, searchScreenList.routName,
                arguments: searchTextMorse);
            _vibrateInAction.vibrateInAction();
            print(searchTextMorse);
            contentSearch = '';
          },
        ),
        onHorizontalSwipe: (SwipeDirection direction) {
          if (direction == SwipeDirection.left) {
            Navigator.pop(context);
            _vibrateInAction.vibrateInAction();
          } else if (direction == SwipeDirection.right) {
            if (contentSearch != null && contentSearch.length > 0) {
              contentSearch =
                  contentSearch.substring(0, contentSearch.length - 1);
              _vibrateInAction.vibrateInAction();
              print(contentSearch);
            }
          }
        },
        onVerticalSwipe: (SwipeDirection direction) {
          if (direction == SwipeDirection.down) {
            contentSearch += ' / ';
            _vibrateInAction.vibrateInAction();
            print(contentSearch);
          } else if (direction == SwipeDirection.up) {
            contentSearch += ' ';
            _vibrateInAction.vibrateInAction();
            print(contentSearch);
          }
        },
      ),
    );
  }
}
