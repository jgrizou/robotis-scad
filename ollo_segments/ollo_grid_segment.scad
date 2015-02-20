include <ollo_segments_def.scad>
include <../ollo/ollo_def.scad>;

use <ollo_straight_segment.scad>;

use <../ollo/ollo_tools.scad>;

use <../../MCAD/rotate.scad>;

module ollo_hole_segment(nLayer=1, outerBottom=true, outerTop=true,  innerDiameter=OlloInDiameter, outerDiameter=OlloOutDiameter) {

  thickness = ollo_segment_thickness(nLayer);

  translate([0,OlloSpacing/2,0])
    difference () {
        cube([OlloSpacing, OlloSpacing, thickness], center=true);

      olloHole(nLayer, outerBottom, outerTop, innerDiameter, outerDiameter);
    }
}


module ollo_grid_segment(XYGridSize=[1,1], nLayer=1, , outerBottom=true, outerTop=true, innerDiameter=OlloInDiameter, outerDiameter=OlloOutDiameter) {

  thickness = ollo_segment_thickness(nLayer);

  translate([-(XYGridSize[0]-1)*OlloSpacing/2, 0, 0])
    for ( i = [0 : XYGridSize[0]-1]) {
      for ( j = [0 : XYGridSize[1]-1]) {
        translate([i*OlloSpacing, j*OlloSpacing, 0])
          ollo_hole_segment(nLayer, outerBottom, outerTop, innerDiameter, outerDiameter);
      }
    }
}


// Testing
echo("##########");
echo("In ollo_grid_segment.scad");
echo("This file should not be included, use ''use <filemane>'' instead.");
echo("##########");

p = 1;
nLayer = 1;
if (p==1) {
  ollo_grid_segment([5,5],2);
}
