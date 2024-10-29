import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String getLocalizedConsciousValue(BuildContext context, String value) {
  if (value == "Conscious") {
    return S.of(context)!.conscious;
  } else if (value == "Alert") {
    return S.of(context)!.alert;
  } else if (value == "Verbal Stimuli") {
    return S.of(context)!.verbalStimuli;
  } else if (value == "Pain") {
    return S.of(context)!.pain;
  } else if (value == "Unresponsive") {
    return S.of(context)!.unresponsive;
  }
  return value;
}

String formatBloodPressure(int? systolicBP, int? diastolicBP) {
  String sBp = '';
  String dBp = '';

  if (systolicBP == null) {
    sBp = '-';
  } else {
    systolicBP == 0 ? '0' : systolicBP.toString();
    sBp = systolicBP.toString();
  }

  if (diastolicBP == null) {
    dBp = '-';
  } else {
    diastolicBP == 0 ? '0' : diastolicBP.toString();
    dBp = diastolicBP.toString();
  }
  return '$sBp/$dBp';
}

String getEnglishConsciousValue(BuildContext context, String localizedValue) {
  print('');
  if (localizedValue == S.of(context)!.conscious) {
    return "Conscious";
  } else if (localizedValue == S.of(context)!.alert) {
    return "Alert";
  } else if (localizedValue == S.of(context)!.verbalStimuli) {
    return "Verbal Stimuli";
  } else if (localizedValue == S.of(context)!.pain) {
    return "Pain";
  } else if (localizedValue == S.of(context)!.unresponsive) {
    return "Unresponsive";
  }
  return localizedValue;
}
