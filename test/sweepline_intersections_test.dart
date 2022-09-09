import 'dart:convert';
import 'package:test/test.dart';
import 'package:turf/helpers.dart';
import 'dart:io';

import 'package:sweepline_intersections/sweepline_intersections.dart';

void main() {
  group(
    'A group of tests for sweepLine',
    () {
      var inDir = Directory('./test/fixtures/simple/');
      for (var file in inDir.listSync(recursive: true)) {
        if (file is File && file.path.endsWith('.geojson')) {
          test(
            'simple fixtures: ${file.path}',
            () {
              var inSource = file.readAsStringSync();
              var inGeom = GeoJSONObject.fromJson(jsonDecode(inSource));
              var ips = sweeplineIntersections(inGeom);

              expect(ips.length, 0);
            },
          );
        }
      }

      var inDir1 = Directory('./test/fixtures/notSimple/');
      for (var file in inDir1.listSync(recursive: true)) {
        if (file is File && file.path.endsWith('.geojson')) {
          test(
            'complex fixtures: ${file.path}',
            () {
              var inSource = file.readAsStringSync();
              var inGeom = GeoJSONObject.fromJson(jsonDecode(inSource));
              var ips = sweeplineIntersections(inGeom);
              expect(
                  ips.length ==
                      (inGeom as Feature).properties!["expectedIntersections"],
                  true);
            },
          );
        }
      }

      File example1 = File('./test/fixtures/notSimple/example.geojson');
      test(
        'input data is not modified',
        () {
          var inSource = example1.readAsStringSync();
          var geojson = GeoJSONObject.fromJson(jsonDecode(inSource));

          var clonedData = GeoJSONObject.fromJson(geojson.toJson());
          sweeplineIntersections(geojson);

          expect(geojson, equals(clonedData));
        },
      );
      test(
        'ignoreSelfIntersections param works',
        () {
          var geojson = GeoJSONObject.fromJson(jsonDecode(
              File('./test/fixtures/notSimple/example.geojson')
                  .readAsStringSync()));
          var selfIntersectionsIgnored = sweeplineIntersections(geojson, true);
          expect(selfIntersectionsIgnored, isEmpty);

          var intersections = sweeplineIntersections(geojson, false);
          expect(intersections.length == 3, isTrue);
          expect(intersections[0],
              Position.of([19.88085507071179, -9.98118374351003]));
        },
      );
    },
  );
}
