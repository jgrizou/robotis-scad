include <ollo_segments_def.scad>

use <ollo_straight_segment.scad>;
use <ollo_grid_segment.scad>;

use <../ollo/ollo_tools.scad>;

use <../../MCAD/rotate.scad>;

module three_ollo_segment(nLayer=1, width=OlloSegmentWidth) {
  difference() {
    ollo_straight_segment(OlloSpacing, nLayer, width);
    translate([0, OlloSpacing/2, 0])
      threeOlloHoles(nLayer);
  }
}

module add_three_ollo_segment(nLayer=1, width=OlloSegmentWidth) {
  three_ollo_segment(nLayer, width);
    translate([0, OlloSpacing, 0])
      for(i = [0 : $children - 1])
        children(i);
}

module three_ollo_start_segment(nLayer=1, width=OlloSegmentWidth) {
  translate([0, -OlloSpacing/2, 0])
    three_ollo_segment(nLayer, width);
}


module add_three_ollo_start_segment(nLayer=1, width=OlloSegmentWidth) {
  three_ollo_start_segment(nLayer, width);
  translate([0, OlloSpacing/2, 0])
    for(i = [0 : $children - 1])
      children(i);
}

module three_ollo_stop_segment(nLayer=1, width=OlloSegmentWidth) {
  three_ollo_segment(nLayer, width);
}

module add_three_ollo_stop_segment(nLayer=1, width=OlloSegmentWidth) {
  three_ollo_stop_segment(nLayer, width);
  translate([0, OlloSpacing/2, 0])
    for(i = [0 : $children - 1])
      children(i);
}

//
module ollo_xl320_side_segment(nLayer=1, width=OlloSegmentWidth, withHole=false) {
  if (withHole == true){
    difference() {
      ollo_xl320_side_segment(nLayer, width, withHole=false);
      translate([0,2*OlloSpacing,0])
        cube([1.5*OlloSpacing,2*OlloSpacing,ollo_segment_thickness(nLayer)], center=true);
    }
  } else {
    add_three_ollo_segment(nLayer, width)
      add_ollo_straight_segment(2*OlloSpacing, nLayer, width)
        three_ollo_stop_segment(nLayer, width);
  }
}

module add_ollo_xl320_side_segment(nLayer=1, width=OlloSegmentWidth, withHole=false) {
  ollo_xl320_side_segment(nLayer, width, withHole);
  translate([0, 4*OlloSpacing, 0])
    for(i = [0 : $children - 1])
      children(i);
}

module ollo_xl320_side_start_segment(nLayer=1, width=OlloSegmentWidth, withHole=false) {
  translate([0, -OlloSpacing/2, 0])
    ollo_xl320_side_segment(nLayer, width, withHole);
}

module add_ollo_xl320_side_start_segment(nLayer=1, width=OlloSegmentWidth, withHole=false) {
  ollo_xl320_side_start_segment(nLayer, width, withHole);
  translate([0, 7*OlloSpacing/2, 0])
    for(i = [0 : $children - 1])
      children(i);
}

module ollo_xl320_side_stop_segment(nLayer=1, width=OlloSegmentWidth, withHole=false) {
  ollo_xl320_side_segment(nLayer, width, withHole);
}

module add_ollo_xl320_side_stop_segment(nLayer=1, width=OlloSegmentWidth, withHole=false) {
  ollo_xl320_side_stop_segment(nLayer, width, withHole);
  translate([0, 7*OlloSpacing/2, 0])
    for(i = [0 : $children - 1])
      children(i);
}

//
module ollo_xl320_bottom_segment(nLayer=1, width=OlloSegmentWidth) {
  add_three_ollo_segment(nLayer, width)
  add_ollo_straight_segment(3*OlloSpacing, nLayer, width)
  three_ollo_stop_segment(nLayer, width);
}

module add_ollo_xl320_bottom_segment(nLayer=1, width=OlloSegmentWidth) {
  ollo_xl320_bottom_segment(nLayer, width);
  translate([0, 5*OlloSpacing, 0])
  for(i = [0 : $children - 1])
  children(i);
}

module ollo_xl320_bottom_start_segment(nLayer=1, width=OlloSegmentWidth) {
  translate([0, -OlloSpacing/2, 0])
  ollo_xl320_bottom_segment(nLayer, width);
}

module add_ollo_xl320_bottom_start_segment(nLayer=1, width=OlloSegmentWidth) {
  ollo_xl320_bottom_start_segment(nLayer, width);
  translate([0, 9*OlloSpacing/2, 0])
  for(i = [0 : $children - 1])
  children(i);
}

module ollo_xl320_bottom_stop_segment(nLayer=1, width=OlloSegmentWidth) {
  ollo_xl320_bottom_segment(nLayer, width);
}

module add_ollo_xl320_bottom_stop_segment(nLayer=1, width=OlloSegmentWidth) {
  ollo_xl320_bottom_stop_segment(nLayer, width);
  translate([0, 9*OlloSpacing/2, 0])
  for(i = [0 : $children - 1])
  children(i);
}

// Testing
echo("##########");
echo("In ollo_xl320_segment.scad");
echo("This file should not be included, use ''use <filemane>'' instead.");
echo("##########");

p = 1;
nLayer = 1;
if (p==1) {
  add_ollo_xl320_side_start_segment(withHole=true)
    add_ollo_straight_segment(100)
      add_ollo_xl320_side_stop_segment()
        cylinder(h=10, d=5);
  translate([30,0,0])
    add_ollo_xl320_bottom_start_segment()
      add_ollo_straight_segment(100)
        add_ollo_xl320_bottom_stop_segment()
          cylinder(h=10, d=5);
  translate([60,0,0])
    add_three_ollo_segment()
      three_ollo_segment();
  translate([90,0,0])
    add_three_ollo_start_segment()
      three_ollo_stop_segment();
}
