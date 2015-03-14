include <frame_def.scad>

include <../ollo_segments/ollo_segments_def.scad>

use <../ollo/ollo_tools.scad>
use <../ollo_segments/ollo_straight_segment.scad>
use <../ollo_segments/ollo_horn_segment.scad>;

use <../../MCAD/rotate.scad>;


module horn_to_horn_side_branch(length, nLayer=1, width=OlloSegmentWidth, hornAngle=0) {
  // length is the lenght between the center of the ollo holes
  straightSegmentLength = length - width;

  add_ollo_horn_rounded_start_segment(nLayer, width, hornAngle)
    add_ollo_straight_segment(straightSegmentLength, nLayer, width)
      ollo_horn_rounded_stop_segment(nLayer, width, hornAngle);
}

module horn_to_horn_frame(length, nLayer=1, width=OlloSegmentWidth, hornAngle=0) {

  thickness = ollo_segment_thickness(nLayer);

  rotate([0,90,0]){
    translate([0,0,-MotorWidth/2-OlloLayerThickness-thickness/2])
      horn_to_horn_side_branch(length, nLayer, width, hornAngle);
    mirror([0,0,1])
      translate([0,0,-MotorWidth/2-OlloLayerThickness-thickness/2])
        horn_to_horn_side_branch(length, nLayer, width, hornAngle);
  }
}

module add_horn_to_horn_frame(length, nLayer=1, width=OlloSegmentWidth, hornAngle=0) {
  horn_to_horn_frame(length, nLayer, width, hornAngle);
  translate([0, length, 0])
    for(i = [0 : $children - 1])
      children(i);
}

// Testing
echo("##########");
echo("In horn_to_horn_frame.scad");
echo("This file should not be included, use ''use <filemane>'' instead.");
echo("##########");

use <../dynamixel/xl320.scad>

p = 1;
if (p==1) {
  add_horn_to_horn_frame(50)
    translate([MotorWidth/2,0,0])
      horn_to_horn_frame(30,2,30,45);
  /*cube([1,50,10]);*/
}
