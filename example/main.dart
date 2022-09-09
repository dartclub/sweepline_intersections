import 'dart:convert';
import 'dart:io';

import 'package:sweepline_intersections/src/sweepline_intersections.dart';
import 'package:turf/helpers.dart';

main() {
  File chileVertical =
      File('./test/fixtures/notSimple/doubleIntersection.geojson');

  var inSource = chileVertical.readAsStringSync();
  var inGeom = GeoJSONObject.fromJson(jsonDecode(inSource));
  // create the base instance
  var sl = SweeplineIntersections();
  sl.addData(inGeom);

  // clone the event queue in the original state so you can reuse it
  var origQueue = sl.cloneEventQueue();
  List<Position> positions = [
    Position.of([21.93869948387146, 49.99897434944081]),
    Position.of([21.93869948387100, 49.99897434944032]),
  ];
  var f = FeatureCollection(
    features: [
      Feature(
        geometry: LineString(coordinates: positions),
      ),
    ],
  );
  // // now you can iterate through some other set of [Feature]s saving
  // // the overhead of having to populate the complete queue multiple times
  for (Feature feature in f.features) {
    // add another feature to test against your original data
    sl.addData(feature, alternateEventQueue: origQueue);
    // check if those two features intersect
    // add an optional boolean argument to ignore self-intersections
  }

  var intersectionPoints = sl.getIntersections(false);

  for (Position p in intersectionPoints) {
    print(p.lat);
  }
// 49.99846475944782
// 49.99913990528173
// 49.99897434944081
}
