import 'package:dart_tiny_queue/dart_tiny_queue.dart';
import 'package:sweepline_intersections/src/compare_events.dart';
import 'package:sweepline_intersections/src/events.dart';
import 'package:turf/helpers.dart';

void fillEventQueue(GeoJSONObject geojson, eventQueue) {
  if (geojson is FeatureCollection) {
    var features = geojson.features;
    for (var i = 0; i < features.length; i++) {
      processFeature(features[i], eventQueue);
    }
  } else {
    processFeature(geojson, eventQueue);
  }
}

int _featureId = 0;
int _ringId = 0;
int _eventId = 0;
void processFeature(GeoJSONObject featureOrGeometry, TinyQueue eventQueue) {
  GeoJSONObject geom = featureOrGeometry is Feature
      ? featureOrGeometry.geometry!
      : featureOrGeometry;
  var coords = (geom as GeometryType).coordinates;
  // standardise the input
  if (geom is Polygon || geom is MultiLineString) coords = [coords];
  if (geom is LineString) {
    coords = [
      [coords]
    ];
  }

  for (int i = 0; i < coords.length; i++) {
    for (int ii = 0; ii < coords[i].length; ii++) {
      var currentP = coords[i][ii][0];
      var nextP;
      _ringId = _ringId + 1;
      for (var iii = 0; iii < coords[i][ii].length - 1; iii++) {
        nextP = coords[i][ii][iii + 1];

        var e1 = Event(currentP, _featureId, _ringId, _eventId);
        var e2 = Event(nextP, _featureId, _ringId, _eventId + 1);

        e1.otherEvent = e2;
        e2.otherEvent = e1;

        if (checkWhichEventIsLeft(e1, e2) > 0) {
          e2.isLeftEndpoint = true;
          e1.isLeftEndpoint = false;
        } else {
          e1.isLeftEndpoint = true;
          e2.isLeftEndpoint = false;
        }
        eventQueue.push(e1);
        eventQueue.push(e2);

        currentP = nextP;
        _eventId = _eventId + 1;
      }
    }
  }
  _featureId = _featureId + 1;
}
