include <frame_def.scad>

include <../dynamixel/xl320_def.scad>
include <../ollo/ollo_def.scad>
include <../ollo_segments/ollo_segments_def.scad>

use <../ollo/ollo_tools.scad>
use <../ollo_segments/ollo_straight_segment.scad>
use <../ollo_segments/ollo_elbow_segment.scad>
use <../ollo_segments/ollo_horn_segment.scad>
use <../ollo_segments/ollo_xl320_segment.scad>;

use <../../MCAD/rotate.scad>;

module U_three_ollo_to_horn_frame(length=MotorAxisOffset+ollo_segment_thickness(1)+FrameTolerance, radius=ollo_segment_thickness(1)/2, hornAngle=0, nLayer=1, width=OlloSegmentWidth, interAxisLength=MotorWidth, tolerance=FrameTolerance) {
  // length is the lenght between the center of the ollo holes and the top of the frame
  // radius is the curvature of the U
  // hornAngle is the orientation of the crossOlloHole

  thickness = ollo_segment_thickness(nLayer);
  sideStraightSegmentLength = length-radius-(thickness/2)-(OlloSpacing/2);
  bottomStraightSegmentLength = interAxisLength-(2*radius)+thickness+2*tolerance;

  translate([-interAxisLength/2-thickness/2-tolerance,0,0])
    rotate([0,90,0])
      add_three_ollo_start_segment(nLayer, width)
        add_ollo_straight_segment(sideStraightSegmentLength, nLayer, width)
          add_ollo_elbow_segment(90, radius, false, nLayer, width)
            add_ollo_horn_straight_segment(bottomStraightSegmentLength, nLayer, width, hornAngle)
              add_ollo_elbow_segment(90, radius, false, nLayer, width)
                add_ollo_straight_segment(sideStraightSegmentLength, nLayer, width)
                  three_ollo_stop_segment(nLayer, width);
}

module add_U_three_ollo_to_horn_frame(length=MotorAxisOffset+ollo_segment_thickness(1)+FrameTolerance, radius=ollo_segment_thickness(1)/2, hornAngle=0, nLayer=1, width=OlloSegmentWidth, interAxisLength=MotorWidth, tolerance=FrameTolerance) {
  // length is the lenght between the center of the ollo holes and the top of the frame
  // radius is the curvature of the U
  // hornAngle is the orientation of the crossOlloHole

  U_three_ollo_to_horn_frame(length, radius, hornAngle, nLayer, width, interAxisLength, tolerance);
  translate([0, length, 0])
    for(i = [0 : $children - 1])
      children(i);
}



// Testing
echo("##########");
echo("In U_three_ollo_to_horn_frame.scad");
echo("This file should not be included, use ''use <filemane>'' instead.");
echo("##########");

use <../dynamixel/xl320.scad>

p = 1;
nLayer = 1;
if (p==1) {
  xl320();
  add_U_three_ollo_to_horn_frame(15, 1.5)
    translate([0,MotorWidth/2+OlloLayerThickness,0])
      rotate([90,0,0])
        xl320();
}
