import 'package:dart_sort_queue/dart_sort_queue.dart';
import 'package:sweepline_intersections/src/compare_events.dart';
import 'package:sweepline_intersections/src/events.dart';
import 'package:sweepline_intersections/src/fill_queue.dart';
import 'package:sweepline_intersections/src/run_check.dart';
import 'package:turf/helpers.dart';

class SweeplineIntersections {
  late SortQueue<Event> _eventQueue;
  SweeplineIntersections()
      : _eventQueue = SortQueue<Event>([], compare: checkWhichEventIsLeft);

  addData(GeoJSONObject geojson, SortQueue? alternateEventQueue) {
    if (alternateEventQueue != null) {
      var newQueue = SortQueue<Event>([], compare: checkWhichEventIsLeft);
      for (int i = 0; i < alternateEventQueue.length; i++) {
        newQueue.push(alternateEventQueue.elementAt(i));
      }
      _eventQueue = newQueue;
    }
    fillEventQueue(geojson, _eventQueue);
  }

  SortQueue cloneEventQueue() {
    var newQueue = SortQueue<Event>([], compare: checkWhichEventIsLeft);
    for (int i = 0; i < _eventQueue.length; i++) {
      newQueue.push(_eventQueue.toList()[i]);
    }
    return newQueue;
  }

  List<Position> getIntersections(bool ignoreSelfIntersections) {
    return runCheck(_eventQueue, ignoreSelfIntersections);
  }
}
