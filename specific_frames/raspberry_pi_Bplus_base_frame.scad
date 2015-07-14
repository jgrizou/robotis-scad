include <specific_frame_def.scad>

include <../ollo/ollo_def.scad>
include <../dynamixel/xl320_def.scad>
include <../ollo_segments/ollo_segments_def.scad>

include <../../raspberry-scad/raspberry_pi_Bplus_def.scad>

use <base_frame.scad>
use <wheel_tools.scad>

use <../ollo/ollo_tools.scad>
use <../frames/U_horn_to_horn_frame.scad>

use <../../segment-scad/elliptic_segment.scad>
use <../../raspberry-scad/raspberry_pi_Bplus_tools.scad>

use <../../MCAD/rotate.scad>;
use <../../MCAD/rounded_cube.scad>;

module raspberry_pi_Bplus_plate_sharp(nLayer=1) {

  thickness = ollo_segment_thickness(nLayer);

  translate([0,-RaspberryPiBplusWidth/2,0]){
    linear_extrude(height=thickness) {
        polygon(points=[[-RaspberryPiBplusFrameWidth/2,0], [-RaspberryPiBplusFrameWidth/2,RaspberryPiBplusWidth+RaspberryPiBplusFrameDistanceBoardToMotor], [-RaspberryPiBplusFrameEndWidth/2,RaspberryPiBplusFrameLenght], [RaspberryPiBplusFrameEndWidth/2,RaspberryPiBplusFrameLenght], [RaspberryPiBplusFrameWidth/2,RaspberryPiBplusWidth+RaspberryPiBplusFrameDistanceBoardToMotor], [RaspberryPiBplusFrameWidth/2,0]], paths=[[0,1,2,3,4,5]]);
    }
  }
}

module raspberry_pi_Bplus_plate(cornerRadius=RaspberryPiBplusFrameCornerRadius, nLayer=1) {

  thickness = ollo_segment_thickness(nLayer);

  if (cornerRadius > 0) {
    translate([0,-RaspberryPiBplusWidth/2,0]){
      minkowski() {
        linear_extrude(height=thickness/2) {
            polygon(points=[[-RaspberryPiBplusFrameWidth/2+cornerRadius,cornerRadius], [-RaspberryPiBplusFrameWidth/2+cornerRadius,RaspberryPiBplusWidth+RaspberryPiBplusFrameDistanceBoardToMotor], [-RaspberryPiBplusFrameEndWidth/2+cornerRadius,RaspberryPiBplusFrameLenght-cornerRadius], [RaspberryPiBplusFrameEndWidth/2-cornerRadius,RaspberryPiBplusFrameLenght-cornerRadius], [RaspberryPiBplusFrameWidth/2-cornerRadius,RaspberryPiBplusWidth+RaspberryPiBplusFrameDistanceBoardToMotor], [RaspberryPiBplusFrameWidth/2-cornerRadius,cornerRadius]], paths=[[0,1,2,3,4,5]]);
        }
        cylinder(h=thickness/2, r=cornerRadius);
      }
    }
  } else {
    raspberry_pi_Bplus_plate_sharp(nLayer=nLayer);
  }
}

module raspberry_pi_Bplus_base_frame(baseHeight=RaspberryPiBplusFrameHeight,boardHeight=5, holeType="spike", cornerRadius=RaspberryPiBplusFrameCornerRadius, cameraDistFromEnd=RaspberryPiBplusFrameCameraDistFromEnd, nLayer=1, withHole=true) {

  thickness = ollo_segment_thickness(nLayer);

  baseYPos = RaspberryPiBplusWidth/2 + RaspberryPiBplusFrameDistanceBoardToMotor + MotorLength - MotorAxisOffset;

  translate([0,0,-baseHeight+MotorHeight/2]) {
    raspberry_pi_Bplus_plate(cornerRadius, nLayer);

    translate([0,baseYPos,baseHeight+thickness])
      base_frame(baseHeight, withHole=withHole);

    translate([0,0,thickness])
      raspberry_pi_Bplus_hole_support(boardHeight, holeType, center=true);

    translate([0,RaspberryPiBplusFrameLenght-RaspberryPiBplusWidth/2-cameraDistFromEnd,thickness])
      add_raspberry_camera_holder();
  }
}

module raspberry_pi_Bplus_base_frame_with_raspberry_board(baseHeight=RaspberryPiBplusFrameHeight,boardHeight=5, holeType="spike", cornerRadius=RaspberryPiBplusFrameCornerRadius, nLayer=1) {

  raspberry_pi_Bplus_base_frame(baseHeight=baseHeight);

  translate([0,0,ollo_segment_thickness(nLayer)+boardHeight-baseHeight+MotorHeight/2])
    add_raspberry_pi_Bplus();

}

module circular_vertical_raspberry_pi_Bplus_base_frame(baseHeight=RaspberryPiBplusFrameHeight, radius=CircularBaseFrameRadius, boardHeight=0, boardDistFromCenter=7+MotorHeight/2+2*OlloLayerThickness, cameraDistFromCenter=12+MotorLength-MotorAxisOffset, nLayer=1) {

  rotate([0,0,180])
    circular_base_frame(radius=CircularBaseFrameRadius, height=baseHeight, withHole=true);

  /*difference() {*/
    translate([0,-boardDistFromCenter,-baseHeight])
      add_side_support(boardHeight);
    /*translate([0,0,-MotorHeight/2])
      rotate([90,0,0])
        elliptic_segment(RaspberryPiBplusWidth, width=4*CircularBaseFrameRadius, heigth=4*CircularBaseFrameRadius, wallThickness=CircularBaseFrameRadius);
  }*/
  translate([0,cameraDistFromCenter,-baseHeight])
    add_raspberry_camera_holder(boardHeight);
}

module circular_vertical_raspberry_pi_Bplus_base_frame_with_raspberry_board(baseHeight=RaspberryPiBplusFrameHeight, radius=CircularBaseFrameRadius, boardHeight=0, boardDistFromCenter=7+MotorHeight/2+2*OlloLayerThickness, cameraDistFromCenter=12+MotorLength-MotorAxisOffset, nLayer=1) {

  circular_vertical_raspberry_pi_Bplus_base_frame(baseHeight, radius, boardHeight, boardDistFromCenter, cameraDistFromCenter, nLayer);

  rotate([-90,0,180])
    translate([0,-boardHeight-RaspberryPiBplusWidth/2+baseHeight,boardDistFromCenter])
      add_raspberry_pi_Bplus();
}



module raspberry_pi_Bplus_base_frame_with_wheels_and_battery_holes(baseHeight=RaspberryPiBplusFrameHeight) {

  difference() {
    raspberry_pi_Bplus_base_frame(baseHeight=baseHeight);

    translate([RaspberryPiBplusFrameWidth/2-MotorHeight/2,0,MotorHeight/2-baseHeight+ollo_segment_thickness(1)/2]){
      wheels_holes();
      translate([0,6*OlloSpacing,0]){
        threeOlloHoles();
        translate([-OlloSpacing,3*OlloSpacing,0])
          rotate([0,0,90])
            threeOlloHoles();
      }
    }

    translate([-RaspberryPiBplusFrameWidth/2+MotorHeight/2,0,MotorHeight/2-baseHeight+ollo_segment_thickness(1)/2]){
      wheels_holes();
      translate([0,6*OlloSpacing,0]){
        threeOlloHoles();
        translate([OlloSpacing,3*OlloSpacing,0])
          rotate([0,0,90])
            threeOlloHoles();
      }
    }


    translate([0,RaspberryPiBplusFrameLenght-RaspberryPiBplusWidth/2-RaspberryPiBplusFrameCameraDistFromEnd,MotorHeight/2-baseHeight+ollo_segment_thickness(1)/2])
      wheels_holes(withCableHole=false, spaceBetweenHoles=2*OlloSpacing);

  }
}

module raspberry_pi_Bplus_holder_frame(baseHeight=OlloLayerThickness, baseLength=RaspberryPiBplusHolderFrameLength, distSupportToBoard=RaspberryPiBplusHolderFrameDistSupportToBoard, supportHeight=RaspberryPiBplusHolderFrameSupportHeight , nLayer=1) {

  thickness = ollo_segment_thickness(nLayer);

  difference() {
    union() {

      // support plate
      difference() {
        translate([-distSupportToBoard/2,0,-thickness/2])
          rounded_cube(baseLength, RaspberryPiBplusWidth, thickness, RaspberryPiBplusHolesDiameter, center=true);

        translate([0,0,-thickness/2]){

          translate([-RaspberryPiBplusLength/2-distSupportToBoard+thickness+OlloSpacing/2,0,0])

            for (i = [0 : 2*OlloSpacing : baseLength ]){
              translate([i,0,0]){
                echo(i);
                if (i == 10*OlloSpacing) {
                  gridOlloHoles([1,7], nLayer=nLayer);
                } else {
                  gridOlloHoles([1,9], nLayer=nLayer);
                }
              }
            }
        }
      }

      // holder from the top
      translate([-RaspberryPiBplusLength/2-distSupportToBoard+thickness/2,0,1.5*OlloSpacing-thickness]){
        rotate([0,90,0])
          difference() {
            rounded_cube(RaspberryPiBplusHolderFrameSupportHeight, RaspberryPiBplusWidth+2*OlloSpacing, thickness, RaspberryPiBplusHolesDiameter, center=true);

            translate([0,RaspberryPiBplusWidth/2+OlloSpacing/2,0])
              threeOlloHoles();

            translate([0,-RaspberryPiBplusWidth/2-OlloSpacing/2,0])
              threeOlloHoles();

            rounded_cube(RaspberryPiBplusHolderFrameSupportHeight-2*thickness, RaspberryPiBplusWidth, thickness, RaspberryPiBplusHolesDiameter, center=true);

          }
      }

      // raspberry plot support
      raspberry_pi_Bplus_hole_support(baseHeight, "screw");
    }

    // holes inside support plate
    translate([0,0,-thickness])
      raspberry_pi_Bplus_hole_support(thickness, "hole");
  }
}

// Testing
echo("##########");
echo("In raspberry_pi_Bplus_base_frame.scad");
echo("This file should not be included, use ''use <filemane>'' instead.");
echo("##########");

use <../dynamixel/xl320.scad>

p = 2;
baseHeight = RaspberryPiBplusFrameHeight;
if (p==1) {
  raspberry_pi_Bplus_base_frame_with_raspberry_board();

  translate([150,0,0]) {
    circular_vertical_raspberry_pi_Bplus_base_frame_with_raspberry_board();
    rotate([0,0,180]){
      xl320();
      translate_to_xl320_top()
        verticalize_U_horn_to_horn_frame(30){
          rotate([0,60,0]){
            U_horn_to_horn_frame(30);
              xl320_two_horns();
          }
        }
    }
  }

  translate([-150,0,0]) {
    raspberry_pi_Bplus_base_frame_with_wheels_and_battery_holes(baseHeight);

    translate([0,RaspberryPiBplusWidth+RaspberryPiBplusFrameDistanceBoardToMotor,MotorHeight/2+ollo_segment_thickness(1)])
      xl320();
    translate([0,RaspberryPiBplusFrameLenght-RaspberryPiBplusWidth/2-RaspberryPiBplusFrameCameraDistFromEnd,-baseHeight+MotorHeight/2])
      passive_wheel();

    translate([-RaspberryPiBplusFrameWidth/2+MotorHeight/2,1.5*OlloSpacing,-baseHeight])
      rotate([0,-90,0])
        add_wheel("lego");

    translate([RaspberryPiBplusFrameWidth/2-MotorHeight/2,1.5*OlloSpacing,-baseHeight])
      rotate([0,90,0])
        add_wheel("lego");
  }
}
baseHeight=OlloLayerThickness;
if (p==2) {
  raspberry_pi_Bplus_holder_frame(baseHeight);
  translate([0,0,baseHeight])
    add_raspberry_pi_Bplus();
}
