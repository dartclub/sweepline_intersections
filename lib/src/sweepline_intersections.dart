import 'package:sweepline_intersections/src/compare_events.dart';
import 'package:sweepline_intersections/src/fill_queue.dart';
import 'package:sweepline_intersections/src/run_check.dart';

class SweeplineIntersections {
  var _eventQueue;
  constructor() {
    _eventQueue = TinyQueue([], checkWhichEventIsLeft);
  }

  addData(geojson, alternateEventQueue) {
    if (alternateEventQueue != null) {
      var newQueue = TinyQueue([], checkWhichEventIsLeft);
      for (var i = 0; i < alternateEventQueue.length; i++) {
        newQueue.push(alternateEventQueue.data[i]);
      }
      _eventQueue = newQueue;
    }
    fillEventQueue(geojson, _eventQueue);
  }

  cloneEventQueue() {
    const newQueue = TinyQueue([], checkWhichEventIsLeft);
    for (var i = 0; i < _eventQueue.length; i++) {
      newQueue.push(_eventQueue.data[i]);
    }
    return newQueue;
  }

  getIntersections(ignoreSelfIntersections) {
    return runCheck(_eventQueue, ignoreSelfIntersections);
  }
}
