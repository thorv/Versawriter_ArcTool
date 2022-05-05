// メッセージダイアログ表示のためのimport
import static javax.swing.JOptionPane.*;      

void mouseWheel(MouseEvent ev) {
  if (mouseX<height) {
    if (ev.getAmount()>0) {
      imgSize*=0.99;
    } else {
      imgSize*=1.01;
    }
  }
}

void mouseDragged() {
  if (mouseX<height) {
    imgX+=mouseX-pmouseX;
    imgY+=mouseY-pmouseY;
  }
  imgX=constrain(imgX,int(-img.width*imgSize/2),int(height+img.width*imgSize/2));
  imgY=constrain(imgY,int(-img.height*imgSize/2),int(height+img.height*imgSize/2));
}

void saveDialog(int val) {
  selectOutput("SAVE", "fileSelected");
}

void execSave() {
  PGraphics saveImg=createGraphics(outImg.width, outImg.height);
  saveImg.beginDraw();
  saveImg.translate(0, saveImg.height);
  saveImg.scale(1, -1);
  saveImg.image(outImg,0,0);
  saveImg.endDraw();
  saveImg.save(saveFile);
  saveFlag=false;
}

void fileSelected(File file) {
  if (file!=null) {
    try {
      saveFile=file.getAbsolutePath();
      saveFlag=true;
    }
    catch(Exception ex) {
      showMessageDialog(null, "File ERROR...", 
        "Error", ERROR_MESSAGE);
    }
  }
}

void rotPic( int val ){
  PGraphics tmp=createGraphics(img.height,img.width);
  tmp.beginDraw();
  tmp.translate(tmp.width,0);
  tmp.rotate(HALF_PI);
  tmp.image(img,0,0);
  tmp.endDraw();
  img=tmp;
}

void invPic( int val ){
  PGraphics tmp=createGraphics(img.width,img.height);
  tmp.beginDraw();
  tmp.translate(tmp.width,0);
  tmp.scale(-1,1);
  tmp.image(img,0,0);
  tmp.endDraw();
  img=tmp;
}
