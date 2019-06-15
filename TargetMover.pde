class TargetMover extends Target {
  Mover target;
  TargetMover(Mover target) {
    this.target = target;
  }
  PVector getTarget() {
    return this.target.pos;
  }
}
