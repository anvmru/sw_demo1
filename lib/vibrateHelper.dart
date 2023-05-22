import 'package:vibration/vibration.dart';

class VibrateHelper {
  static Future<void> vibrateOne() async {
    if (await Vibration.hasVibrator() ?? false) {
      if (await Vibration.hasCustomVibrationsSupport() ?? false) {
        await Vibration.vibrate(duration: 200);
      } else {
        await Vibration.vibrate();
        await Future.delayed(Duration(milliseconds: 200));
        await Vibration.vibrate();
      }
      //await Vibration.vibrate();
    }
  }

  static Future<void> vibrateTwo() async {
    if (await Vibration.hasVibrator() ?? false) {
      // With pattern (wait 0ms, vibrate 200ms, wait 200ms, vibrate 200s):
      await Vibration.vibrate(pattern: [0, 200, 200, 200]);
    }
  }
}
