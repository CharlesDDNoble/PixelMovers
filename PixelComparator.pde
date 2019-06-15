class MoverComparator implements Comparator<Mover> {
  float getLuma(int col) {
     return red(col)*0.2989 + green(col)*0.5870 + blue(col)*0.1140;
  }
  
  int compare(Mover mov1, Mover mov2) {
    float hue1 = getLuma(mov1.col);
    float hue2 = getLuma(mov2.col);

    if (hue1 < hue2)
      return -1;
    else if (hue1 == hue2)
      return 0;
    else
      return 1;
  }
}

class ColorVectorComparator implements Comparator<ColorVector> {
  int compare(ColorVector cv1, ColorVector cv2) {
    float hue1 = brightness(cv1.col);
    float hue2 = brightness(cv2.col);

    if (hue1 < hue2)
      return -1;
    else if (hue1 == hue2)
      return 0;
    else
      return 1;
  }
}
