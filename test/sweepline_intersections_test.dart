import 'dart:convert';

import 'package:sweepline_intersections/sweepline_intersections.dart';
import 'package:test/test.dart';
import 'dart:io';

import 'package:turf/helpers.dart';

void main() {
  group('A group of tests', () {
    var inDir = Directory('./test/fixtures/simple/');
    for (var file in inDir.listSync(recursive: true)) {
      if (file is File && file.path.endsWith('.geojson')) {
        test(file.path, () {
          var inSource = file.readAsStringSync();
          var inGeom = GeoJSONObject.fromJson(jsonDecode(inSource));
          var ips = sweeplineIntersections(inGeom);

          expect(ips, isEmpty);
          //   t.is(ips.length, 0,  `[true] ${name}`)
        });
      }
    }
    var inDir1 = Directory('./test/fixtures/notSimple/');
    for (var file in inDir1.listSync(recursive: true)) {
      if (file is File && file.path.endsWith('.geojson')) {
        test(file.path, () {
          var inSource = file.readAsStringSync();
          var geojson = GeoJSONObject.fromJson(jsonDecode(inSource));
          var ips = sweeplineIntersections(geojson);
          print(ips.length);
          print((geojson as Feature).properties!["expectedIntersections"]);
          // expect(
          //     ips.length ==
          //         (geojson as Feature).properties!["expectedIntersections"],
          //     true);
        });
      }
    }
  });
}


/*
import test from 'ava'
import path from 'path'
import glob from 'glob'

import load from 'load-json-file'

import sweepline from '../src/main.js'

const trueFixtures = glob.sync(path.join(__dirname, 'fixtures', 'simple', '*.geojson'))
const falseFixtures = glob.sync(path.join(__dirname, 'fixtures', 'notSimple', '*.geojson'))

test('simple fixtures', (t) => {
    trueFixtures.forEach((filepath) => {
        const name = path.parse(filepath).name
        const geojson = load.sync(filepath)
        const ips = sweepline(geojson)
        t.is(ips.length, 0,  `[true] ${name}`)
    })
})


test('complex fixtures', (t) => {
    falseFixtures.forEach((filepath) => {
        const name = path.parse(filepath).name
        const geojson = load.sync(filepath)
        const ips = sweepline(geojson)
        t.deepEqual(ips.length, geojson.properties.expectedIntersections,  `[complex] ${name}`)
    })
})

test('input data is not modified', (t) => {
    const geojson = load.sync(path.join(__dirname, 'fixtures', 'notSimple', 'example.geojson'))
    const clonedData = JSON.parse(JSON.stringify(geojson))
    sweepline(geojson)
    t.deepEqual(geojson, clonedData)
})

test('ignoreSelfIntersections param works', (t) => {
    const geojson = load.sync(path.join(__dirname, 'fixtures', 'notSimple', 'example.geojson'))
    const selfIntersectionsIgnored = sweepline(geojson, true)
    t.is(selfIntersectionsIgnored.length, 0)

    const intersections = sweepline(geojson, false)
    t.is(intersections.length, 3)
    t.deepEqual(intersections[0], [19.88085507071179, -9.98118374351003])
})
*/