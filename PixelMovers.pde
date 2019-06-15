Mover[] movers;
PImage img;
PImage img2;
int scale = 10;
boolean isMoving = false;
import java.util.*;

void setup() {
  img = loadImage(sketchPath()+"\\tiger.jpg");
  img2 = loadImage(sketchPath()+"\\lion.png");  
  img.resize(100, 0);
  img2.resize(img.width, img.height);
  surface.setResizable(true);
  surface.setSize(img.width*scale, img.height*scale);
  movers = new Mover[img.width*img.height];
  createMovers(img, img2, scale);
  frameRate(45);
}

void draw() {
  background(255);
  noStroke();
  for (Mover mover : movers) {
    if (isMoving) {
      mover.move();
      mover.boxIn();
    }
    mover.draw();
  }
  
  //saveFrame("./output/pixel_mover_#####.png");
}

void mousePressed() {
  if (mouseButton == LEFT) {
    if (isMoving) isMoving = false;
    else isMoving = true;
  } else if (mouseButton == RIGHT) {
    for (Mover mover: movers) {
      mover.changeTarget((mover.targetIndex+1) % mover.targets.size());
    }
  }
}

void mouseDragged() {
  if (mouseButton == CENTER) {
    for (Mover mover : movers) {
      if (dist(mouseX, mouseY, mover.pos.x, mover.pos.y) < mover.size) {
        mover.isHidden = true;
      }
    }
  }
}

void createMovers(PImage img1, PImage img2, int scale) {
  img1.loadPixels();
  img2.loadPixels();

  ColorVector[] cvArr = new ColorVector[movers.length];
  
  //Create movers
  for (int x = 0; x < img1.width; x++) {
    for (int y = 0; y < img1.height; y++) {
      int loc = x + (y*img1.width);
      int col = img1.pixels[loc];
      PVector pos = new PVector(x*scale, y*scale);
      movers[loc] = new Mover(pos, scale, col);
    }
  }

  //create color vectors of 2nd image
  for (int x = 0; x < img2.width; x++) {
    for (int y = 0; y < img2.height; y++) {
      int loc = x + (y*img2.width);
      cvArr[loc] = new ColorVector(img2.pixels[loc], new PVector(x*scale,y*scale)); 
    }
  }

  Arrays.sort(cvArr, new ColorVectorComparator());
  Arrays.sort(movers, new MoverComparator());

  for (int x = 0; x < img1.width; x++) {
    for (int y = 0; y < img1.height; y++) {
      int loc = x + (y*img2.width);
      Target sorted = new TargetVector(new PVector(x*scale, y*scale));
      Target img2Targ = new TargetVector(cvArr[loc].pos.copy());
      movers[loc].addTarget(sorted);
      movers[loc].addTarget(img2Targ);
    }
  }
}


void createMovers(PImage image, int scale) {
  image.loadPixels();

  //Create movers
  for (int x = 0; x < image.width; x++) {
    for (int y = 0; y < image.height; y++) {
      int loc = x + (y*image.width);
      int col = image.pixels[loc];
      PVector pos = new PVector(x*scale, y*scale);
      movers[loc] = new Mover(pos, scale, col);
    }
  }
  
  Arrays.sort(movers, new MoverComparator());

  for (int x = 0; x < image.width; x++) {
    for (int y = 0; y < image.height; y++) {
      Target target = new TargetVector(new PVector(x*scale, y*scale));
      movers[x + y*img.width].addTarget(target);
    }
  }
}

void createMovers() {
  //Create movers
  for (int i = 0; i < movers.length; i++) {
    int col = color(30+random(225-30), 30+random(225), 30+random(225));
    PVector pos = new PVector(random(width), random(height));
    int size = 10 + (int) random(6);
    movers[i] = new Mover(pos, size, col);
  }

  Arrays.sort(movers, new MoverComparator());

  //find targets for movers
  for (int i = 0; i < movers.length; i++) {
    Mover runCentral = movers[i];
    float runHue = hue(movers[i].col);
    Target target = new TargetVector(new PVector(runHue*width/255, height/2));
    runCentral.addTarget(target); 
    i++;
    while (i < movers.length) {
      if (abs(hue(movers[i].col) - runHue) < 10) {
        movers[i].addTarget(new TargetMover(runCentral));
        i++;
      } else {
        i--;
        break;
      }
    }
  }
}
