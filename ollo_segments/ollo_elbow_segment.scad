include <ollo_segment_def.scad>

use <../../segment-scad/elbow_segment.scad>

module ollo_elbow_segment(angle, radius, planar, nLayer=1, width=OlloSegmentWidth) {
  thickness = ollo_segment_thickness(nLayer);
  elbow_segment(angle, radius, width, thickness, planar);
}

module add_ollo_elbow_segment(angle, radius, planar, nLayer=1, width=OlloSegmentWidth) {
  thickness = ollo_segment_thickness(nLayer);
  add_elbow_segment(angle, radius, width, thickness, planar)
    for(i = [0 : $children - 1])
      children(i);

}

// Testing
echo("##########");
echo("In ollo_elbow_segment.scad");
echo("This file should not be included, use ''use <filemane>'' instead.");
echo("##########");

p = 2;
nLayer = 2;

if (p==1){
  ollo_elbow_segment(angle=270, radius=50, planar=true, nLayer=nLayer);
  ollo_elbow_segment(angle=180, radius=50, planar=false, nLayer=nLayer);
  ollo_elbow_segment(angle=-90, radius=100, planar=true, nLayer=nLayer);
  ollo_elbow_segment(angle=-90, radius=100, planar=false, nLayer=nLayer);
}
if (p==2) {
  add_ollo_elbow_segment(90, 20, planar=false, nLayer=nLayer)
    add_ollo_elbow_segment(-90, 20, planar=true, nLayer=nLayer)
      add_ollo_elbow_segment(90, 20, planar=false, nLayer=nLayer)
        add_ollo_elbow_segment(-90, 20, planar=true, nLayer=nLayer)
          add_ollo_elbow_segment(90, 20, planar=false, nLayer=nLayer)
            ollo_elbow_segment(-90, 20, planar=true, nLayer=nLayer, width=OlloSegmentWidth/2);
}
