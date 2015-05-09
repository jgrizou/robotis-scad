include <specific_frame_def.scad>

include <../ollo/ollo_def.scad>
include <../dynamixel/xl320_def.scad>
include <../ollo_segments/ollo_segments_def.scad>

use <../ollo/ollo_tools.scad>

use <../../lego-scad/lego_axle.scad>

use <../../MCAD/rotate.scad>;

module wheels_holes(withCableHole=true, nLayer=1, spaceBetweenHoles=3*OlloSpacing) {

  translate([0,spaceBetweenHoles/2,0])
    threeOlloHoles(nLayer=nLayer);
  translate([0,-spaceBetweenHoles/2,0])
    threeOlloHoles(nLayer=nLayer);

    if (withCableHole == true) {
      cube([1.5*OlloSpacing,2*OlloSpacing, ollo_segment_thickness(nLayer)], center=true);
    }
}

module passive_wheel(height=MotorWidth/2+legoWheelDiameter/2, diameter=25, spaceBetweenHoles=2*OlloSpacing) {

  difference() {
    translate([0,0,-height+diameter/2]) {
      cylinder(h=height-diameter/2, d=diameter);
      sphere(diameter/2);
    }
    translate([0,0,-ollo_segment_thickness(1)/2])
    wheels_holes(withCableHole=false, spaceBetweenHoles=2*OlloSpacing);
  }
}

module simple_wheel(diameter=2*OlloSegmentWidth, nLayer=1) {

  thickness = ollo_segment_thickness(nLayer);

  difference(){
    cylinder(h=thickness, d=diameter, center=true);
    crossOlloHoles(nLayer=nLayer);
  }
}

module ollo_to_lego_axle(axleLength=AxleLength, diameter=OlloSegmentWidth, nLayer=1) {

  thickness = ollo_segment_thickness(nLayer);

  difference(){
    cylinder(h=thickness, d=diameter, center=true);
    crossOlloHoles(nLayer=nLayer);
  }
  cylinder(h=thickness, d=OlloOutDiameter, center=true);

  rotate([0,0,45])
    lego_axle(axleLength);
}


module add_wheel(wheelType) {
  xl320();
  translate([0,0,MotorHeight/2+OlloLayerThickness]){
    if (wheelType == "simple")
      simple_wheel(diameter=WheelDiameter);
    if (wheelType == "lego")
        ollo_to_lego_axle(AxleLength);
  }
}

// Testing
echo("##########");
echo("In wheel_tools.scad");
echo("This file should not be included, use ''use <filemane>'' instead.");
echo("##########");

use <../dynamixel/xl320.scad>

p = 1;
if (p==1) {
  /*xl320();*/
  wheels_holes();

  translate([30,0,0])
    passive_wheel();

  translate([60,0,0])
    ollo_to_lego_axle();

  translate([0,50,0])
    add_wheel("simple");

  translate([30,50,0])
    add_wheel("lego");

}
