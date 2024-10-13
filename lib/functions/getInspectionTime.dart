import 'package:Pulse/services/mews_service.dart';

Future<DateTime> getInspectionTime(String patientID, int MEWs) async {
  if (MEWs <= 1) {
    return DateTime.now().add(Duration(hours: 8));
  } else if (MEWs > 1 && MEWs <= 2) {
    return DateTime.now().add(Duration(hours: 4));
  } else if (MEWs > 2 && MEWs <= 3) {
    List<double> latestColors = await MewsService.getLatestColors(patientID);
    // print(latestColors);
    if (isStreak(latestColors)) {
      return DateTime.now().add(Duration(hours: 1));
    } else {
      return DateTime.now().add(Duration(hours: 2));
    }
  } else if (MEWs > 3 && MEWs <= 4) {
    List<double> latestColors = await MewsService.getLatestColors(patientID);
    // print(latestColors);
    if (isStreak(latestColors)) {
      return DateTime.now().add(Duration(minutes: 30));
    } else {
      return DateTime.now().add(Duration(hours: 1));
    }
  } else {
    List<double> latestColors = await MewsService.getLatestColors(patientID);
    // print(latestColors);
    if (isStreak(latestColors)) {
      return DateTime.now().add(Duration(minutes: 15));
    } else {
      return DateTime.now().add(Duration(minutes: 30));
    }
  }
}

bool isStreak(List<double> mews_list) {
  if (mews_list.every((element) => element >= 5) && mews_list.length == 3) {
    return true;
  } else if (mews_list.every((element) => element == mews_list[0]) &&
      mews_list.length == 3) {
    return true;
  } else {
    return false;
  }
}
