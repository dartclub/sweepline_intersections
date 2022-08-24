class Segment {
  final leftSweepEvent;
  final rightSweepEvent;
  Segment(event)
      : leftSweepEvent = event,
        rightSweepEvent = event.otherEvent;
}
