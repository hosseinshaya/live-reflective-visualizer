import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mic_stream/mic_stream.dart';

class VisualizerProvider extends ChangeNotifier {
  VisualizerProvider() {
    init();
  }

  Future<void> init() async {
    Stream<Uint8List>? stream = await MicStream.microphone(sampleRate: 44100);
    stream!.listen((Uint8List samples) {
      volume = samples.last.toDouble();
      notifyListeners();
    });
  }

  double? volume;
}
