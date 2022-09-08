import 'dart:convert';
import 'dart:io';
import 'package:benchmark/benchmark.dart';
import 'package:sweepline_intersections/sweepline_intersections.dart';
import 'package:turf/turf.dart';

void main() {
  File regression = File('./test/fixtures/notSimple/example1.geojson');
  File fileSwitzerland = File('switzerlandKinked.geojson');
  File chileVertical = File('chileKinked.geojson');

//')
  var inSource = regression.readAsStringSync();
  var inGeom = GeoJSONObject.fromJson(jsonDecode(inSource));

  group('SweepLine', () {
    benchmark('Switzerland', () {
      sweeplineIntersections(inGeom);
    });

    inSource = fileSwitzerland.readAsStringSync();
    inGeom = GeoJSONObject.fromJson(jsonDecode(inSource));

    benchmark('Simple Case', () {
      sweeplineIntersections(inGeom);
    });
  });

  inSource = chileVertical.readAsStringSync();
  inGeom = GeoJSONObject.fromJson(jsonDecode(inSource));
  benchmark(
    'Chile - Vertical geometry',
    () {
      sweeplineIntersections(inGeom);
    },
  );
}
