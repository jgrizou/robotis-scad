include <specific_frame_def.scad>

use <../ollo/ollo_tools.scad>

use <../../MCAD/rotate.scad>;

module ollo_holes_flower_pot(radius=FlowerPotOlloAttachPointRadius, nHoles=8){
  for(i = [1 : 1 : nHoles]) {
    translate([radius*cos(i*360/nHoles), radius*sin(i*360/nHoles), 0])
      olloHole();
  }
}

module basic_flower_pot_frame(potHeight=BasicFlowerPotFrameHeight, supportDistFromTop=FlowerPotOlloAttachDepth, potInternalBaseRadius=BasicFlowerPotFrameInternalBaseRadius, potInternalTopRadius=BasicFlowerPotFrameInternalTopRadius, wallThickness=BasicFlowerPotFrameWallThickness){

  translate([0,0,-BasicFlowerPotFrameHeight+supportDistFromTop]) {
    difference() {
      union() {
        difference() {
          cylinder(h=potHeight, r1=potInternalBaseRadius+wallThickness, r2=potInternalTopRadius+wallThickness);
          cylinder(h=potHeight, r1=potInternalBaseRadius, r2=potInternalTopRadius);

        }
        cylinder(h=ollo_segment_thickness(1),r=potInternalBaseRadius);
      }
      rotate([90,0,0])
        translate([0,0,potInternalBaseRadius-10])
        cylinder(h=potInternalBaseRadius*2, r=15);
    }
  }

  attachRadius = potInternalBaseRadius + (potInternalTopRadius-potInternalBaseRadius)*((potHeight-supportDistFromTop)/potHeight);

  difference() {
    difference() {
      cylinder(h=ollo_segment_thickness(1), r=attachRadius, center=true);
      cylinder(h=ollo_segment_thickness(1), r=FlowerPotOlloAttachInternalRaidus, center=true);
    }
    ollo_holes_flower_pot();
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
