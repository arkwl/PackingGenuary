import java.util.ArrayList; // import the ArrayList class

ArrayList<PackingShape> packingShapes = new ArrayList<PackingShape>();

float numOfWaves = 1;

void setup() {
  //size(1080, 1080);
  size(320, 320);
  colorMode(HSB);
}

void draw() {
  background(255);
  float radius = width/10;
  float numPoint = 10;
  float elapsedTime = 0;
  float randomHueGroup = random(0, 360);
  
  
  
  for (int j = 0; j < numOfWaves; j++) {
    
    float outerRadius = width/2;
    float innerRadius = width/4;
    
    // DRAW BOARDERS START
    //float randomTopLeftStart = random(0, height);
    //float randomBottomLeftStart = random(randomTopLeftStart, randomTopLeftStart+height/20);
    ////println(randomTopLeftStart, );
    //float randomTopLeftThickness = random(0, height/16);
    //float randomBottomLeftThickness = random(0, height/16);
    
    //int numOfPointsRow = 30;
    //float[] polygonXPoints = new float[(numOfPointsRow+1)*2];
    //float[] polygonYPoints = new float[(numOfPointsRow+1)*2];
    ////beginShape();
    //for (int k = 0; k <= numOfPointsRow; k++) {
    //  polygonXPoints[k] = k*width/numOfPointsRow;
    //  polygonYPoints[k] = randomTopLeftStart+randomTopLeftThickness*noise((elapsedTime+k)*0.1);
      
    //  polygonXPoints[k+numOfPointsRow] = k*width/numOfPointsRow;
    //  polygonYPoints[k+numOfPointsRow] = randomBottomLeftStart+randomBottomLeftThickness*noise((elapsedTime+k+0.1)*0.1);
      
    //  //vertex(polygonXPoints[k], polygonYPoints[k]);
    //}
    //for (int k = numOfPointsRow; k >= 0; k--) {
    //  polygonXPoints[k+numOfPointsRow] = k*width/numOfPointsRow;
    //  polygonYPoints[k+numOfPointsRow] = randomBottomLeftThickness*noise((elapsedTime+k+0.1)*0.1);
    //  //vertex(polygonXPoints[k+numOfPointsRow], polygonYPoints[k+numOfPointsRow]);
    //}
    ////endShape();
    // DRAW BOARDERS END
    
    randomHueGroup = random(70, 140);
    int numOfFailedPacking = 0;
    int numOfSucceedPacking = 0;
    while (numOfFailedPacking < 20000) {
      if (numOfSucceedPacking < 3) {
        radius = width/10;
      } else if (numOfSucceedPacking < 5) {
        radius = width/25;
      } else if (numOfSucceedPacking < 20) {
        radius = width/100;
      } else if (radius < 2) {
        radius = 2;
      } else if (numOfFailedPacking > 20) {
        radius /= 1.0000005;
      }
      
      //PVector origin = new PVector(random(radius, width-radius), random(radius, width-radius));
      PVector origin = generatePoint(outerRadius, innerRadius);
      PackingShape shape = new PackingShape(origin, radius, numPoint, elapsedTime, randomHueGroup);
      
      println(origin, numOfFailedPacking, radius);
      boolean doesNotCollideWithOtherShapes = true;
      for (int i = 0; i < packingShapes.size(); i++) {
        PackingShape otherShape = packingShapes.get(i);
        if (shape.shapeIntersects(otherShape)) {
          doesNotCollideWithOtherShapes = false;
          break;
        }
      }
      
      if (doesNotCollideWithOtherShapes && ringContainsPoint(shape, outerRadius, innerRadius)) {
        packingShapes.add(shape);
        shape.render();
        numOfFailedPacking = 0;
        numOfSucceedPacking++;
      } else {
        numOfFailedPacking++;
      }
      elapsedTime++;
    }
    
    packingShapes = new ArrayList<PackingShape>();
    elapsedTime = 0;
  }
  
  save("output/packing_3.png");
  noLoop();
}

PVector generatePoint(float outerRadius, float innerRadius) {
  float alpha = 2 * PI * random(0, 1);
  float x = map(cos(alpha), -1, 1, innerRadius, outerRadius);
  float y = map(sin(alpha), -1, 1, innerRadius, outerRadius);
  
  return new PVector(x, y);
}
boolean ringContainsPoint(PackingShape shape, float outerRadius, float innerRadius) {
  float shapeRadius = shape.radius;
  PVector shapeOrigin = shape.origin;
  int distSq = (int)Math.sqrt(((width/2 - shapeOrigin.x) * (width/2 - shapeOrigin.x)) + ((width/2 - shapeOrigin.y) * (width/2 - shapeOrigin.y))); 
  if ((distSq + shapeRadius == outerRadius) || (distSq + shapeRadius < outerRadius)) {
    if (!((distSq + shapeRadius == innerRadius) || (distSq + shapeRadius < innerRadius))) {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}

boolean polygonContainsPoint(float[] polygonXPoints, float[] polygonYPoints, float testX, float testY)
{
    int numVerts = polygonXPoints.length;
    boolean c = false;
    int j = numVerts - 1;
    for (int i = 0; i < numVerts; i++)
    {
        double deltaX = polygonXPoints[j] - polygonXPoints[i];
        double ySpread = testY - polygonYPoints[i];
        double deltaY = polygonYPoints[j] - polygonYPoints[i];
        if (((polygonYPoints[i] > testY) != (polygonYPoints[j] > testY)) &&
            (testX < (((deltaX * ySpread) / deltaY) + polygonXPoints[i])))
        {
            c = !c;
        }

        j = i;
    }
    return c;
}
