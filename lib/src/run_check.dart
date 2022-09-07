// import {debugEventAndSegments, debugRemovingSegment} from './debug'
import 'package:dart_sort_queue/dart_sort_queue.dart';
import 'package:sweepline_intersections/src/events.dart';
import 'package:sweepline_intersections/src/segment.dart';
import 'package:sweepline_intersections/src/utils.dart';
import 'package:turf/helpers.dart';

List<Position> runCheck(SortQueue<Event> eventQueue,
    [bool ignoreSelfIntersections = false]) {
  List<Position> intersectionPoints = <Position>[];
  SortQueue<Segment> outQueue = SortQueue<Segment>();
  while (eventQueue.isNotEmpty) {
    Event? event = eventQueue.pop();
    if (event!.isLeftEndpoint!) {
      // debugEventAndSegments(event.p, outQueue.data)
      Segment segment = Segment(event);
      for (int i = 0; i < outQueue.length; i++) {
        Segment otherSeg = outQueue.elementAt(i);

        if (ignoreSelfIntersections) {
          if (otherSeg.leftSweepEvent.featureId == event.featureId) {
            continue;
          }
        }
        Position? intersection = testSegmentIntersect(segment, otherSeg);
        if (intersection != null)  intersectionPoints.add(intersection);
      }
      outQueue.push(segment);
    } else if (event.isLeftEndpoint! == false) {
      outQueue.pop();
      // const seg = outQueue.pop()
      // debugRemovingSegment(event.p, seg)
    }
  }
  return intersectionPoints;
}
