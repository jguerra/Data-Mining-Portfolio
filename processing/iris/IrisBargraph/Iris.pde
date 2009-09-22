class Iris{
  String name;
  float sepalLength;
  float sepalWidth;
  float petalLength;
  float petalWidth;
  
  Iris(String n, float sL, float sW, float pL, float pW){
    name = n;
    sepalLength = sL;
    sepalWidth = sW;
    petalLength = pL;
    petalWidth = pW;
  }
  
  String getName(){
    return name;
  }
  float getSepalLength(){
    return sepalLength;
  }
  float getSepalWidth(){
    return sepalWidth;
  }
  float getPetalLength(){
    return petalLength;
  }
  float getPetalWidth(){
    return petalWidth;
  }
}
    
