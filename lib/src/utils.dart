import 'package:sweepline_intersections/src/segment.dart';
import 'package:turf/helpers.dart';

Position? testSegmentIntersect(Segment seg1, Segment seg2) {
  if (seg1.leftSweepEvent.ringId == seg2.leftSweepEvent.ringId &&
      (seg1.rightSweepEvent?.isSamePoint(seg2.rightSweepEvent!) ||
          seg1.rightSweepEvent?.isSamePoint(seg2.leftSweepEvent) ||
          seg1.leftSweepEvent.isSamePoint(seg2.leftSweepEvent) ||
          seg1.leftSweepEvent.isSamePoint(seg2.rightSweepEvent!))) {
    return null;
  }

  num x1 = seg1.leftSweepEvent.position.lng;
  num y1 = seg1.leftSweepEvent.position.lat;
  num? x2 = seg1.rightSweepEvent?.position.lng;
  num? y2 = seg1.rightSweepEvent?.position.lat;
  num x3 = seg2.leftSweepEvent.position.lng;
  num y3 = seg2.leftSweepEvent.position.lat;
  num? x4 = seg2.rightSweepEvent?.position.lng;
  num? y4 = seg2.rightSweepEvent?.position.lat;
  num denom = ((y4! - y3) * (x2! - x1)) - ((x4! - x3) * (y2! - y1));
  num numeA = ((x4 - x3) * (y1 - y3)) - ((y4 - y3) * (x1 - x3));
  num numeB = ((x2 - x1) * (y1 - y3)) - ((y2 - y1) * (x1 - x3));

  if (denom == 0) return null;

  num uA = numeA / denom;
  num uB = numeB / denom;

  if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {
    return Position.of([
      x1 + (uA * (x2 - x1)),
      y1 + (uA * (y2 - y1)),
    ]);
  }

  return null;
}
