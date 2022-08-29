import 'package:sweepline_intersections/src/events.dart';
import 'package:sweepline_intersections/src/segment.dart';

int checkWhichEventIsLeft(Event e1, Event e2) {
  if (e1.position.lng > e2.position.lng) return 1;
  if (e1.position.lng < e2.position.lng) return -1;

  if (e1.position.lat != e2.position.lat) {
    return e1.position.lat > e2.position.lat ? 1 : -1;
  }
  return 1;
}

int checkWhichSegmentHasRightEndpointFirst(Segment seg1, Segment seg2) {
  if (seg1.rightSweepEvent!.position.lng > seg2.rightSweepEvent!.position.lng) {
    return 1;
  }
  if (seg1.rightSweepEvent!.position.lng < seg2.rightSweepEvent!.position.lng) {
    return -1;
  }

  if (seg1.rightSweepEvent!.position.lat !=
      seg2.rightSweepEvent!.position.lat) {
    return seg1.rightSweepEvent!.position.lat <
            seg2.rightSweepEvent!.position.lat
        ? 1
        : -1;
  }
  return 1;
}
