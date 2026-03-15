import 'package:flutter/material.dart';

class PinViewModel extends ChangeNotifier {
  final List<TextEditingController> pinControllers =
  List.generate(4, (_) => TextEditingController());
  final List<FocusNode> pinFocusNodes =
  List.generate(4, (_) => FocusNode());

  void onPinChanged(int index, String value) {
    if (value.isNotEmpty && index < pinControllers.length - 1) {
      pinFocusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      pinFocusNodes[index - 1].requestFocus();
    }
  }

  void onKeyPressed(String key) {
    if (key == '⌫') {
      for (var i = pinControllers.length - 1; i >= 0; i--) {
        if (pinControllers[i].text.isNotEmpty) {
          pinControllers[i].clear();
          pinFocusNodes[i].requestFocus();
          break;
        }
      }
    } else if (RegExp(r'^[0-9]$').hasMatch(key)) {
      for (var i = 0; i < pinControllers.length; i++) {
        if (pinControllers[i].text.isEmpty) {
          pinControllers[i].text = key;
          if (i < pinControllers.length - 1) {
            pinFocusNodes[i + 1].requestFocus();
          }
          break;
        }
      }
    }
    notifyListeners();
  }

  void resetPin() {
    for (var c in pinControllers) {
      c.clear();
    }
    pinFocusNodes.first.requestFocus();
    notifyListeners();
  }

  void onContinue() {
    final pin = pinControllers.map((c) => c.text).join();
    debugPrint('PIN entered: $pin');
    // TODO: Verify or navigate
  }

  @override
  void dispose() {
    for (var c in pinControllers) {
      c.dispose();
    }
    for (var f in pinFocusNodes) {
      f.dispose();
    }
    super.dispose();
  }
}
