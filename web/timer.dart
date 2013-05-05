import 'package:web_ui/web_ui.dart';
import 'dart:async';
import 'dart:html';

class TimerComponent extends WebComponent {
  @observable
  int workMinutes = 90;
  @observable
  int restMinutes = 15;
  @observable
  int workRemainMinutes;
  @observable
  int restRemainMinutes;
  @observable
  String workRemainMinutesVisibility = 'hidden';
  @observable
  String restRemainMinutesVisibility = 'hidden';


  String get workMinutesString => workMinutes.toString();
  set workMinutesString(value) {
    try {
      workMinutes = int.parse(value);
    } on Exception catch(e) {
      workMinutes = 0;
    }
  }

  String get restMinutesString => restMinutes.toString();
  set restMinutesString(value) {
    try {
      restMinutes = int.parse(value);
    } on Exception catch(e) {
      restMinutes = 0;
    }
  }


  void startWorkTimer() {
    workRemainMinutes = workMinutes;
    workRemainMinutesVisibility = 'visible';
    restRemainMinutesVisibility = 'hidden';

    new Timer.periodic(const Duration(minutes: 1), (timer) {
      workRemainMinutes -= 1;
      if (workRemainMinutes <= 0) {
        window.alert('finish!');
        timer.cancel();
        startRestTimer();
      }
    });
  }

  void startRestTimer() {
    restRemainMinutes = restMinutes;
    workRemainMinutesVisibility = 'hidden';
    restRemainMinutesVisibility = 'visible';

    new Timer.periodic(const Duration(minutes: 1), (timer) {
      restRemainMinutes -= 1;
      if (restRemainMinutes <= 0) {
        window.alert('rest finish!');
        timer.cancel();
        startWorkTimer();
      }
    });
  }
}
