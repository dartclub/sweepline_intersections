import 'package:turf/helpers.dart';

class Event {
  final Position position;
  final int featureId;
  final int ringId;
  final int eventId;

  Event? otherEvent;
  bool? isLeftEndpoint;

  Event(
    this.position,
    this.featureId,
    this.ringId,
    this.eventId,
  );
  isSamePoint(Event eventToCheck) {
    return position == eventToCheck.position;
  }

  clone() => Event(position.clone(), featureId, ringId, eventId);
}
