import processing.serial.*;
import controlP5.*;
import cc.arduino.*;

Arduino arduino;
ControlP5 cp5;

float x=113, y = 0, z=95, x1=113, y1, t1, t2, t3, l1=180, l2=200, l3=50;
int e, k=0, k1=0;
float sliderX=x, sliderY=y, sliderZ=z, sliderG;
float[] posX = new float[10000];
float[] posY = new float[10000];
float[] posZ = new float[10000];
int rs=0;

void setup() {
  size(1440, 840);

  cp5 = new ControlP5(this);

  println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[1], 57600);
  arduino.pinMode(9, Arduino.SERVO);
  arduino.pinMode(3, Arduino.SERVO);
  arduino.pinMode(10, Arduino.SERVO);
  arduino.pinMode(5, Arduino.SERVO);

  PFont pfont = createFont("Arial", 225, true); // use true/false for smooth/no-smooth
  ControlFont font = new ControlFont(pfont, 20);
  ControlFont font2 = new ControlFont(pfont, 25);

  //X controls
  cp5.addSlider("sliderX")
    .setPosition(600, height/2+100)
    .setSize(270, 30)
    .setRange(0, l1+l2-10) // Slider range, corresponds to Joint 1 or theta1 angle that the robot can move to
    .setColorLabel(225)
    .setCaptionLabel("X")
    .setFont(font)
    ;
  cp5.getController("sliderX").getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE).setPaddingX(0);

  //Y controls
  cp5.addSlider("sliderY")
    .setPosition(600, height/2+200)
    .setSize(270, 30)
    .setRange(-(l1+l2-50), l1+l2-50) // Slider range, corresponds to Joint 1 or theta1 angle that the robot can move to
    .setColorLabel(225)
    .setCaptionLabel("Y")
    .setFont(font)
    ;
  cp5.getController("sliderY").getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE).setPaddingX(0);

  //Z controls
  cp5.addSlider("sliderZ")
    .setPosition(600, height/2+300)
    .setSize(270, 30)
    .setRange(-160, 180) // Slider range, corresponds to Joint 1 or theta1 angle that the robot can move to
    .setColorLabel(225)
    .setCaptionLabel("Z")
    .setFont(font)
    ;
  cp5.getController("sliderZ").getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE).setPaddingX(0);

  cp5.addSlider("sliderG")
    .setPosition(950, height/2+300)
    .setSize(190, 30)
    .setRange(0, 100)
    .setColorLabel(225)
    .setFont(font)
    .setCaptionLabel("Gripper")
    .setNumberOfTickMarks(5)
    ;
  cp5.getController("sliderG").getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE).setPaddingX(0);

  cp5.addButton("savePosition")
    .setPosition(950, 520)
    .setSize(215, 50)
    .setFont(font2)
    .setCaptionLabel("SAVE POSITION")
    ;

  cp5.addButton("run")
    .setPosition(1205, 520)
    .setSize(215, 50)
    .setFont(font2)
    .setCaptionLabel("RUN PROGRAM")
    ;

  cp5.addButton("clearSteps")
    .setPosition(1270, 700)
    .setSize(135, 40)
    .setFont(font)
    .setCaptionLabel("(CLEAR)")
    ;
}

void draw() {
  background(20);
  PVector m = new PVector(mouseX, mouseY);
  PVector c = new PVector(200, height/2);  
  pushMatrix();
  translate(200, height/2);
  PVector c1 = new PVector(800, 0);
  m.sub(c);

  if (k1>=k) {
    k1=0;
  }

  if (rs==1) {

    x=posX[k1];
    y=posY[k1];
    z=posZ[k1];
    sliderX=x;
    sliderZ=z;
    sliderY=y;
  }

  if  (mousePressed == true && ((sq(200-mouseX) + sq(height/2-mouseY))<=sq(l1+l2)) && mouseX>200) {
    x1 = m.x;
    z = -m.y;
    x = sqrt(sq(x1)-sq(y)) ;
    sliderX=x;
    sliderZ=z;
  }
  if  (mousePressed == true && ((sq(1000-mouseX) + sq(height/2 - mouseY))<=sq(l1+l2 -5)) && mouseY<height/2) {
    y= m.x - 800;
    x = -m.y;
    x1 = sqrt(sq(y)+sq(m.y)) ;
    sliderX=x;
    sliderY=y;
  }

  x=sliderX;
  y=sliderY;
  z=sliderZ;
  
  if (keyPressed) {
    if (key == 'w' || key == 'W') {
      z++;
    }
       if (key == 's' || key == 'S') {
      z--;
    }
  }
  
  cp5.getController("sliderX").setValue(x);
  cp5.getController("sliderY").setValue(y);
  cp5.getController("sliderZ").setValue(z);


  t3= atan2(y, x);
  t2= acos((sq(x) +sq(y)+sq(z)-sq(l1)-sq(l2))/(2*l1*l2));
  t1= (atan2(z, ( sqrt(sq(x)+sq(y)))) + atan2(l2*sin(t2), (l1+l2*cos(t2))));

  PVector a = new PVector(l1*cos(-t1), l1*sin(-t1));
  PVector b = new PVector();
  PVector p = new PVector(y, x);
  p.sub(c1);
  m.set(x1, -z);
  b=PVector.sub(a, m);

  float t4 = b.heading();

  stroke(0, 250, 0);
  strokeWeight(30);
  line(a.x, a.y, a.x+l3*cos(t4), a.y+l3*sin(t4));
  b.mult(-1);
  float t5 = b.heading();
  line(a.x, a.y, a.x+l2*cos(t5), a.y+l2*sin(t5));
  stroke(255, 0, 200);
  strokeWeight(20);
  line(l3*cos(t4), l3*sin(t4), a.x+l3*cos(t4), a.y+l3*sin(t4));  
  stroke(255);
  line(0, 0, l3*cos(t4), l3*sin(t4));
  stroke(255, 0, 0);
  strokeWeight(40);
  line(0, 0, a.x, a.y);
  stroke(10);
  ellipse(0, 0, 10, 10);

  for (int i=160; i<=2*(l1+l2 - 10); i=i+40) {
    stroke(255);
    strokeWeight(2);
    noFill();
    arc(800, 0, i, i, PI, 2*PI);
  }

  if  (((sq(p.x+800) + sq(p.y))<=sq(l1+l2-5)) && -p.y<0) {
    stroke(0, 0, 255);
    strokeWeight(15);
    line(800, 0, p.x + 1600, -p.y);
    ellipse(p.x +1600, -p.y, 10, 10);
  }

  PVector l = new PVector(1, 0);
  l.mult(-1);
  float al = PVector.angleBetween(l, b);
  //l.mult(-1);
  l.rotate(PI/2-radians(50));
  float ar = PVector.angleBetween(l, a);

  arduino.servoWrite(9, int(degrees(al)) );
  arduino.servoWrite(3, int(degrees(ar)) );
  arduino.servoWrite(10, int(90 +degrees(t3)) );

  //println(degrees(al), 90 +degrees( t3), x, z);
  textSize(18);
  textAlign(CENTER);
  text("X", -120, 270);
  text("Y", -70, 270);
  text("Z", -30, 270);
  text(int(x), -120, 300);
  text(int(y), -70, 300);
  text(int(z), -30, 300);
  text("leftServo Angle", 80, 270);
  text(int(degrees(al)), 200, 270);
  text("rightServo Angle", 80, 300);
  text(int(degrees(ar)), 200, 300);
  textSize(15);
  textAlign(LEFT);
  text("press w or s to increes or decrees the Z", -130, 340);
  text("preaa R key and move to recored", -130, 360);
  textSize(60);
  text("sArm manipulator", 130, -365);
  popMatrix();


  //println(posX[2]);
  k1++;

  if (keyPressed) {
    if (key == 'r' || key == 'R') {
      posX[k]= x;
      posY[k]=y;
      posZ[k]=z;
      k++;
      cp5.getController("savePosition").setCaptionLabel("RECODING");
      cp5.getController("savePosition").setColorLabel(#e74c3c);
    }
  } else {
    cp5.getController("savePosition").setCaptionLabel("SAVE POSITION");
    cp5.getController("savePosition").setColorLabel(255);
  }
}

//void mouseWheel(MouseEvent event) {
//  if (mousePressed == true) {
//    e = event.getCount();
//    z+=e;
//    //println(e);
//  }
//}

public void savePosition() {
  posX[k]= x;
  posY[k]=y;
  posZ[k]=z;
  k++;
}

public void run() {

  if (rs == 0) {
    cp5.getController("run").setCaptionLabel("STOP");
    cp5.getController("run").setColorLabel(#e74c3c);

    rs = 1;
  } else if (rs == 1) {
    rs = 0;
    cp5.getController("run").setCaptionLabel("RUN PROGRAM");
    cp5.getController("run").setColorLabel(255);
  }
}

public void clearSteps() {
  for (int i =0; i<k; i++) {
    posX[i]=posX[k];
    posY[i]=posY[k];
    posZ[i]=posZ[k];
  }
  k=0;
  posX[k]= 113;
  posY[k]=0;
  posZ[k]=95;
}
