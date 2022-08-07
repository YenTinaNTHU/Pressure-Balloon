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

const maxMilliSeconds = 3000;

const smallPressureThreshold = 0.3;
const bigPressureThreshold = 0.6;
const awakePressureThreshold = 0.1;

