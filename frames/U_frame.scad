include <frame_def.scad>

include <../dynamixel/xl320_def.scad>
include <../ollo/ollo_def.scad>
include <../ollo_segments/ollo_segment_def.scad>

use <../ollo/ollo_tools.scad>
use <../ollo_segments/ollo_elbow_segment.scad>
use <../ollo_segments/ollo_straight_segment.scad>
use <../ollo_segments/ollo_horn_segment.scad>;

use <../../MCAD/rotate.scad>;


module U_branch(height, radius, nLayer, width, interAxisLength, tolerance) {

  thickness = ollo_segment_thickness(nLayer);
  sideStraightSegmentLength = height-(width/2)-radius-(thickness/2);
  bottomStraightSegmentLength = (interAxisLength/2)-radius+(thickness/2)+tolerance;

  add_ollo_horn_rounded_start_segment(nLayer, width)
    add_ollo_straight_segment(sideStraightSegmentLength, nLayer, width)
      add_ollo_elbow_segment(90, radius, false, nLayer, width)
        ollo_straight_segment(bottomStraightSegmentLength, nLayer, width);
}

module U_frame(height=UFrameHeight, radius=2*ollo_segment_thickness(1), nLayer=1, width=OlloSegmentWidth, interAxisLength=MotorHeight+2*OlloLayerThickness, tolerance=FrameTolerance) {

  thickness = ollo_segment_thickness(nLayer);

  translate([0,0,-interAxisLength/2-thickness/2-tolerance])
      U_branch(height, radius, nLayer, width, interAxisLength, tolerance);
  mirror([0,0,1])
    translate([0,0,-interAxisLength/2-thickness/2-tolerance])
      U_branch(height, radius, nLayer, width, interAxisLength, tolerance);
}

module add_bottom_crossOlloHoles_to_U_frame(height=UFrameHeight, angle=45, nLayer=1) {

  thickness = ollo_segment_thickness(nLayer);

  difference () {
    children(0);
    translate([0, height-thickness/2, 0])
      rotate([90, angle, 0])
        crossOlloHoles(nLayer);
  }
}

module verticalize_U_frame(height=UFrameHeight) {
  translate([0,0,height])
    rotate([-90,0,0])
      for(i = [0 : $children - 1])
        children(i);
}

// Testing
echo("##########");
echo("In U_frame.scad");
echo("This file should not be included, use ''use <filemane>'' instead.");
echo("##########");

use <../dynamixel/xl320.scad>

p = 1;
nLayer = 1;
if (p==1) {
  xl320_two_horns();
  U_frame();

  translate([50,0,0])
    verticalize_U_frame()
      add_bottom_crossOlloHoles_to_U_frame(angle=45)
        U_frame();
}
