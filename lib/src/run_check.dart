// import {debugEventAndSegments, debugRemovingSegment} from './debug'

import 'package:sweepline_intersections/src/compare_events.dart';
import 'package:sweepline_intersections/src/segment.dart';
import 'package:sweepline_intersections/src/utils.dart';

runCheck(eventQueue, ignoreSelfIntersections) {
  ignoreSelfIntersections =
      ignoreSelfIntersections ? ignoreSelfIntersections : false;

  const intersectionPoints = [];
  const outQueue = TinyQueue([], checkWhichSegmentHasRightEndpointFirst);

  while (eventQueue.length) {
    const event = eventQueue.pop();
    if (event.isLeftEndpoint) {
      // debugEventAndSegments(event.p, outQueue.data)
      var segment = Segment(event);
      for (var i = 0; i < outQueue.data.length; i++) {
        var otherSeg = outQueue.data[i];
        if (ignoreSelfIntersections) {
          if (otherSeg.leftSweepEvent.featureId == event.featureId) {
            continue;
          }
        }
        const intersection = testSegmentIntersect(segment, otherSeg);
        if (intersection != false) intersectionPoints.add(intersection);
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
