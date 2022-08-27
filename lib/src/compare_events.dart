int checkWhichEventIsLeft(e1, e2) {
  if (e1.p.lng > e2.p.lng) {
    return 1;
  }
  if (e1.p.lng < e2.p.lng) {
    return -1;
  }

  if (e1.p.lat != e2.p.lat) {
    return e1.p.lat > e2.p.lat ? 1 : -1;
  }
  return 1;
}

int checkWhichSegmentHasRightEndpointFirst(seg1, seg2) {
  if (seg1.rightSweepEvent.p.lng > seg2.rightSweepEvent.p.lng) {
    return 1;
  }
  if (seg1.rightSweepEvent.p.lng < seg2.rightSweepEvent.p.lng) {
    return -1;
  }

  if (seg1.rightSweepEvent.p.lat != seg2.rightSweepEvent.p.lat) {
    return seg1.rightSweepEvent.p.lat < seg2.rightSweepEvent.p.lat ? 1 : -1;
  }
  return 1;
}
