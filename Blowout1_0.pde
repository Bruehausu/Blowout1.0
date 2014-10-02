//Blowout. When you're swirly and you're curly, then you're kitsch

int[] points;
int[] mpoints;

//generates the points used to make the base curve, as well as define
//the static edge cases for the rendered lines
void setup(){
  size(600,600);
  points = new int[24];
  points[0] = 0;
  points[1] = 0;
  points[22] = width;
  points[23] = height;
  for(int i = 0; i < 10;i++){
    points[2*(i+1)] = int(width * noise((2*i)/1.0));
    points[(2*(i+1)+1)] = int(height * noise((2*i + 20)/1.0));
  }
  for(int i = 0;i<12;i++){
    println("point "+i+": "+points[2*i]+", "+points[(2*i)+1]);
  }
  mpoints = new int[24];  
  mpoints[0] = 0;
  mpoints[1] = 0;
  mpoints[22] = width;
  mpoints[23] = height;
}

//adjusts the rendered point based on the position of the mouse.
int[] adjust( int x, int y, int px, int py){
  int[] result = new int[2];
  float dist = sqrt(sq(px-x) + sq(py-y))/60.0;
  if(dist == 0.0){ dist = 0.1;} 
  result[0] = int(px + (px - x)/dist);
  result[1] = int(py + (py - y)/dist);
  return result;
}

int[] pair;

//creates an updated version of each point based on the original
//generation and the position of the mouse, then draws the line
void draw(){
  background(255);
  int x = mouseX;
  int y = mouseY;
  for(int i = 0; i < 10 ; i++){
    pair = adjust(x, y, points[2*(i+1)], points[(2*(i+1))+1]);
    mpoints[2*(i+1)] = pair[0];
    mpoints[(2*(i+1))+1] = pair[1];
  }
  strokeWeight(3);
  noFill();
  stroke(0,0,0);
  curve(mpoints[0],mpoints[1], mpoints[0],mpoints[1],
        mpoints[2],mpoints[3], mpoints[4],mpoints[5]);
  for(int i = 0;i<9;i++){
    curve(mpoints[2*i],mpoints[2*i+1], mpoints[2*i+2],mpoints[2*i+3],
          mpoints[2*i+4],mpoints[2*i+5],mpoints[2*i+6],mpoints[2*i+7]); 
  }
  curve(mpoints[18],mpoints[19], mpoints[20],mpoints[21], 
        mpoints[22],mpoints[23], mpoints[22],mpoints[23]);
}
