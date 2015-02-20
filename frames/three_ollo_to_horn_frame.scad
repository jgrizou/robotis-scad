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


module three_ollo_to_horn_side_branch(length, angle, radius, hornAngle, ratioLengthFirstSegment, nLayer, width) {
  // length is the lenght between the center of the ollo holes
  // radius is the curvature of the transition
  // angle is the smoothness of the transition

  // TODO: all the following computation should be put in a specific segment module!
  // with an instance as a ollo_segment

  diffHeight = OlloLayerThickness;
  diffHeightElbow = abs((cos(angle)-1)*radius*2);

  zLenghtNeeded = diffHeight - diffHeightElbow;
  if (zLenghtNeeded < 0) {
    echo("## WARNING ##");
    echo();
    echo("In three_ollo_to_horn_frame: impossible combination of angle and radius");
    echo();
    echo("#############");
  }

  middleSegmentLenght = zLenghtNeeded / cos(90-angle);

  xLenghtAdded = middleSegmentLenght * sin(90-angle);
  diffLengthElbow = (sin(angle) - sin(-angle)) * radius + xLenghtAdded;

  totalLenghtToCover = length-diffLengthElbow-OlloSpacing;

  firstSegmentLength = totalLenghtToCover * ratioLengthFirstSegment;
  if (firstSegmentLength < 0) {
    echo("## WARNING ##");
    echo();
    echo("In three_ollo_to_horn_frame: impossible combination of angle and radius");
    echo();
    echo("#############");
  }

  secondSegmentLength = (totalLenghtToCover - firstSegmentLength) - width/2 + OlloSpacing/2;
  if (secondSegmentLength < 0) {
    echo("## WARNING ##");
    echo();
    echo("In three_ollo_to_horn_frame: impossible combination of width, angle and radius");
    echo();
    echo("#############");
  }

  add_three_ollo_start_segment(nLayer, width)
    add_ollo_straight_segment(firstSegmentLength, nLayer, width)
      add_ollo_elbow_segment(-angle, radius, false, nLayer, width)
        add_ollo_straight_segment(middleSegmentLenght, nLayer, width)
          add_ollo_elbow_segment(angle, radius, false, nLayer, width)
            add_ollo_straight_segment(secondSegmentLength, nLayer, width)
              ollo_horn_rounded_stop_segment(nLayer, width, hornAngle);
}

module three_ollo_to_horn_frame(length, angle=25, radius=5, hornAngle=0, ratioLengthFirstSegment=0.5, nLayer=1, width=OlloSegmentWidth) {

  thickness = ollo_segment_thickness(nLayer);

  rotate([0,90,0]){
    translate([0,0,-MotorWidth/2-thickness/2])
      three_ollo_to_horn_side_branch(length, angle, radius, hornAngle, ratioLengthFirstSegment, nLayer, width);
    mirror([0,0,1])
      translate([0,0,-MotorWidth/2-thickness/2])
      three_ollo_to_horn_side_branch(length, angle, radius, hornAngle, ratioLengthFirstSegment, nLayer, width);
  }
}

module add_three_ollo_to_horn_frame(length, angle=25, radius=5, hornAngle=0, ratioLengthFirstSegment=0.5, nLayer=1, width=OlloSegmentWidth) {

  three_ollo_to_horn_frame(length, angle, radius, hornAngle, ratioLengthFirstSegment, nLayer, width);
  translate([0,length,0])
    for(i = [0 : $children - 1])
      children(i);
}



// Testing
echo("##########");
echo("In three_ollo_to_horn_frame.scad");
echo("This file should not be included, use ''use <filemane>'' instead.");
echo("##########");

use <../dynamixel/xl320.scad>

p = 1;
nLayer = 1;
if (p==1) {
    xl320();
    add_three_ollo_to_horn_frame(length=30, nLayer=1)
      rotate([0,90,180])
        xl320_two_horns();
}
