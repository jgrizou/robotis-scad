include <specific_frame_def.scad>

include <../ollo_segments/ollo_segments_def.scad>

use <../ollo_segments/ollo_straight_segment.scad>
use <../frames/side_to_side_frame.scad>

use <../../MCAD/rotate.scad>;

module side_4wheels_base_frame(motorWidthSpacing=4WheelsFrameWidthSpacing, motorLengthSpacing=4WheelsFrameLengthSpacing, middleBarWidth=4WheelsFrameMiddleBarWidth, nLayer=1) {

  thickness = ollo_segment_thickness(nLayer);

  translate([0,-motorLengthSpacing/2-1.5*OlloSpacing,0])
    translate([-motorWidthSpacing/2,0,0])
      side_branch(motorLengthSpacing, nSupport=0, nLayer=nLayer);
  rotate([0,0,90])
    ollo_straight_segment(motorWidthSpacing/2-OlloSegmentWidth/2, nLayer=nLayer, width=middleBarWidth);

}

module 4wheels_base_frame(motorWidthSpacing=4WheelsFrameWidthSpacing, motorLengthSpacing=4WheelsFrameLengthSpacing, middleBarWidth=4WheelsFrameMiddleBarWidth, nLayer=1) {

  thickness = ollo_segment_thickness(nLayer);

  side_4wheels_base_frame(motorWidthSpacing, motorLengthSpacing, middleBarWidth, nLayer);
  mirror([1,0,0])
    side_4wheels_base_frame(motorWidthSpacing, motorLengthSpacing, middleBarWidth, nLayer);

}

// Testing
echo("##########");
echo("In 4wheels_base_frame.scad");
echo("This file should not be included, use ''use <filemane>'' instead.");
echo("##########");

use <../dynamixel/xl320.scad>

p = 1;
nLayer = 1;
if (p==1) {
  4wheels_base_frame();
}
