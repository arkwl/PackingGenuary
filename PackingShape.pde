class PackingShape {
  float radius, numPoint, elapsedTime, randomHueGroup;
  PVector origin;
  
  color[] randomColors = {
    color(0, 50, 255),
    color(33, 50, 255),
    color(62, 50, 255),
    color(110, 50, 255),
    color(185, 50, 255),
    color(217, 50, 255),
    color(249, 50, 255),
    color(300, 50, 255)
  };
  
  PackingShape(PVector origin, float radius, float numPoint, float elapsedTime, float randomHueGroup) {
    this.origin = origin;
    this.radius = radius;
    this.numPoint = random(3, numPoint);
    this.elapsedTime = elapsedTime;
    this.randomHueGroup = randomHueGroup;
  }
  
  void render() { 
    float circleIncrement = PI*2/numPoint;
    //float randomHue = random(randomHueGroup, randomHueGroup+60);
    int colorIndex = (int)random(0, randomColors.length-1);
    color randomHue = randomColors[colorIndex];
    stroke(255);
    fill(randomHue);
    circle(origin.x, origin.y, radius*2);
    
    //beginShape();
    //for (float i = 0 ; i <= PI*2 ; i+=circleIncrement) {
    //  float x = radius * cos(i+elapsedTime) + origin.x;
    //  float y = radius * sin(i+elapsedTime) + origin.y;
      
    //  vertex(x, y);
    //}
    //endShape(CLOSE);
  }
  
  boolean shapeIntersects(PackingShape otherShape) {
    float distSq = pow((origin.x - otherShape.origin.x), 2) + pow((origin.y - otherShape.origin.y), 2); 
    float radSumSq = pow((radius + otherShape.radius), 2); 
    if (distSq > radSumSq) {
        return false;
    } else {
        return true;
    }
  }
}
