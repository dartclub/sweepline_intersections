import 'package:turf/helpers.dart';

class Event {
  final int ringId;
  final int featureId;
  final int eventId;
  final Position position;

  Event? otherEvent;
  bool? isLeftEndpoint;

  Event(
    this.position,
    this.featureId,
    this.ringId,
    this.eventId,
  );
  isSamePoint(Event eventToCheck) {
    return position.lat == eventToCheck.position.lat &&
        position.lng == eventToCheck.position.lng;
  }
}
