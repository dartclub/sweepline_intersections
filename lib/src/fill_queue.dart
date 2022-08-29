import 'package:dart_sort_queue/dart_sort_queue.dart';
import 'package:sweepline_intersections/src/compare_events.dart';
import 'package:sweepline_intersections/src/events.dart';
import 'package:turf/helpers.dart';

void fillEventQueue(GeoJSONObject geojson, SortQueue eventQueue) {
  if (geojson is FeatureCollection) {
    List<Feature> features = geojson.features;
    for (int i = 0; i < features.length; i++) {
      processFeature(features[i], eventQueue);
    }
  } else {
    processFeature(geojson, eventQueue);
  }
}

int _featureId = 0;
int _ringId = 0;
int _eventId = 0;
void processFeature(GeoJSONObject featureOrGeometry, SortQueue eventQueue) {
  GeoJSONObject geom = featureOrGeometry is Feature
      ? featureOrGeometry.geometry!
      : featureOrGeometry;
  List<List<List<Position>>> coords = [];
  // standardise the input
  if (geom is Polygon || geom is MultiLineString) {
    coords.add((geom as GeometryType).coordinates as List<List<Position>>);
  }
  if (geom is LineString) {
    coords.add([geom.coordinates]);
  }

  for (int i = 0; i < coords.length; i++) {
    for (int ii = 0; ii < coords[i].length; ii++) {
      Position currentP = coords[i][ii][0];
      Position nextP;
      _ringId = _ringId + 1;
      for (int iii = 0; iii < coords[i][ii].length - 1; iii++) {
        nextP = coords[i][ii][iii + 1];

        Event e1 = Event(
          currentP,
          _featureId,
          _ringId,
          _eventId,
        );
        Event e2 = Event(
          nextP,
          _featureId,
          _ringId,
          _eventId + 1,
        )..otherEvent = e1;

        e1.otherEvent = e2;

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
