// import 'package:sweepline_intersections/src/events.dart';
// import 'package:sweepline_intersections/src/segment.dart';

// //lat is Y
// int checkWhichEventIsLeft(Event event1, Event event2) {
//   if (event1.position.lng > event2.position.lng) {
//     return 1;
//   }
//   if (event1.position.lng < event2.position.lng) {
//     return -1;
//   }

//   if (event1.position.lat != event2.position.lat) {
//     return event1.position.lat > event2.position.lat ? 1 : -1;
//   }
//   return 1;
// }

// int checkWhichSegmentHasRightEndpointFirst(Segment segment1, Segment segment2) {
//   if (segment1.rightSweepEvent!.position.lng >
//       segment2.rightSweepEvent!.position.lng) {
//     return 1;
//   }
//   if (segment1.rightSweepEvent!.position.lng <
//       segment2.rightSweepEvent!.position.lng) {
//     return -1;
//   }

//   if (segment1.rightSweepEvent!.position.lat !=
//       segment2.rightSweepEvent!.position.lat) {
//     return segment1.rightSweepEvent!.position.lat <
//             segment2.rightSweepEvent!.position.lat
//         ? 1
//         : -1;
//   }
//   return 1;
// }
