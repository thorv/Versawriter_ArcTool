import controlP5.*;

ControlP5 cp5;
Slider thetaSlider;
Slider deltaSlider;
Slider rpsSlider;
Slider radiusSlider;
Slider pixPeriodSlider;
Button rotatePic, invertPic, saveButton;

void deployGuiParts(){
  cp5=new ControlP5(this);
  rotatePic= cp5.addButton("rotPic")
    .setCaptionLabel("Rotate 90deg")
    .setPosition( (int)(height+(width-height*2)*0.1), 30 )
    .setSize( (int)((width-height*2)*0.3), 20);
  rotatePic.getCaptionLabel()
    .toUpperCase(false);
  invertPic= cp5.addButton("invPic")
    .setCaptionLabel("MIRROR")
    .setPosition( (int)(height+(width-height*2)*0.6), 30 )
    .setSize( (int)((width-height*2)*0.3), 20);

  thetaSlider=cp5.addSlider("theta")
    .setLabel("Position (deg)")
    .setRange(-180, 180)
    .setValue(theta)
    .setPosition((int)(height+(width-height*2)*0.1), 80)
    .setSize( (int)((width-height*2)*0.8), 20);
  thetaSlider.getCaptionLabel()
    .align(ControlP5.CENTER, ControlP5.BOTTOM_OUTSIDE)
    .toUpperCase(false)
    .setColor(color(0))
    .setSize(13);

  deltaSlider=cp5.addSlider("delta")
    .setLabel("Range (deg)")
    .setRange(10, 360)
    .setValue(delta)
    .setPosition((int)(height+(width-height*2)*0.1), 130)
    .setSize( (int)((width-height*2)*0.8), 20);
  deltaSlider.getCaptionLabel()
    .align(ControlP5.CENTER, ControlP5.BOTTOM_OUTSIDE)
    .toUpperCase(false)
    .setColor(color(0))
    .setSize(13);

  radiusSlider=cp5.addSlider("radius")
    .setLabel("Radius (cm)")
    .setRange(50, 150)
    .setValue(radius)
    .setPosition((int)(height+(width-height*2)*0.1), 180)
    .setSize( (int)((width-height*2)*0.8), 20);
  radiusSlider.getCaptionLabel()
    .align(ControlP5.CENTER, ControlP5.BOTTOM_OUTSIDE)
    .toUpperCase(false)
    .setColor(color(0))
    .setSize(13);

  rpsSlider=cp5.addSlider("rps")
    .setLabel("Round per Second")
    .setRange(0.2, 5)
    .setValue(rps)
    .setPosition((int)(height+(width-height*2)*0.1), 230)
    .setSize( (int)((width-height*2)*0.8), 20);
  rpsSlider.getCaptionLabel()
    .align(ControlP5.CENTER, ControlP5.BOTTOM_OUTSIDE)
    .toUpperCase(false)
    .setColor(color(0))
    .setSize(13);

  pixPeriodSlider=cp5.addSlider("pixTime")
    .setLabel("Pixel period (ms)")
    .setRange(0.4, 2.3)
    .setValue(pixTime)
    .setPosition((int)(height+(width-height*2)*0.1), 280)
    .setSize( (int)((width-height*2)*0.8), 20);
  pixPeriodSlider.getCaptionLabel()
    .align(ControlP5.CENTER, ControlP5.BOTTOM_OUTSIDE)
    .toUpperCase(false)
    .setColor(color(0))
    .setSize(13);
    
  saveButton=cp5.addButton("saveDialog")
    .setCaptionLabel("SAVE")
    .setPosition( (int)(height+(width-height*2)*0.1), height-50 )
    .setSize( (int)((width-height*2)*0.8), 20);
}
