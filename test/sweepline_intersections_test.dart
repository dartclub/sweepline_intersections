import 'dart:convert';

import 'package:sweepline_intersections/sweepline_intersections.dart';
import 'package:test/test.dart';
import 'dart:io';

import 'package:turf/helpers.dart';

void main() {
  group('A group of tests', () {
    var inDir = Directory('./test/fixtures/simple/');
    for (var file in inDir.listSync(recursive: true)) {
      if (file is File && file.path.contains('chile')) {
        test(
          file.path,
          () {
            var inSource = file.readAsStringSync();
            var inGeom = GeoJSONObject.fromJson(jsonDecode(inSource));
            var ips = sweeplineIntersections(inGeom);

            expect(ips, isEmpty);
          },
        );
      }
    }
    var inDir1 = Directory('./test/fixtures/notSimple/');
    for (var file in inDir1.listSync(recursive: true)) {
      if (file is File && file.path.endsWith('.geojson')) {
        test(
          file.path,
          () {
            var inSource = file.readAsStringSync();
            var geojson = GeoJSONObject.fromJson(jsonDecode(inSource));
            var ips = sweeplineIntersections(geojson);
            expect(
                ips.length ==
                    (geojson as Feature).properties!["expectedIntersections"],
                isTrue);
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
    test('ignoreSelfIntersections param works', () {
      var geojson = GeoJSONObject.fromJson(jsonDecode(
          File('./test/fixtures/notSimple/example.geojson')
              .readAsStringSync()));
      var selfIntersectionsIgnored = sweeplineIntersections(geojson, true);
      expect(selfIntersectionsIgnored, isEmpty);

      var intersections = sweeplineIntersections(geojson, false);
      print(intersections);
      // expect(intersections.length == 3, true);
      //  expect(intersections[0],
      //     Position.of([19.88085507071179, -9.98118374351003]));
    });
  });
}
