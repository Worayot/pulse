import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

List<dynamic> calculateMEWS({
  required BuildContext context,
  required double heartRate,
  required double respiratoryRate,
  required double systolicBP,
  required double temperature,
  required String levelOfConsciousness, // Use localized string here
  required double oxygenSaturation,
  required double urineOutput,
}) {
  int score = 0;
  List<dynamic> mews_component = [0, 0, 0, 0, 0, 0, 0, score];

  // Localized level of consciousness values
  String localizedU = S.of(context)!.unresponsive;
  String localizedP = S.of(context)!.pain;
  String localizedA = S.of(context)!.alert;
  String localizedC = S.of(context)!.conscious;
  String localizedV = S.of(context)!.verbalStimuli;

  // Create a Map to relate localized values to scores
  Map<String, int> consciousnessScoreMap = {
    localizedU: 3,
    localizedP: 2,
    localizedV: 1,
    localizedA: 2,
    localizedC: 0,
  };

  // Heart Rate Scoring
  if (heartRate > 130) {
    score += 3;
    mews_component[0] = 3;
  } else if (heartRate < 40 || (heartRate >= 111 && heartRate <= 130)) {
    score += 2;
    mews_component[0] = 2;
  } else if ((heartRate >= 40 && heartRate <= 50) ||
      (heartRate >= 101 && heartRate <= 110)) {
    score += 1;
    mews_component[0] = 1;
  }

  // Respiratory Rate Scoring
  if (respiratoryRate < 8 || respiratoryRate > 30) {
    score += 3;
    mews_component[1] = 3;
  } else if (respiratoryRate >= 21 && respiratoryRate <= 30) {
    score += 1;
    mews_component[1] = 1;
  }

  // Systolic Blood Pressure Scoring
  if (systolicBP < 70 || systolicBP > 220) {
    score += 3;
    mews_component[2] = 3;
  } else if ((systolicBP >= 71 && systolicBP <= 80) ||
      (systolicBP >= 201 && systolicBP <= 220)) {
    score += 2;
    mews_component[2] = 2;
  } else if ((systolicBP >= 81 && systolicBP <= 100) ||
      (systolicBP >= 181 && systolicBP <= 200)) {
    score += 1;
    mews_component[2] = 1;
  }

  // Temperature Scoring
  if (temperature < 34 || temperature > 40) {
    score += 3;
    mews_component[3] = 3;
  } else if ((temperature >= 34 && temperature <= 35) ||
      (temperature >= 38.6 && temperature <= 40)) {
    score += 2;
    mews_component[3] = 2;
  } else if (temperature >= 35.1 && temperature <= 37.5) {
    score += 0;
    mews_component[3] = 0;
  } else if (temperature >= 37.6 && temperature <= 38.5) {
    score += 1;
    mews_component[3] = 2;
  }

  // Level of Consciousness (AVPU) Scoring
  int consciousnessScore = consciousnessScoreMap[levelOfConsciousness] ?? 0;
  score += consciousnessScore;
  mews_component[4] = consciousnessScore;

  // Oxygen Saturation Scoring
  if (oxygenSaturation <= 90) {
    score += 3;
    mews_component[5] = 3;
  } else if (oxygenSaturation >= 91 && oxygenSaturation <= 93) {
    score += 2;
    mews_component[5] = 2;
  }

  // Urine Output Scoring
  if (urineOutput < 30) {
    score += 3;
    mews_component[6] = 3;
  }

  mews_component[7] = score;

  return mews_component;
}
