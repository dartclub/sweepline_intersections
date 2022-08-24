import 'package:sweepline_intersections/src/events.dart';
import 'package:turf/helpers.dart';

import Event from './Event'
import {checkWhichEventIsLeft} from './compareEvents'

fillEventQueue (GeoJSONObject geojson, eventQueue) {
    if (geojson is FeatureCollection) {
        var features = geojson.features;
        for (var i = 0; i < features.length; i++) {
            processFeature(features[i], eventQueue);
        }
    } else {
        processFeature(geojson, eventQueue);
    }
}

var featureId = 0;
var ringId = 0;
var eventId = 0;
processFeature (GeoJSONObject featureOrGeometry, eventQueue) {
    GeoJSONObject? geom = featureOrGeometry is Feature ? featureOrGeometry.geometry : featureOrGeometry;
    var coords = geom.coordinates;
    // standardise the input
    if (geom is Polygon || geom is MultiLineString) coords = [coords];
    if (geom is LineString){ coords = [[coords]];}

    for (var i = 0; i < coords.length; i++) {
        for (var ii = 0; ii < coords[i].length; ii++) {
            var currentP = coords[i][ii][0];
            var nextP;
            ringId = ringId + 1;
            for (var iii = 0; iii < coords[i][ii].length - 1; iii++) {
                nextP = coords[i][ii][iii + 1];

                var e1 = Event(currentP, featureId, ringId, eventId);
                var e2 = Event(nextP, featureId, ringId, eventId + 1);

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
                eventId = eventId + 1;
            }
        }
    }
    featureId = featureId + 1;
}