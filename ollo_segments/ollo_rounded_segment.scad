include <ollo_segments_def.scad>

use <../../segment-scad/rounded_segment.scad>

module ollo_rounded_start_segment(nLayer=1, width=OlloSegmentWidth) {
  thickness = ollo_segment_thickness(nLayer);
  rounded_start_segment(width, thickness);
}

module add_ollo_rounded_start_segment(nLayer=1, width=OlloSegmentWidth) {
  ollo_rounded_start_segment(nLayer, width);
  for(i = [0 : $children - 1])
    children(i);
}

module ollo_rounded_stop_segment(nLayer=1, width=OlloSegmentWidth) {
  thickness = ollo_segment_thickness(nLayer);
  rounded_stop_segment(width, thickness);
}

module add_ollo_rounded_stop_segment(nLayer=1, width=OlloSegmentWidth) {
  ollo_rounded_stop_segment(nLayer, width);
  for(i = [0 : $children - 1])
    children(i);
}

// Testing
echo("##########");
echo("In ollo_rounded_segment.scad");
echo("This file should not be included, use ''use <filemane>'' instead.");
echo("##########");

p = 1;
if (p==1) {
  add_ollo_rounded_start_segment()
    ollo_rounded_stop_segment();
}
