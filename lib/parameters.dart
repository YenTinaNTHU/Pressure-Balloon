enum Status {
  tutorial,
  beforeSleep,
  sleeping,
  awake,
  ending
}

enum Pressure {
  small,
  medium,
  big,
}

enum TutorialStatus {
  intro,
  init,
  setSmallPressureThreshold,
  setBigPressureThreshold,
  finishSetting
}

List<String> moods = [
  'Very Anxious',
  'Anxious',
  'Normal',
  'Creative',
  'Very Creative'
];

const maxMilliSeconds = 3000;
const tutorialMaxMilliseconds = 5000;

double smallPressureThreshold = 0.5;
double bigPressureThreshold = 0.8;
const awakePressureThreshold = 0.1;
