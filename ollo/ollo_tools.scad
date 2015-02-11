include <ollo_def.scad>;

// One Ollo hole
module olloHole(nLayer=1, outerBottom=true, outerTop=true, innerDiameter=OlloInDiameter, outerDiameter=OlloOutDiameter)
{
  TotalThickness = ollo_nLayer_thickness(nLayer);

  if (outerBottom)
    translate([0, 0, -TotalThickness/2 + OlloTipThickness/2])
      cylinder(OlloTipThickness, outerDiameter/2, outerDiameter/2, center=true);

  cylinder(TotalThickness, innerDiameter/2, innerDiameter/2, center=true);

  if (outerTop)
    translate([0, 0, TotalThickness/2 - OlloTipThickness/2])
      cylinder(OlloTipThickness, outerDiameter/2, outerDiameter/2, center=true);
}

// 3 ollo holes (spacing as needed for motors)
module threeOlloHoles(nLayer=1, outerBottom=true, outerTop=true,  innerDiameter=OlloInDiameter, outerDiameter=OlloOutDiameter)
{
    for (xy=[[-OlloSpacing,0], [0,0], [OlloSpacing,0]]) {
      translate([xy[0], xy[1], 0])
        olloHole(nLayer, outerBottom, outerTop, innerDiameter, outerDiameter);
    }
}

// 5 ollo holes in a cross shape (spacing as needed for motor axes)
module crossOlloHoles(nLayer=1, outerBottom=true, outerTop=true, innerDiameter=OlloInDiameter, outerDiameter=OlloOutDiameter)
{
    threeOlloHoles(nLayer, outerBottom, outerTop, innerDiameter, outerDiameter);
    rotate([0, 0, 90])
      threeOlloHoles(nLayer, outerBottom, outerTop, innerDiameter, outerDiameter);
}

// Testing
echo("##########");
echo("In ollo_tools.scad");
echo("This file should not be included, use ''use <filemane>'' instead.");
echo("##########");

p = 3;
if (p == 1) olloHole();
if (p == 2) threeOlloHoles(2,true,false);
if (p == 3) crossOlloHoles(3,false,true);
