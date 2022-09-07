import 'package:dart_sort_queue/dart_sort_queue.dart';
import 'package:sweepline_intersections/src/events.dart';
import 'package:sweepline_intersections/src/fill_queue.dart';
import 'package:sweepline_intersections/src/run_check.dart';
import 'package:turf/helpers.dart';

class SweeplineIntersections {
  SortQueue<Event> _eventQueue = SortQueue<Event>();
  SweeplineIntersections();

  addData(GeoJSONObject geojson, SortQueue<Event>? alternateEventQueue) {
    if (alternateEventQueue != null) {
      SortQueue<Event> newQueue = SortQueue<Event>();
      for (int i = 0; i < alternateEventQueue.length; i++) {
        newQueue.push(alternateEventQueue.elementAt(i));
      }
      _eventQueue = newQueue;
    }
    fillEventQueue(geojson, _eventQueue);
  }

  SortQueue<Event> cloneEventQueue() {
    SortQueue<Event> newQueue = SortQueue<Event>();
    for (int i = 0; i < _eventQueue.length; i++) {
      newQueue.push(_eventQueue.elementAt(i));
    }
    return newQueue;
  }

  List<Position> getIntersections<G extends Comparable<G>>(
      bool ignoreSelfIntersections) {
    return runCheck(_eventQueue, ignoreSelfIntersections);
  }
}
