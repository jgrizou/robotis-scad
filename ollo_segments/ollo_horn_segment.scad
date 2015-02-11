include <ollo_segment_def.scad>

use <ollo_straight_segment.scad>;
use <ollo_rounded_segment.scad>;

use <../ollo/ollo_tools.scad>;

use <../../MCAD/rotate.scad>;

module ollo_horn_rounded_start_segment(nLayer=1, width=OlloSegmentWidth, angle=0) {
  difference () {
    union() {
      ollo_rounded_start_segment(nLayer, width);
      ollo_straight_segment(width/2, nLayer, width);
    }
    rotate([0, 0, angle])
      crossOlloHoles(nLayer);
  }
}

module add_ollo_horn_rounded_start_segment(nLayer=1, width=OlloSegmentWidth, angle=0) {
  ollo_horn_rounded_start_segment(nLayer, width, angle);
  translate([0, width/2, 0])
    for(i = [0 : $children - 1])
      children(i);
}

module ollo_horn_rounded_stop_segment(nLayer=1, width=OlloSegmentWidth, angle=0) {
  rotate([0,0,180])
    translate([0, -width/2, 0])
      ollo_horn_rounded_start_segment(nLayer, width, angle);
}

module add_ollo_horn_rounded_stop_segment(nLayer=1, width=OlloSegmentWidth, angle=0) {
  ollo_horn_rounded_stop_segment(nLayer, width, angle);
  translate([0, width/2, 0])
    for(i = [0 : $children - 1])
      children(i);
}

module ollo_horn_straight_segment(length, nLayer=1, width=OlloSegmentWidth, angle=0) {
  difference () {
    union() {
      ollo_straight_segment(length, nLayer, width, angle);
    }
    translate([0, length/2, 0])
      rotate([0, 0, angle])
        crossOlloHoles(nLayer);
  }
}

module add_ollo_horn_straight_segment(length, nLayer=1, width=OlloSegmentWidth, angle=0) {
  ollo_horn_straight_segment(length, nLayer, width, angle);
  translate([0, length, 0])
    for(i = [0 : $children - 1])
      children(i);
}

// Testing
echo("##########");
echo("In ollo_horn_segment.scad");
echo("This file should not be included, use ''use <filemane>'' instead.");
echo("##########");

p = 1;
nLayer = 1;
if (p==1) {
  add_ollo_horn_rounded_start_segment(nLayer)
    add_ollo_horn_straight_segment(length=50, nLayer=nLayer, angle=22.5)
      ollo_horn_rounded_stop_segment(angle=45, nLayer=nLayer);
}
