import 'package:dart_tiny_queue/dart_tiny_queue.dart';
import 'package:sweepline_intersections/src/compare_events.dart';
import 'package:sweepline_intersections/src/fill_queue.dart';
import 'package:sweepline_intersections/src/run_check.dart';
import 'package:turf/helpers.dart';

List<Point> sweeplineIntersections(GeoJSONObject geojson,
    [bool ignoreSelfIntersections = false]) {
  var eventQueue = TinyQueue(data: [], compare: checkWhichEventIsLeft);
  fillEventQueue(geojson, eventQueue);
  return runCheck(eventQueue, ignoreSelfIntersections);
}
