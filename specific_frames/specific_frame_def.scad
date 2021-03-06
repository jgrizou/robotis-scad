include <../frames/frame_def.scad>
include <../dynamixel/xl320_def.scad>
include <../ollo_segments/ollo_segments_def.scad>

include <../../raspberry-scad/raspberry_pi_Bplus_def.scad>

CircularBaseFrameRadius = 50;
CircularBaseFrameHeight = MotorHeight/2;

PenHolderInnerDiameter = 12;

CylinderHeadRadius = CircularBaseFrameRadius/2;

LampHeadStartRadius = 20;
LampHeadEndRadius = 35;
LampHeadLength = 50;

RaspberryPiBplusFrameWidth = RaspberryPiBplusLength;

RaspberryPiBplusFrameDistanceBoardToMotor = 10;
RaspberryPiBplusFrameDistanceMotorToEnd = 30;
RaspberryPiBplusFrameEndWidth = MotorWidth + 10;

RaspberryPiBplusFrameCameraDistFromEnd = 15;

RaspberryPiBplusFrameLenght = RaspberryPiBplusWidth + RaspberryPiBplusFrameDistanceBoardToMotor + MotorLength + RaspberryPiBplusFrameDistanceMotorToEnd;

RaspberryPiBplusFrameCornerRadius = 3;

RaspberryPiBplusFrameHeight = CircularBaseFrameHeight + 1;

RaspberryPiBplusFramecameraDistFromEnd = 10;

RaspberryPiBplusHolderFrameDistSupportToBoard = RaspberryPiBplusSDCardOutter;
RaspberryPiBplusHolderFrameLength = RaspberryPiBplusLength + RaspberryPiBplusHolderFrameDistSupportToBoard;
RaspberryPiBplusHolderFrameSupportHeight = 3*OlloSpacing;


legoWheelDiameter = 30.5;
WheelDiameter = legoWheelDiameter;
AxleLength = 15;


4WheelsFrameWidthSpacing = 2.5*MotorHeight;
4WheelsFrameLengthSpacing = 2*MotorLength;
4WheelsFrameMiddleBarWidth = OlloSegmentWidth;


FlowerPotOlloAttachDepth = 10;
FlowerPotOlloAttachInternalRaidus = CircularBaseFrameRadius - OlloSpacing;
FlowerPotOlloAttachPointRadius = CircularBaseFrameRadius - OlloSpacing/2;

BasicFlowerPotFrameSpaceRpiToBottom = 40;
BasicFlowerPotFrameHeight = RaspberryPiBplusHolderFrameLength + FlowerPotOlloAttachDepth + OlloLayerThickness+ BasicFlowerPotFrameSpaceRpiToBottom;
BasicFlowerPotFrameInternalTopRadius = CircularBaseFrameRadius + 10;
BasicFlowerPotFrameInternalBaseRadius = RaspberryPiBplusWidth/2 + 10;
BasicFlowerPotFrameWallThickness = OlloLayerThickness;

BasicFlowerPotFrameBandDistFromTop = 30;
BasicFlowerPotFrameBandThickness = 3*OlloLayerThickness;

BasicFlowerPotFrameOpeningBottomDiameter = 20;
BasicFlowerPotFrameOpeningBottomHeight = BasicFlowerPotFrameOpeningBottomDiameter/2 + OlloLayerThickness;
