int polyCount=20;
PMatrix3D baseMat;
float[] fps=new float[60];

void cylinder(float bottom, float h) {
  int sides=polyCount;
  float top=bottom;
  pushMatrix();
  
  translate(0,h/2,0);
  
  float angle;
  float[] x = new float[sides+1];
  float[] z = new float[sides+1];
  
  float[] x2 = new float[sides+1];
  float[] z2 = new float[sides+1];
 
  //get the x and z position on a circle for all the sides
  for(int i=0; i < x.length; i++){
    angle = TWO_PI / (sides) * i;
    x[i] = sin(angle) * bottom;
    z[i] = cos(angle) * bottom;
  }
  
  for(int i=0; i < x.length; i++){
    angle = TWO_PI / (sides) * i;
    x2[i] = sin(angle) * top;
    z2[i] = cos(angle) * top;
  }
 
  //draw the bottom of the cylinder
  beginShape(TRIANGLE_FAN);
 
  vertex(0,   -h/2,    0);
 
  for(int i=0; i < x.length; i++){
    vertex(x[i], -h/2, z[i]);
  }
 
  endShape();
 
  //draw the center of the cylinder
  beginShape(QUAD_STRIP); 
 
  for(int i=0; i < x.length; i++){
    vertex(x[i], -h/2, z[i]);
    vertex(x2[i], h/2, z2[i]);
  }
 
  endShape();
 
  //draw the top of the cylinder
  beginShape(TRIANGLE_FAN); 
 
  vertex(0,   h/2,    0);
 
  for(int i=0; i < x.length; i++){
    vertex(x2[i], h/2, z2[i]);
  }
 
  endShape();
  
  popMatrix();
}

void scale(float x, float y) {
  translate(x,y);
  //background(255);
  float l=200;
  //orbitControl();
  noStroke();
  fill(192);
  pushMatrix();
  rotateX(radians(90));
  translate(0,-50,0);
  cylinder(50,100); //gray cylinder (face)
  popMatrix();
  
  pushMatrix();
  rotateX(radians(90));
  fill(0,128,255);
  translate(0,-0-l/2,-20);
  stroke(255,0,0);
  box(110,l,100); //blue box (body)
  popMatrix();
  
  noStroke();
  pushMatrix();
  rotateX(radians(90));
  fill(0,128,255);
  translate(0,-100-l/2,0);
  cylinder(51,l-1); //blue cylinder (body)
  popMatrix();
  
  pushMatrix();
  rotateX(radians(90));
  fill(0);
  translate(0,-1,0);
  cylinder(51,50); //black cylinder (head)
  popMatrix();
  
  noFill();
  stroke(0);
  strokeWeight(2);
  pushMatrix();
  translate(0,0,50);
  circle(0,0,100); //black circle (face);
  popMatrix();
  noStroke();
  fill(255);
  
  pushMatrix();
  translate(-18,-10,50);
  rotateX(radians(90));
  cylinder(10,5); //white eye (left);
  popMatrix();
  
  pushMatrix();
  translate(18,-10,50);
  rotateX(radians(90));
  cylinder(10,5); //white eye (right);
  popMatrix();
  
  fill(0);
  pushMatrix();
  translate(-18,-10,50);
  rotateX(radians(90));
  cylinder(5,6); //black eye (left);
  popMatrix();
  
  pushMatrix();
  translate(18,-10,50);
  rotateX(radians(90));
  cylinder(5,6); //black eye (right);
  popMatrix();
}



void setup() {
  size(800,800,P3D);
  //circle(-18,-10,10);
  //circle(18,-10,10);
  baseMat = getMatrix(baseMat);
  frameRate(60);
}

int zoom=900;
int w=20;
int h=20;
boolean showText=true;

void draw() {
  background(255);
  rotateY(radians(-(mouseX-width/2)));
  rotateX(radians((mouseY-height/2)));
  translate(0,0,-zoom);
  for (int _y=0;_y<h;_y++) {
    for (int _x=0;_x<w;_x++) {
      pushMatrix();
      scale(width/2+120*_x-120*(w/2.0),height/2+120*_y-120*(h/2.0));
      popMatrix();
    }
  }
  fps[frameCount%fps.length]=frameRate;
  if (showText) {
    this.setMatrix(baseMat);
    ambientLight(255, 255, 255);
    noStroke();
    fill(255);
    rect(45,35,150,70+60);
    //stroke(0);
    //rect(210,
    //noStroke();
    fill(0);
    text("size: "+Integer.toString(w),50,50);
    text("number of polygons: "+Integer.toString(polyCount),50,75);
    text("fps: "+Float.toString(frameRate),50,100);
    //stroke(0);
    for (int i=0;i<fps.length;i++) {
      ellipse(50+i*140.0/60,100+60-fps[i],3,3);
    }
  }
}

void keyPressed() {
  if (key=='w') {
    zoom+=100;
  }
  if (key=='s') {
    zoom-=100;
    //System.out.println(zoom);
  }
  if (key=='a') {
    polyCount--;
  }
  if (key=='d') {
    polyCount++;
  }
  if (key=='i') {
    w++;
    h++;
  }
  if (key=='j') {
    w--;
    h--;
  }
  if (key=='l') {
    showText=!showText;
  }
}
