include <frame_def.scad>

include <../dynamixel/xl320_def.scad>
include <../ollo/ollo_def.scad>
include <../ollo_segments/ollo_segments_def.scad>

use <U_horn_frame.scad>;

use <../../MCAD/rotate.scad>;

module U_horn_to_U_horn_frame(length, motorAngle=90, nLayer=1, width=OlloSegmentWidth, tolerance=FrameTolerance) {

  thickness = ollo_segment_thickness(nLayer);
  singleLength = length/2 + thickness/2;

  U_horn_frame(singleLength);
  translate([0,length,0])
    rotate([0,0,180])
      rotate([0,motorAngle,0])
        U_horn_frame(singleLength);
}


module add_U_horn_to_U_horn_frame(length, motorAngle=90, nLayer=1, width=OlloSegmentWidth, tolerance=FrameTolerance) {


  U_horn_to_U_horn_frame(length, motorAngle, nLayer, width, tolerance);
  translate([0, length, 0])
    rotate([0,-motorAngle,0])
      for(i = [0 : $children - 1])
        children(i);
}


// Testing
echo("##########");
echo("In U_horn_to_U_horn_frame.scad");
echo("This file should not be included, use ''use <filemane>'' instead.");
echo("##########");

use <../dynamixel/xl320.scad>

p = 1;
if (p==1) {
  xl320_two_horns();
    add_U_horn_to_U_horn_frame(50)
      rotate([0,0,180])
        xl320_two_horns();
}
