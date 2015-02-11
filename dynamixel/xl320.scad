include <xl320_def.scad>;
include <../ollo/ollo_def.scad>;

use <../ollo/ollo_tools.scad>;

use <../../MCAD/rounded_cube.scad>;
use <../../MCAD/rotate.scad>;

// Shapes
module box() {

  difference() {
    translate([0, -MotorLength/2+MotorAxisOffset, 0])
      rounded_cube(MotorWidth, MotorLength, MotorHeight, BackExtrudeDepth/2, center=true);

    //Back Extrude
      translate_to_box_back()
        translate([0,BackExtrudeDepth/2,0])
          cube([MotorWidth, BackExtrudeDepth, MotorHeight-(2*OlloLayerThickness)], center=true);

    // Motor axis
    cylinder(h=MotorHeight, d=OlloInDiameter, center=true);

    // Bottom Ollo
    translate_to_box_bottom()
      translate([0,0,OlloLayerThickness/2])
        threeOlloHoles();

    // Back Ollo
    translate_to_box_ollo_bottom_back()
      translate([0, 0, OlloLayerThickness/2])
        threeOlloHoles();

    translate_to_box_ollo_top_back()
      translate([0, 0, -OlloLayerThickness/2])
        threeOlloHoles();

    // Side Ollo
    translate_to_box_right_side()
      rotate([0, 90, 0])
        translate([0, 0, -OlloLayerThickness/2])
          threeOlloHoles();

    translate_to_box_ollo_right_side_back()
      rotate([0, 90, 0])
        translate([0, 0, -OlloLayerThickness/2])
          threeOlloHoles();

    translate_to_box_left_side()
      rotate([0, 90, 0])
        translate([0, 0, OlloLayerThickness/2])
          threeOlloHoles();

    translate_to_box_ollo_left_side_back()
      rotate([0, 90, 0])
        translate([0, 0, OlloLayerThickness/2])
          threeOlloHoles();
  }
}

module horn(d=HornTopDiameter) {
  difference() {
    cylinder(d=d, h=OlloLayerThickness, center=true);

    crossOlloHoles(1);
  }
}

module xl320() {
    box();
    translate_to_box_top()
      translate([0,0,OlloLayerThickness/2])
        horn();
}

module xl320_two_horns() {
  xl320();
    translate_to_box_bottom()
      translate([0,0,-OlloLayerThickness/2])
        horn(d=HornBottomDiameter);
}

// Usefull transformation to position on motor
module translate_to_box_top() {
  translate([0, 0, MotorHeight/2])
    for(i = [0 : $children - 1])
      children(i);
}

module translate_to_box_bottom() {
  translate([0, 0, -MotorHeight/2])
    for(i = [0 : $children - 1])
      children(i);
}

module translate_to_box_back() {
  translate([0, MotorAxisOffset-MotorLength, 0])
    for(i = [0 : $children - 1])
      children(i);
}

module translate_to_box_ollo_bottom_back() {
  translate_to_box_back()
    translate([0, OlloSpacing/2, -MotorHeight/2])
      for(i = [0 : $children - 1])
        children(i);
}

module translate_to_box_ollo_top_back() {
  translate_to_box_back()
    translate([0, OlloSpacing/2, MotorHeight/2])
      for(i = [0 : $children - 1])
        children(i);
}

module translate_to_box_right_side() {
  translate([MotorWidth/2, 0, 0])
    for(i = [0 : $children - 1])
      children(i);
}

module translate_to_box_ollo_right_side_back() {
  translate_to_box_right_side()
    translate([0, -OlloSpacing*3, 0])
      for(i = [0 : $children - 1])
        children(i);
}

module translate_to_box_left_side() {
  translate([-MotorWidth/2, 0, 0])
    for(i = [0 : $children - 1])
      children(i);
}

module translate_to_box_ollo_left_side_back() {
  translate_to_box_left_side()
    translate([0, -OlloSpacing*3, 0])
      for(i = [0 : $children - 1])
        children(i);
}

module translate_to_xl320_top() {
  translate_to_box_top()
    translate([0, 0, OlloLayerThickness])
      for(i = [0 : $children - 1])
        children(i);
}

module translate_to_xl320_two_horns_bottom() {
  translate_to_box_bottom()
    translate([0, 0, -OlloLayerThickness])
      for(i = [0 : $children - 1])
        children(i);
}

// Testing
echo("##########");
echo("In xl320.scad");
echo("This file should not be included, use ''use <filemane>'' instead.");
echo("##########");

p = 1;
if (p == 1) box();
if (p == 2) horn();
if (p == 3) xl320();
if (p == 4) xl320_two_horns();
