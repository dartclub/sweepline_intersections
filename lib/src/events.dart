import 'package:turf/helpers.dart';

class Event implements Comparable<Event> {
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

  @override
  int compareTo(Event other) {
    if (position.lng > other.position.lng) return 1;
    if (position.lng < other.position.lng) return -1;

    if (position.lat != other.position.lat) {
      return position.lat > other.position.lat ? 1 : -1;
    }
    return 1;
  }
}
