import 'package:sweepline_intersections/src/events.dart';

class Segment implements Comparable<Segment> {
  final Event leftSweepEvent;
  final Event? rightSweepEvent;
  Segment(Event event)
      : leftSweepEvent = event,
        rightSweepEvent = event.otherEvent;

  @override
  int compareTo(Segment other) {
    if (rightSweepEvent!.position.lng > other.rightSweepEvent!.position.lng) {
      return 1;
    }
    if (rightSweepEvent!.position.lng < other.rightSweepEvent!.position.lng) {
      return -1;
    }

    if (rightSweepEvent!.position.lat != other.rightSweepEvent!.position.lat) {
      return rightSweepEvent!.position.lat < other.rightSweepEvent!.position.lat
          ? 1
          : -1;
    }
    return 1;
  }
}
