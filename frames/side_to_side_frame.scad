include <frame_def.scad>

include <../dynamixel/xl320_def.scad>
include <../ollo/ollo_def.scad>
include <../ollo_segments/ollo_segments_def.scad>

use <../ollo/ollo_tools.scad>
use <../ollo_segments/ollo_straight_segment.scad>
use <../ollo_segments/ollo_elbow_segment.scad>
use <../ollo_segments/ollo_xl320_segment.scad>;

use <../../MCAD/rotate.scad>;



module side_branch(length, nSupport, nLayer, width, tolerance) {
  // length is the lenght between the motors
  // nSupport is the number of elements joining both side
  thickness = ollo_segment_thickness(nLayer);
  straightSegmentLength = length - 4*OlloSpacing;

  add_ollo_xl320_side_start_segment(nLayer, width)
    add_ollo_straight_segment(straightSegmentLength, nLayer, width)
      ollo_xl320_side_stop_segment(nLayer, width);

  // support
  // TODO: all the following defintiion can be simpliest by finding first the middle (as the middle of the all swgment), then the range.
  distToFrontBox = 3*OlloSpacing + MotorAxisOffset;
  distToMiddleBox = distToFrontBox - MotorLength/2;
  distFirstSupport =  distToMiddleBox + SideToSideFrameSupportMargin;

  distToMiddle = length - MotorAxisOffset + MotorLength/2;
  distLastSupport = distToMiddle - SideToSideFrameSupportMargin - thickness;
  deltaSupportRange = distLastSupport - distFirstSupport;
  distMiddleSupport = distFirstSupport + deltaSupportRange/2;

  spaceBetweenSupport = deltaSupportRange/(nSupport+1);

  if (nSupport > 0) {
    translate([0,distFirstSupport,0]) {
      for ( i = [1 : nSupport] )
      {
        translate([0,i*spaceBetweenSupport,0])
          add_ollo_elbow_segment(90, thickness/2, false, nLayer, width)
            ollo_straight_segment(MotorWidth/2+tolerance, nLayer, width);
      }
    }
  }
}

module side_to_side_frame(length, nSupport=1, nLayer=1, width=OlloSegmentWidth, tolerance=FrameTolerance) {

  thickness = ollo_segment_thickness(nLayer);

  rotate([0,90,0]){
    translate([0,0,-MotorWidth/2-thickness/2-tolerance])
      side_branch(length, nSupport, nLayer, width, tolerance);
    mirror([0,0,1])
      translate([0,0,-MotorWidth/2-thickness/2-tolerance])
        side_branch(length, nSupport, nLayer, width, tolerance);
  }
}

module add_side_to_side_frame(length,nSupport=1, nLayer=1, width=OlloSegmentWidth, tolerance=FrameTolerance) {

  side_to_side_frame(length, nSupport, nLayer, width, tolerance);
  translate([0,length+3*OlloSpacing,0])
    for(i = [0 : $children - 1])
      children(i);
}


// Testing
echo("##########");
echo("In side_to_side_frame.scad");
echo("This file should not be included, use ''use <filemane>'' instead.");
echo("##########");

use <../dynamixel/xl320.scad>

p = 1;
nLayer = 1;
if (p==1) {

  /*cube([1,118/2,10]);*/

  rotate([0,0,180]) xl320();
  add_side_to_side_frame(100,2)
    xl320();

}
