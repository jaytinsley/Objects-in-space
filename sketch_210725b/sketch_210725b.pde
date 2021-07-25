//f = gMm/r^2
//f = ma

//in this placce each pixel 1.82e6 m
//this means that the distance between the moon and the earth is represented as 200 pixels
int scale;

void setup() {
  size(800, 800);
  scale = 364000000/(width/4);

  //println(scale);

  solarSystem.add(new planet("earth", 6e24, width/2, height/2));
  solarSystem.add(new planet("moon", 7.3e22, width/2, height/4));
}

class planet {
  planet (String inName, float inMass, int inX, int inY) {
    name = inName;
    x = inX;
    y = inY;
    mass = inMass;
  }
  String name;
  int x, y;
  float mass;
  color surface = color(random(0, 255), random(0, 255), random(0, 255));

  void drawPlanet() {
    fill(surface);
    circle(X, Y, 50);
  }

  void movePlanet(int xVelocity, int yVelocity) {
    x = x + xVelocity;
    y = y + yVelocity;
  }
}

ArrayList<planet> solarSystem = new ArrayList<planet>();

void draw() {
  for (int i=0; i<solarSystem.size(); i++) {
    for (int k=0; k<solarSystem.size(); k++) {
      int xDistance = (solarSystem.get(i).x - solarSystem.get(k).x);
      int yDistance = (solarSystem.get(i).y - solarSystem.get(k).y);

      int radius = int(sqrt(pow(xDistance, 2) + pow(yDistance, 2)))*scale;
      //println(radius);
      if (k != i) {
        float force = (6.67e-11*solarSystem.get(i).mass * solarSystem.get(k).mass)/pow(radius, 2);
        println("force of " + solarSystem.get(i).name + " on " + solarSystem.get(k).name + " is " + force);
      }
    }
  }
}
