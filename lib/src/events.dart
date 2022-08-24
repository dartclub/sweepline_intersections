class Event {
  final ringId;
  final featureId;
  final eventId;
  final Map<String, dynamic> p;
  var otherEvent;
  var isLeftEndpoint;

  Event(this.p, this.featureId, this.ringId, this.eventId);
  isSamePoint(eventToCheck) {
    return p['x'] == eventToCheck.p['x'] && p['y'] == eventToCheck.p['y'];
  }
}

/**
 * 


export default class Event {

    constructor (p, featureId, ringId, eventId) {
        this.p = {
            x: p[0],
            y: p[1]
        }
        this.featureId = featureId
        this.ringId = ringId
        this.eventId = eventId

        this.otherEvent = null
        this.isLeftEndpoint = null
    }

    isSamePoint (eventToCheck) {
        return this.p.x === eventToCheck.p.x && this.p.y === eventToCheck.p.y
    }
}
 */