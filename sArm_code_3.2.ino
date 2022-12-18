#include <Servo.h>
#include <math.h>

Servo sl, sr, base, gr; // sl - leftServo, sr - rightServo, base - baseServo gr - gripperservo
double l1 = 8, l2 = 8; // mesurements of sArm

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Initional sArm possion.
void homepos() {
  mvsl(180, 20);
  delay(500);
  mvsr(30, 20);
  delay(500);
  mvb(90, 20);
  delay(500);
  gr.write(30);
  delay(1000);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void setup() {
  //attach the servos
  sl.attach(9);
  sr.attach(3);
  base.attach(10);
  gr.attach(5 , 544, 853);

  homepos();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// We use for loops so we can control the speed of the servo
void mvsl( int p, int d) { // to move the left servo
  //  p - end possion d - delay
  // If previous position is bigger then current position
  int pp = sl.read(); // set previous position
  if (pp > p) {
    for ( int j = pp; j >= p; j--) {   // Run servo down
      sl.write(j);
      delay(d);    // defines the speed at which the servo rotates
    }
  }
  // If previous position is smaller then current position
  if (pp < p) {
    for ( int j = pp; j <= p; j++) {   // Run servo up
      sl.write(j);
      delay(d);
    }
  }
  if (pp == p) {
    delay(2);
  }
}
void mvsr( int p, int d) {// to move the right servo
  //  p - end possion d - delay
  // If previous position is bigger then current position
  int pp = sr.read(); // set previous position
  if (pp > p) {
    for ( int j = pp; j >= p; j--) {   // Run servo down
      sr.write(j);
      delay(d);    // defines the speed at which the servo rotates
    }
  }
  // If previous position is smaller then current position
  if (pp < p) {
    for ( int j = pp; j <= p; j++) {   // Run servo up
      sr.write(j);
      delay(d);
    }
  }
  if (pp == p) {
    delay(2);
  }
}
void mvb( int p, int d) {// to move the base servo
  //  p - end possion d - delay
  // If previous position is bigger then current position
  int pp = base.read(); // set previous position
  if (pp > p) {
    for ( int j = pp; j >= p; j--) {   // Run servo down
      base.write(j);
      delay(d);    // defines the speed at which the servo rotates
    }
  }
  // If previous position is smaller then current position
  if (pp < p) {
    for ( int j = pp; j <= p; j++) {   // Run servo up
      base.write(j);
      delay(d);
    }
  }
  if (pp == p) {
    delay(2);
  }
}

//open or closs the gripper
//  1 - open 0 - close
void grf( int p) {
  int pp = gr.read(); // set previous position
  if (p == 1) {
    for ( int j = pp; j >= 5; j--) {
      gr.write(j);
      delay(20);    // defines the speed at which the servo rotates
    }
  }
  if (p == 0) {
    for ( int j = pp; j <= 30; j++) {
      gr.write(j);
      delay(20);
    }
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Function for inverse kinematics for sArm
// Move end efactor to corsponting (X,Y,Z)
void ikMoveTo(double x, double y, double z) {
  double t3 = degrees(atan2(y , x));
  double t2 = degrees(acos((pow(x, 2) + pow(y, 2) + pow(z, 2) - pow(l1, 2) - pow(l2, 2)) / (2 * l1 * l2)));
  double t1 = degrees(atan(z / (sqrt(pow(x, 2) + pow(y, 2)))) + atan(l2 * sin(radians(t2)) / (l1 + l2 * cos(radians(t2)))));

  mvsl((int(180 - (t2 - (t1 - 30)))), 5);
  mvsr((int(130 - t1)), 5);
  mvb((int(90 + t3)), 5);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Draw a stright line that connect given two points.
void drawLine(int a, int b, int c, int p, int q, int r) {
  if (a < p) {
    for (int t = a; t <= p; t++) {
      double x = t;
      double y = (((x - a) * (q - b)) / (p - a)) + b;
      double z = (((x - a) * (r - c)) / (p - a)) + c;
      ikMoveTo(x, y, z);
      delay(10);
    }
  }
  if (a > p) {
    for (int t = a; t >= p; t--) {
      double x = t;
      double y = (((x - a) * (q - b)) / (p - a)) + b;
      double z = (((x - a) * (r - c)) / (p - a)) + c;
      ikMoveTo(x, y, z);
      delay(10);
    }
  }
  if (a == p) {
    if (b < q) {
      for (int t = b; t <= q; t++) {
        double y = t;
        double x = (((y - b) * (p - a)) / (q - b)) + a;
        double z = (((x - a) * (r - c)) / (p - a)) + c;
        ikMoveTo(x, y, z);
        delay(10);
      }
    }
    if (b > q) {
      for (int t = b; t >= q; t--) {
        double y = t;
        double x = (((y - b) * (p - a)) / (q - b)) + a;
        double z = (((x - a) * (r - c)) / (p - a)) + c;
        ikMoveTo(x, y, z);
        delay(10);
      }
    }
    if (b == q) {
      if (c < r) {
        for (int t = c; t <= r; t++) {
          double z = t;
          double y = (((z - c) * (q - b)) / (r - c)) + b;
          double x = (((z - c) * (p - a)) / (r - c)) + a;

          ikMoveTo(x, y, z);
          delay(10);
        }
      }
      if (c > r) {
        for (int t = c; t >= r; t--) {
          double z = t;
          double y = (((z - c) * (q - b)) / (r - c)) + b;
          double x = (((z - c) * (p - a)) / (r - c)) + a;

          ikMoveTo(x, y, z);
          delay(10);
        }
      }
      if (c == r) {
        ikMoveTo(a, b, c);
      }
    }
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Draw a triangle that connect given three points in XYZ space.
void drawTri(int a, int b, int c, int p, int q, int r, int x, int y, int z) {
  drawLine(a, b, c, p, q, r);
  delay(500);
  drawLine(p, q, r, x, y, z);
  delay(500);
  drawLine(x, y, z, a, b, c);
  delay(500);
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void loop() {

  // program for a sample task, sArm do this again and again
  // you can program the sArm with this functions easily

  drawTri(10, 0, 5, 17, 0, 13, 17, 0, 0);
  delay(1000);
  ikMoveTo(10, 1, 10);
  delay(1000);
  drawLine(10, 0, 0, 10, 0, 9);
  delay(10);
  grf(1);
  delay(1000);
  drawLine(10, 0, 9, 10, 0, 0);
  delay(10);
  grf(0);
  delay(1000);
}
