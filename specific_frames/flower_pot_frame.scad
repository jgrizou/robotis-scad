include <specific_frame_def.scad>

use <../ollo/ollo_tools.scad>
use <../../raspberry-scad/raspberry_pi_Bplus_tools.scad>

use <../../MCAD/rotate.scad>;

module ollo_holes_flower_pot(radius=FlowerPotOlloAttachPointRadius, nHoles=8){
  for(i = [1 : 1 : nHoles]) {
    translate([radius*cos(i*360/nHoles), radius*sin(i*360/nHoles), 0])
      olloHole();
  }
}

module basic_flower_pot_frame(potHeight=BasicFlowerPotFrameHeight, supportDistFromTop=FlowerPotOlloAttachDepth, potInternalBaseRadius=BasicFlowerPotFrameInternalBaseRadius, potInternalTopRadius=BasicFlowerPotFrameInternalTopRadius, wallThickness=BasicFlowerPotFrameWallThickness, bandDistFromTop=BasicFlowerPotFrameBandDistFromTop, bandThickness=BasicFlowerPotFrameBandThickness, withCameraHolder=true){

  bandStartRadius = potInternalBaseRadius + (potInternalTopRadius-potInternalBaseRadius)*((potHeight-bandDistFromTop)/potHeight);

  translate([0,0,-BasicFlowerPotFrameHeight+supportDistFromTop]) {
    difference() {
      union() {
        difference() {
          union() {
            cylinder(h=potHeight, r1=potInternalBaseRadius+wallThickness, r2=potInternalTopRadius+wallThickness);
            translate([0,0,potHeight-bandDistFromTop])
              cylinder(h=bandDistFromTop, r1=bandStartRadius+bandThickness, r2=potInternalTopRadius+bandThickness);
          }
          cylinder(h=potHeight, r1=potInternalBaseRadius, r2=potInternalTopRadius);

        }
        difference() {
          cylinder(h=ollo_segment_thickness(1),r=potInternalBaseRadius);
          translate([0,0,OlloLayerThickness/2])
          ollo_holes_flower_pot(radius=potInternalBaseRadius-OlloSpacing);
        }
      }
      //opening in the back
      translate([0,0,BasicFlowerPotFrameOpeningBottomHeight])
        rotate([90,0,0])
          cylinder(h=potInternalBaseRadius*2, r=BasicFlowerPotFrameOpeningBottomDiameter/2);
    }
  }

  // make attach ring
  attachRadius = potInternalBaseRadius + (potInternalTopRadius-potInternalBaseRadius)*((potHeight-supportDistFromTop)/potHeight);

  difference() {
    difference() {
      cylinder(h=ollo_segment_thickness(1), r=attachRadius, center=true);
      cylinder(h=ollo_segment_thickness(1), r=FlowerPotOlloAttachInternalRaidus, center=true);
    }
    ollo_holes_flower_pot();
  }

  //camera holder
  if (withCameraHolder == true) {
    translate([0,potInternalTopRadius+bandThickness/3,supportDistFromTop])
      add_raspberry_camera_holder();

  }

}

// Testing
echo("##########");
echo("In cylinder_head_frame.scad");
echo("This file should not be included, use ''use <filemane>'' instead.");
echo("##########");

use <../dynamixel/xl320.scad>

p = 1;
if (p==1) {
  basic_flower_pot_frame();
}
