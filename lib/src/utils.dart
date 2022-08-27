import 'package:sweepline_intersections/src/segment.dart';
import 'package:turf/helpers.dart';

Point? testSegmentIntersect(Segment seg1, Segment seg2) {
  if (seg1.leftSweepEvent.ringId == seg2.leftSweepEvent.ringId &&
      (seg1.rightSweepEvent.isSamePoint(seg2.leftSweepEvent) ||
          seg1.rightSweepEvent.isSamePoint(seg2.leftSweepEvent) ||
          seg1.rightSweepEvent.isSamePoint(seg2.rightSweepEvent) ||
          seg1.leftSweepEvent.isSamePoint(seg2.leftSweepEvent) ||
          seg1.leftSweepEvent.isSamePoint(seg2.rightSweepEvent))) {
    return null;
  }

  var x1 = seg1.leftSweepEvent.p.lng;
  var y1 = seg1.leftSweepEvent.p.lat;
  var x2 = seg1.rightSweepEvent.p.lng;
  var y2 = seg1.rightSweepEvent.p.lat;
  var x3 = seg2.leftSweepEvent.p.lng;
  var y3 = seg2.leftSweepEvent.p.lat;
  var x4 = seg2.rightSweepEvent.p.lng;
  var y4 = seg2.rightSweepEvent.p.lat;

  var denom = ((y4 - y3) * (x2 - x1)) - ((x4 - x3) * (y2 - y1));
  var numeA = ((x4 - x3) * (y1 - y3)) - ((y4 - y3) * (x1 - x3));
  var numeB = ((x2 - x1) * (y1 - y3)) - ((y2 - y1) * (x1 - x3));

  if (denom == 0) {
    if (numeA == 0 && numeB == 0) {
      return null;
    } else {
      return null;
    }
  }

  var uA = numeA / denom;
  var uB = numeB / denom;

  if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {
    var x = x1 + (uA * (x2 - x1));
    var y = y1 + (uA * (y2 - y1));
    return Point(coordinates: Position.of([x, y]));
  }
  return null;
}
