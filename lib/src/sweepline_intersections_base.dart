import 'package:dart_sort_queue/dart_sort_queue.dart';
import 'package:sweepline_intersections/src/compare_events.dart';
import 'package:sweepline_intersections/src/events.dart';
import 'package:sweepline_intersections/src/fill_queue.dart';
import 'package:sweepline_intersections/src/run_check.dart';
import 'package:turf/helpers.dart';

List<Position> sweeplineIntersections(GeoJSONObject geojson,
    [bool ignoreSelfIntersections = false]) {
  var eventQueue = SortQueue<Event>([], compare: checkWhichEventIsLeft);
  fillEventQueue(geojson, eventQueue);
  return runCheck(eventQueue, ignoreSelfIntersections);
}
