import 'package:hive/hive.dart';
part 'record.g.dart';

@HiveType(typeId: 1)
class Record {
  Record({required this.tutorialLearned});
  @HiveField(0)
  bool tutorialLearned;
  @HiveField(1)
  double smallPressureThreshold = 0.3;
  @HiveField(2)
  double bigPressureThreshold = 1.0;
}
