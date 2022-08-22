enum Status {
  beforeSleep,
  sleeping,
  awake
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

const maxMilliSeconds = 3000;
const tutorialMaxMilliseconds = 3000;

const smallPressureThreshold = 0.5;
const bigPressureThreshold = 0.8;
const awakePressureThreshold = 0.1;

