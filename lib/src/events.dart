import 'package:turf/helpers.dart';

class Event {
  final int ringId;
  final int featureId;
  final int eventId;
  final Position p;
  Event? otherEvent;
  bool? isLeftEndpoint;

  Event(this.p, this.featureId, this.ringId, this.eventId);
  isSamePoint(Event eventToCheck) {
    return p.lat == eventToCheck.p.lat && p.lng == eventToCheck.p.lng;
  }
}
