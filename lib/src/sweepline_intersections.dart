import 'package:dart_tiny_queue/dart_tiny_queue.dart';
import 'package:sweepline_intersections/src/compare_events.dart';
import 'package:sweepline_intersections/src/fill_queue.dart';
import 'package:sweepline_intersections/src/run_check.dart';
import 'package:turf/helpers.dart';

class SweeplineIntersections {
  late TinyQueue eventQueue;
  SweeplineIntersections() {
    eventQueue = TinyQueue(data: [], compare: checkWhichEventIsLeft);
  }

  addData(geojson, alternateEventQueue) {
    if (alternateEventQueue != null) {
      var newQueue = TinyQueue(data: [], compare: checkWhichEventIsLeft);
      for (var i = 0; i < alternateEventQueue.length; i++) {
        newQueue.push(alternateEventQueue.data[i]);
      }
      eventQueue = newQueue;
    }
    fillEventQueue(geojson, eventQueue);
  }

  TinyQueue cloneEventQueue() {
    var newQueue = TinyQueue(data: [], compare: checkWhichEventIsLeft);
    for (var i = 0; i < eventQueue.data!.length; i++) {
      newQueue.push(eventQueue.data![i]);
    }
    return newQueue;
  }

  List<Point> getIntersections(ignoreSelfIntersections) {
    return runCheck(eventQueue, ignoreSelfIntersections);
  }
}
