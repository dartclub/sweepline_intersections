import 'package:sweepline_intersections/src/compare_events.dart';
import 'package:sweepline_intersections/src/fill_queue.dart';
import 'package:sweepline_intersections/src/run_check.dart';

sweeplineIntersections(geojson, ignoreSelfIntersections) {
  var eventQueue = TinyQueue([], checkWhichEventIsLeft);
  fillEventQueue(geojson, eventQueue);
  return runCheck(eventQueue, ignoreSelfIntersections);
}
