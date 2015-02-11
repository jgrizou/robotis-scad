include <ollo_segment_def.scad>

use <../../segment-scad/straight_segment.scad>

module ollo_straight_segment(length, nLayer=1, width=OlloSegmentWidth) {
  thickness = ollo_segment_thickness(nLayer);
  straight_segment(length, width, thickness);
}

module add_ollo_straight_segment(length, nLayer=1, width=OlloSegmentWidth) {
  thickness = ollo_segment_thickness(nLayer);
  add_straight_segment(length, width, thickness)
    for(i = [0 : $children - 1])
      children(i);
}

// Testing
echo("##########");
echo("In ollo_straight_segment.scad");
echo("This file should not be included, use ''use <filemane>'' instead.");
echo("##########");

p = 1;
if (p==1) {
  add_ollo_straight_segment(10)
    ollo_straight_segment(100,3,50);
}
