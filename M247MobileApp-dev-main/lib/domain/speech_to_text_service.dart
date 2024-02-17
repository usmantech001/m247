import 'package:speech_to_text/speech_to_text.dart';

class SpeechTTService {
  SpeechTTService._() {
    initialize();
  }

  static SpeechTTService? _instance;

  static SpeechToText? _speechToText;

  static SpeechTTService get instance => _instance ?? SpeechTTService._();

  static Future<void> initialize() async {
    _speechToText ??= SpeechToText();
  }

  Future<void> stop() async {
    final isListen = _speechToText!.isListening;
    if (isListen) {
      await _speechToText!.stop();
    }
  }

  Future<void> listen(Function(String result) onListen) async {
    final isEnabled = _speechToText!.isAvailable;
    if (isEnabled) {
      await _speechToText!.listen(onResult: (result) {
        onListen(result.recognizedWords);
      });
    }
  }
}
