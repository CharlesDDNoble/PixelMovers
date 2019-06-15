class Mover {
  ArrayList<Target> targets;
  int targetIndex;
  PVector pos;
  PVector vel;
  PVector acc;
  float dampening;
  float size;
  int col;
  boolean isHidden;

  Mover(PVector pos) {
    this.pos = pos;
    this.targetIndex = 0;
    this.targets = new ArrayList<Target>();
    this.targets.add(new TargetVector(pos.copy()));
    this.vel = new PVector(0, 0);
    this.acc = new PVector(0, 0);
    this.dampening = .95;
    this.isHidden = false;
  }

  Mover(PVector pos, int size, int col) {
    this.pos = pos;
    this.targetIndex = 0;
    this.targets = new ArrayList<Target>();
    this.targets.add(new TargetVector(pos.copy()));
    this.vel = new PVector(0, 0);
    this.acc = new PVector(0, 0);
    this.dampening = .95;
    this.size = size;
    this.col = col;
    this.isHidden = false;
  }

  void boxIn() {
    if (this.pos.x > width)
      this.pos.x = width;
    if (this.pos.x < 0)
      this.pos.x = 0;
    if (this.pos.y > height)
      this.pos.y = height;
    if (this.pos.y < 0)
      this.pos.y = 0;
  }

  void move() {
    PVector targ = this.targets.get(this.targetIndex).getTarget();
    this.acc = targ.copy().sub(this.pos).mult(.01);
    this.vel.add(this.acc).mult(this.dampening);
    this.pos.add(this.vel);
    this.acc.mult(0);
    vel.limit(3);
  }

  void draw() {
    if (!isHidden) {
      fill(col);
      //ellipse(this.pos.x, this.pos.y, size, size);
      rect(this.pos.x, this.pos.y, size, size);
    }
  }

  void addTarget(Target target) {
   this.targets.add(target); 
  }

  void removeTarget(int index) {
   this.targets.remove(index); 
  }
  
  void changeTarget(int index) {
   this.targetIndex = index; 
  }

  void findTarget(Mover[] movers) {
    float closestDif = Float.MAX_VALUE;
    Mover closest = null;

    for (Mover mover : movers) {
      if (mover != this) {
        float dif = abs(red(mover.col) - red(this.col)) +
          abs(green(mover.col) - green(this.col)) +
          abs(blue(mover.col) - blue(this.col));          
        if (dif < closestDif) {
          closest = mover;
          closestDif = dif;
        }
      }
    } //END FOR

    this.targets.add(new TargetMover(closest));
  }
}
