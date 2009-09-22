int offset = 50;
Iris[] irisData;
//define what is being compared
//0=sepalLength, 1 = sepalWidth, 2=PetalLength, 3=PetalWidth
int yAxisField = 3, xAxisField = 2;
float maxYAxis= MIN_FLOAT;
float minYAxis= MAX_FLOAT;
float maxXAxis= MIN_FLOAT;
float minXAxis= MAX_FLOAT;

String[] irisNames = {"Setosa", "Versicolor", "Virginica"};
String[] fieldNames = {"Sepal Length", "Sepal Width", "Petal Length", "Petal Width"};
void setup(){
  size(600,600);
  String[] data = loadStrings("iris.txt");
  irisData = new Iris[data.length];
  
  for(int i =0; i < irisData.length; ++i){
      irisData[i] = loadData(data[i]);
  }
  
  
  
  findMaxsAndMins(yAxisField,xAxisField);
}
Iris loadData(String iris){
  String[] sep = split(iris, ',');
  return new Iris(split(sep[4], '-')[1], parseFloat(sep[0]),parseFloat(sep[1]),parseFloat(sep[2]),parseFloat(sep[3]));
}
void findMaxsAndMins(int yAxisField, int xAxisField){
  
  for(int i = 0; i < irisData.length; ++i){
    if(getField(irisData[i], yAxisField) > maxYAxis)
      maxYAxis = getField(irisData[i], yAxisField);
    else if(getField(irisData[i], yAxisField) < minYAxis)
      minYAxis = getField(irisData[i], yAxisField);
      
    if(getField(irisData[i], xAxisField) > maxXAxis)
      maxXAxis = getField(irisData[i], xAxisField);
    else if(getField(irisData[i], xAxisField) < minXAxis)
      minXAxis = getField(irisData[i], xAxisField);
  }  
}
float getField(Iris iris, int field){
  if(field == 0)
     return iris.getSepalLength();
  else if(field == 1)
    return iris.getSepalWidth();
  else if(field == 2)
    return iris.getPetalLength();
  else
    return iris.getPetalWidth();
   
}
void drawLegend(){
  color r = color(255,0,0);
  color g = color(0,255,0);
  color b = color(0,0,255);
  PFont font;
  font = loadFont("FranklinGothic-Heavy-12.vlw");
  textFont(font);
  
  fill(r);
  rect(width-2*offset, offset, 10, 10);
  fill(0);
  text("= "+irisNames[0], width-2*offset+15, offset+9);
  
  fill(g);
  rect(width-2*offset, offset+20, 10, 10);
  fill(0);
  text("= "+irisNames[1], width-2*offset+15, offset+29);
  
  fill(b);
  rect(width-2*offset, offset+40, 10, 10);
  fill(0);
  text("= "+irisNames[2], width-2*offset+15, offset+49);
  
}
void drawScale(){
  PFont font;
  font = loadFont("FranklinGothic-Heavy-20.vlw");
  textFont(font);
  fill(0,0,0);
  text("0", offset/2, height-offset+5);
  text(nf(maxYAxis,1, 2), 0, offset+6);
  
  text("0", offset-5, height-offset/2+5);
  text(nf(maxXAxis,1, 2), width-offset-5, height-offset/2+5);
}
void drawPoint(Iris iris){
  float xMapped = map(getField(iris, xAxisField), minXAxis, maxXAxis, offset+5, width-2*offset);
  float yMapped = map(getField(iris, yAxisField), minYAxis, maxYAxis, offset+5, height-2*offset);
  color fillColor;
  
  if(iris.getName().equals("setosa"))
    fillColor = color(255,0,0);    
  else if(iris.getName().equals("versicolor"))
    fillColor = color(0,255,0);   
  else
    fillColor = color(0,0,255);
  smooth();  
  fill(fillColor);
  noStroke();
  ellipse(xMapped, height-yMapped, 5,5);  
  
}
void drawTitle(){
  PFont font;
  font = loadFont("FranklinGothic-Heavy-20.vlw");
  textFont(font);
  fill(0,0,0);
  
  String title = fieldNames[yAxisField] + " vs " + fieldNames[xAxisField];
  text(title, width/4, offset/2);
 // textAlign(CENTER);
}
void draw() {
  background(255,255,255);
  
  stroke(0,0,0);
  line(offset,offset,offset, height-offset);
  line(offset,height-offset,width-offset, height-offset);
  
  drawLegend();
  drawScale();
  drawTitle();
  
  for(int i = 0; i < irisData.length; ++i){
     drawPoint(irisData[i]); 
  }
}
