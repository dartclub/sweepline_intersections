import 'package:sweepline_intersections/src/events.dart';

class Segment {
  final Event leftSweepEvent;
  final Event rightSweepEvent;
  Segment(Event event)
      : leftSweepEvent = event,
        rightSweepEvent = event.otherEvent!;
}
