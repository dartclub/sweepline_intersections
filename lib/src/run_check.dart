// import {debugEventAndSegments, debugRemovingSegment} from './debug'

import 'package:dart_tiny_queue/dart_tiny_queue.dart';
import 'package:sweepline_intersections/src/compare_events.dart';
import 'package:sweepline_intersections/src/events.dart';
import 'package:sweepline_intersections/src/segment.dart';
import 'package:sweepline_intersections/src/utils.dart';
import 'package:turf/helpers.dart';

List<Point> runCheck(TinyQueue eventQueue, bool ignoreSelfIntersections) {
  var intersectionPoints = <Point>[];
  var outQueue =
      TinyQueue(data: [], compare: checkWhichSegmentHasRightEndpointFirst);

  while (eventQueue.data!.isNotEmpty) {
    Event event = eventQueue.data!.removeLast();
    if (event.isLeftEndpoint == true) {
      // debugEventAndSegments(event.p, outQueue.data)
      var segment = Segment(event);
      for (var i = 0; i < outQueue.data!.length; i++) {
        var otherSeg = outQueue.data![i];
        if (ignoreSelfIntersections) {
          if (otherSeg.leftSweepEvent.featureId == event.featureId) {
            continue;
          }
        }
        var intersection = testSegmentIntersect(segment, otherSeg);
        if (intersection != null) {
          intersectionPoints.add(intersection);
        }
      }
      outQueue.push(segment);
    } else if (event.isLeftEndpoint == false) {
      outQueue.pop();
      // const seg = outQueue.pop()
      // debugRemovingSegment(event.p, seg)
    }
  }
  return intersectionPoints;
}
