//f = gMm/r^2 //<>// //<>// //<>// //<>//
//f = ma

//in this placce each pixel 1.82e6 m
//this means that the distance between the moon and the earth is represented as 200 pixels
int scale;

void setup() {

  
  frameRate(1000);
  size(1080, 1080);
  scale = 3640000/(width/4);

  //println(scale);

  solarSystem.add(new planet("earth", 6e22, width/2, height/2-100));
  solarSystem.add(new planet("moon", 7.3e20, width/2, height/4));

  //solarSystem.add(new planet("moon", 7.3e22, width/2, height/4));

  solarSystem.get(1).xVelocity = 1022;
  
  solarSystem.get(0).xVelocity = 0;

  solarSystem.get(0).drawPlanet();
  solarSystem.get(1).drawPlanet();
}

class planet {
  planet (String inName, float inMass, int inX, int inY) {
    name = inName;
    x = inX;
    y = inY;
    mass = inMass;
  }
  String name;
  float x, y, xVelocity, yVelocity;
  float mass;
  color surface = color(random(0, 255), random(0, 255), random(0, 255));

  void drawPlanet() {
    fill(surface);
    circle(x, y, 50);
  }

  void movePlanet() {
    x = x + (xVelocity/scale);
    y = y + (yVelocity/scale);
  }
}

ArrayList<planet> solarSystem = new ArrayList<planet>();

void draw() {
  background(122.5);
  textSize(30);
  text(frameRate, 50, 30);

  for (int i=0; i<solarSystem.size(); i++) {
    //for (int o = 0; o < 100; o++ ) {

      for (int k=0; k<solarSystem.size(); k++) {
        int xDistance = int((solarSystem.get(i).x - solarSystem.get(k).x));
        int yDistance = int((solarSystem.get(i).y - solarSystem.get(k).y));

        int radius = int(sqrt(pow(xDistance, 2) + pow(yDistance, 2)))*scale;


        if (k != i) {
          //println("radius " + radius);
          //println("mass1 "+ solarSystem.get(i).mass);
          //println("mass2 "+ solarSystem.get(k).mass);

          float force = (6.67e-11 * solarSystem.get(i).mass * solarSystem.get(k).mass)/pow(radius, 2);
          //println("force of " + solarSystem.get(i).name + " on " + solarSystem.get(k).name + " is " + force);
          //so we have the magnitude of force
          // now we need to find the diretion

          int opp = yDistance, adj = xDistance;
          float angle = (atan(float(opp)/float(adj)));
          //println("acceleration in X direction: "+(force*sin(angle)/solarSystem.get(i).mass));
          //println("Acceleration in Y direction: "+(force*cos(angle)/solarSystem.get(i).mass));
          println();
          println();
          println();
          println("angle:" + angle*180/PI);
          float xForce = (force*cos(angle)/solarSystem.get(i).mass), yForce = (force*sin(angle)/solarSystem.get(i).mass);
          
          if (solarSystem.get(i).y - solarSystem.get(k).y < 0 && (angle*180/PI)<0){
          yForce = yForce * -1;
          xForce = xForce * -1;
          }
          
          if (solarSystem.get(i).y - solarSystem.get(k).y > 0 && (angle*180/PI)>0){
          yForce = yForce * -1;
          xForce = xForce * -1;
          
          }
          //if (xDistance < 0 ){
          //xForce = xForce * -1;
          //}
          
          solarSystem.get(i).xVelocity = solarSystem.get(i).xVelocity + xForce;
          solarSystem.get(i).yVelocity = solarSystem.get(i).yVelocity + yForce;

          //println(angle*180/PI);
          //println(angle);
        //} //<>//
      }

      solarSystem.get(i).movePlanet();
      //println(solarSystem.get(i).name+"'s X: " + solarSystem.get(i).x, "Y: " + solarSystem.get(i).y);
    }
    //if (solarSystem.get(i).name == "moon") {
    //  println("X: " + solarSystem.get(i).x);

    //  println("Y: " + solarSystem.get(i).y);
    //}
    solarSystem.get(i).drawPlanet();
  }
}
