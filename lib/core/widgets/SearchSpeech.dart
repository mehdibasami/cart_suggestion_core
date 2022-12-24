import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SearchSpeech extends StatefulWidget {
  SearchSpeech({this.speechTextCallBack, this.speechButtonCallBack});

  final Function(String speechText)? speechTextCallBack;
  final Function()? speechButtonCallBack;

  @override
  _SearchSpeechState createState() => _SearchSpeechState();
}

class _SearchSpeechState extends State<SearchSpeech> {
  bool _hasSpeech = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = "";
  String lastError = "";
  String lastStatus = "";
  String _currentLocaleId = "fa_IR";
  final SpeechToText speech = SpeechToText();

  ////choosing default language
  Future language() async {
    speech.listen(
      onResult: resultListener,
      localeId: ("fa"),
    );
  }

  ////initializing every needed var to start listening
  @override
  void initState() {
    initSpeechState();
    super.initState();
  }

  Future<void> initSpeechState() async {
    bool hasSpeech = await speech.initialize(
        onError: errorListener, onStatus: statusListener);
    if (hasSpeech) {
      _currentLocaleId = "fa-IR";
    }

    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  //////starts listening when button pressed and the time for it depends on taping or long pressing the button
  void startListeningTap(int time) {
    lastWords = "";
    lastError = "";
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: time),
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
    setState(() {});
  }

  /////would be triggered if stop button pressed
  void stopListening() {
    speech.stop();
    setState(() {
      level = 0.0;
    });
    widget.speechTextCallBack!(speechController.text);
  }

  void cancelListening() {
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  ////would take words from api and put it on a string and will save status for showing changes in button
  void resultListener(SpeechRecognitionResult result) {
    setState(() {
      speechController.text = "${result.recognizedWords}";
    });
    widget.speechTextCallBack!(speechController.text);
  }

  void statusListener(String status) {
    setState(() {
      lastStatus = "$status";
    });
  }

  void errorListener(SpeechRecognitionError error) {
    setState(() {
      lastError = "${error.errorMsg} - ${error.permanent}";
    });
  }

  ////to change sound
  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    setState(() {
      this.level = level;
    });
  }

  TextEditingController speechController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // ignore: unnecessary_statements
        !_hasSpeech || speech.isListening ? null : startListeningTap(10);
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 16,
        height: 30,
        child: Icon(
          Icons.mic,
          color: speech.isListening ? Color(0xff0481FF) : Color(0xff808080),
          size: 22,
        ),
      ),
    );
  }
}
