int offset = 50;
int barWidth = 40;
Iris[] irisData;
float[] means = new float[3];
float[] medians = new float[3];
float max= MIN_FLOAT;
float min= MAX_FLOAT;
String[] irisNames = {"Setosa", "Versicolor", "Virginica"};

void setup(){
  size(600,600);
  String[] data = loadStrings("iris.txt");
  irisData = new Iris[data.length];
  
  for(int i =0; i < irisData.length; ++i){
      irisData[i] = loadData(data[i]);
  }
  
  //For indexing 0 = setosa, 1 = versicolor, 2 = virginica
  int field = 0;
  findMeans(field);
 // print("Means are " + means[0] + " " + means[1] + " " + means[2] + "\n");
  findMedians(field);
 // print("Medians are " + medians[0] + " " + medians[1] + " " + medians[2] + "\n");
 // print("Max = " + max + " min = " + min + "\n");
}
Iris loadData(String iris){
  String[] sep = split(iris, ',');
  return new Iris(split(sep[4], '-')[1], parseFloat(sep[0]),parseFloat(sep[1]),parseFloat(sep[2]),parseFloat(sep[3]));
}
void findMeans(int field){
  int setosaCount=0, versiCount=0, virginCount=0;
  
  for(int i = 0; i < irisData.length; ++i){
    if(irisData[i].getName().equals("setosa")){
      setosaCount++;
      means[0] += getField(irisData[i], field);
    }
    else if(irisData[i].getName().equals("versicolor")){
       versiCount++;
       means[1] += getField(irisData[i], field);
    }
    else{
       virginCount++;
       means[2] += getField(irisData[i], field);
    }
    //max or min
    if(getField(irisData[i], field) > max)
      max = getField(irisData[i], field);
    else if(getField(irisData[i], field) < min)
      min = getField(irisData[i], field);
  }  
  
  means[0] /= (float)setosaCount;
  means[1] /= (float)versiCount;  
  means[2] /= (float)virginCount;  
}
void findMedians(int field){
  int size = irisData.length/3;
  int setosaCount=0, versiCount=0, virginCount=0;
  float[] setosaData = new float[size];
  float[] versiData = new float[size];
  float[] virginData = new float[size];
  
  for(int i = 0; i < irisData.length; ++i){
    if(irisData[i].getName().equals("setosa")){
      setosaData[setosaCount] = getField(irisData[i], field);
      setosaCount++;
    }
    else if(irisData[i].getName().equals("versicolor")){
      versiData[versiCount] = getField(irisData[i], field);
      versiCount++;
    }
    else{
      virginData[virginCount] = getField(irisData[i], field);
      virginCount++;
    }
  }
 
  setosaData = sort(setosaData);
  versiData = sort(versiData);
  virginData = sort(virginData);
  
  medians[0] = .5*(setosaData[setosaData.length/2]+setosaData[setosaData.length/2+1]);
  medians[1] = .5*(versiData[versiData.length/2]+versiData[versiData.length/2+1]);  
  medians[2] = .5*(virginData[virginData.length/2]+virginData[virginData.length/2+1]);
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
void drawBar(int x, float value, color col){
  float mapped = map(value, min, max, offset+10, (height-2*offset));
 // print("Mapped value is " + mapped + "\n");
  
 //smooth();
  fill(col);
  noStroke();
  rect(x, height-mapped-offset, barWidth, mapped);
  
}
void drawLegend(){
  color r = color(255,0,0);
  color b = color(0,0,255);
  PFont font;
  font = loadFont("FranklinGothic-Heavy-12.vlw");
  textFont(font);
  
  fill(r);
  rect(width-2*offset, offset, 10, 10);
  fill(0);
  text("= Mean", width-2*offset+15, offset+9);
  fill(b);
  rect(width-2*offset, offset+20, 10, 10);
  fill(0);
  text("= Median", width-2*offset+15, offset+29);
  
}
void draw() {
  background(255,255,255);
  
  stroke(0,0,0);
  line(offset,offset,offset, height-offset);
  line(offset,height-offset,width-offset, height-offset);
  drawLegend();
  PFont font;
  font = loadFont("FranklinGothic-Heavy-20.vlw");
  textFont(font);
  color r = color(255,0,0);
  color b = color(0,0,255);
  int spacing = 80;
  for(int i = 0; i < 3; ++i){
    fill(0,0,0);
    text(irisNames[i], offset+2+2*i*barWidth + spacing*i, height-offset/2);
    drawBar(offset+2+2*i*barWidth + spacing*i, means[i], r);
    drawBar(offset+2+2*i*barWidth + barWidth + spacing*i, medians[i], b);
  }
  
  fill(0,0,0);
  text("0-", offset/2, height-offset+5);
  text(nf(max,1, 2)+"-", 0, offset+6);
}
