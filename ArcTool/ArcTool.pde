//Developped with Processing 3.5.4

int gap=3;
int hh;
float pixTime=2.3; //1pixel時間=2.3ms
int LEDNUM=72; //LED72灯

int radius, theta, delta;
float rps;
String outFile;
PGraphics mask;

PImage img;
int imgX, imgY;
float imgSize;

PGraphics outImg;
boolean saveFlag;
String saveFile;

boolean picLoaded=false;

void setup() {
  dragDropFile();

  size(1280, 520);
  hh=height-gap*2;
  noSmooth();
  //暫定初期値設定
  radius=60; //回転外径半径60cm
  theta=0; //扇型上向き
  delta=45; //扇型角45度
  rps=1.0;
  mask=createGraphics(height, height);

  img=createImage(hh, hh, ARGB);
  imgSize=1;

  deployGuiParts();
}

void setMask() {
  mask.noSmooth();
  mask.beginDraw();
  mask.translate(mask.width/2, mask.height/2);
  mask.scale(1, -1);
  mask.rotate(HALF_PI);
  mask.ellipseMode(CENTER);
  mask.background(0);
  //枠線描画
  mask.stroke(255);
  mask.strokeWeight(gap);
  mask.noFill();
  mask.circle(0, 0, hh);
  mask.fill(128);//仮の抜き色で塗りつぶし
  mask.arc(0, 0, hh, hh, 
    radians(theta-delta/2), radians(theta+delta/2), PIE);
  mask.fill(0);
  mask.arc(0, 0, 
    hh*(radius-50.)/radius-gap, hh*(radius-50.)/radius-gap, 
    radians(theta-delta/2.), radians(theta+delta/2.), 
    PIE);
  mask.noStroke();
  mask.circle(0, 0, hh*(radius-50.)/radius-2*gap);
  mask.fill(0, 0);
  mask.circle(0, 0, hh*(radius-50.)/radius-2*gap);
  mask.loadPixels();
  for (int i=0; i<mask.width*mask.height; i++) {
    if (green(mask.pixels[i])==0) {
      mask.pixels[i]=color(0, 150);//背景色を黒半透明に置換
    }
    if (green(mask.pixels[i])==128) {//抜き色を透明に置換
      mask.pixels[i]=color(0, 0);
    }
  }
  mask.updatePixels();
  mask.endDraw();
}

// 一列分のLEDの点灯色を求める
color[] getAvg(int outWidth, int n) {
  color[] ret=new color[LEDNUM];
  for (int i=0; i<LEDNUM; i++) {
    //LEDの軌跡を直線近似して通過ピクセルを求めて平均化
    float rr=hh/2.*(1-50./radius/LEDNUM*i);
    float th=theta+delta/2.-(float)delta/outWidth*n+90;
    float th2=th-(float)delta/outWidth;
    int x1=round(rr*cos(radians(-th))+height/2.);
    int y1=round(rr*sin(radians(-th))+height/2.);
    int x2=round(rr*cos(radians(-th2))+height/2.);
    int y2=round(rr*sin(radians(-th2))+height/2.);
    int rsum=0, gsum=0, bsum=0;
    int nn=1;
    if (abs(x2-x1)>abs(y2-y1)) {
      int xl=x2, xs=x1;
      int yl=y2, ys=y1;
      if (x1>x2) {
        xl=x1;
        xs=x2;
        yl=y1;
        ys=y2;
      }
      nn=xl-xs+1;
      for (int u=xs; u<=xl; u++) {
        int v;
        if (u-xs==0) {
          v=ys;
        } else {
          v=round(ys+(yl-ys)*(u-xs)/(xl-xs));
        }
        color c=get(u, v);
        rsum+=red(c);
        gsum+=green(c);
        bsum+=blue(c);
      }
    } else {
      int xl=x2, xs=x1;
      int yl=y2, ys=y1;
      if (y1>y2) {
        xl=x1;
        xs=x2;
        yl=y1;
        ys=y2;
      }
      nn=yl-ys+1;
      for (int u=ys; u<=yl; u++) {
        int v;
        if (u-ys==0) {
          v=xs;
        } else {
          v=round(xs+(xl-xs)*(u-ys)/(yl-ys));
        }
        color c=get(v, u);
        rsum+=red(c);
        gsum+=green(c);
        bsum+=blue(c);
      }
    }
    ret[i]=color(rsum/nn, gsum/nn, bsum/nn);
  }
  return ret;
}

//結果のシミュレーション表示
void showResult(PImage img, int xPos, int yPos) {
  translate(xPos, yPos);
  int outWidth=(int)(1/rps/(pixTime/1000)*delta/360);
  for (int i=0; i<LEDNUM; i++) {
    for (int n=0; n<outWidth; n++) {
      float rr=hh/2.*(1-50./radius/LEDNUM*i);
      float th=theta+delta/2.-(float)delta/outWidth*n+90;
      float th2=th-(float)delta/outWidth;
      int x1=round(rr*cos(radians(-th))+height/2.);
      int y1=round(rr*sin(radians(-th))+height/2.);
      int x2=round(rr*cos(radians(-th2))+height/2.);
      int y2=round(rr*sin(radians(-th2))+height/2.);
      color c=img.get(n, i);
      stroke(c);
      line(x1, y1, x2, y2);
    }
  }
  resetMatrix();
}

void draw() {
  int outWidth=(int)(1./rps/(pixTime/1000)*delta/360); //列の数
  outImg=createGraphics(outWidth, LEDNUM); //出力画像エリア確保
  if (droppedFile!=null) {
    try {
      img=loadImage(droppedFile.getAbsolutePath());
      picLoaded=true;
    }
    catch(Exception e) {
      img=createImage(LEDNUM, LEDNUM, ARGB);
    }

    imgX=height/2+gap;
    imgY=hh/4+gap;
    imgSize=(float)hh/img.height/2;
    droppedFile=null;
  }
    
  setMask();
  background(0);
  imageMode(CENTER);
  image(img, imgX, imgY, img.width*imgSize, img.height*imgSize);
  outImg.beginDraw();
  for (int dd=0; dd<outWidth; dd++) { 
    color[] c=getAvg(outWidth, dd);
    int i=0;
    for (color cc : c) {
      outImg.stroke(cc);
      outImg.point(dd, i++);
    }
  }
  outImg.endDraw();

  imageMode(CORNER);
  image(mask, 0, 0);

  noStroke();
  fill(0xcc);
  rect(height, 0, width, height);
  fill(0);
  rect(width-height, 0, width, height);


  imageMode(CENTER);
  float outScale=1;
  if (outImg.width>width-height*2) {
    outScale=(float)(width-height*2)/outImg.width;
  }

  fill(0);
  textAlign(CENTER, CENTER);
  text("Output picture", width/2, height-LEDNUM-115);
  text("width:"+outWidth+"px", width/2, height-LEDNUM-100);
  pushMatrix();
  translate(width/2, height-LEDNUM/2-80);
  scale(1, -1);
  image(outImg, 0, 0, outImg.width*outScale, outImg.height*outScale);
  popMatrix();
  showResult(outImg, width-height, 0);

  fill(0xcc);
  textAlign(LEFT, TOP);
  if (picLoaded) {
    text("Source picture", 10, 10);
  }else{
    fill(0xcc,0x20,0x20);
    text("Drag and Drop \na Source picture",10,10);
    fill(0xcc);
  }
  text("Simulated picture", width-height+10, 10);

  if (saveFlag) {
    execSave();
  }
}
