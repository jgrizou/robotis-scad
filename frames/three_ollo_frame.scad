include <frame_def.scad>

include <../ollo_segments/ollo_segments_def.scad>

use <../ollo/ollo_tools.scad>
use <../ollo_segments/ollo_straight_segment.scad>
use <../ollo_segments/ollo_xl320_segment.scad>;

use <../../MCAD/rotate.scad>;


module three_ollo_side_branch(length, nLayer=1, width=OlloSegmentWidth) {
  // length is the lenght between the center of the ollo holes
  straightSegmentLength = length - OlloSpacing;

  add_three_ollo_start_segment(nLayer, width)
    add_ollo_straight_segment(straightSegmentLength, nLayer, width)
      three_ollo_stop_segment(nLayer, width);
}

module three_ollo_frame(length, nLayer=1, width=OlloSegmentWidth) {

  thickness = ollo_segment_thickness(nLayer);

  rotate([0,90,0]){
    translate([0,0,-MotorWidth/2-thickness/2])
      three_ollo_side_branch(length, nLayer, width);
    mirror([0,0,1])
      translate([0,0,-MotorWidth/2-thickness/2])
        three_ollo_side_branch(length, nLayer, width);
  }
}

module add_three_ollo_frame(length, nLayer=1, width=OlloSegmentWidth) {
  three_ollo_frame(length, nLayer, width);
  translate([0, length, 0])
    for(i = [0 : $children - 1])
      children(i);
}

// Testing
echo("##########");
echo("In three_ollo_frame.scad");
echo("This file should not be included, use ''use <filemane>'' instead.");
echo("##########");

use <../dynamixel/xl320.scad>

p = 1;
if (p==1) {
  xl320();
  add_three_ollo_frame(50)
  translate([0,4*OlloSpacing,0])
    rotate([0,-90,0])
      xl320();
}
