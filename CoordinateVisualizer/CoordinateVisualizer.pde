import java.util.List;

// Shift + Ctrl + B : Run Task on Visual Studio Code

Table table;
TableRow columns;
int frame = 0;
int x = 0;
int y = 1;
int shiftX = 0; // parallel movement
float scale = 50;
int columnsCount;
int points;
int frames;

void settings() {
  // screen size
  //size(1080, 360);
  fullScreen();
}

void setup() {
  try {
    // import data
    String[] filename = loadStrings("fileName.txt");
    table = loadTable(filename[0]);
    frames = table.getInt(0, 0);
    columns = table.getRow(1);
    columnsCount = columns.getColumnCount();

    for (int i=columnsCount-1; i>=0; i--) {
      // remove column if it is not positiion data
      if (!columns.getString(i).contains("-Posi-")) {
        table.removeColumn(i);
      }
    }
    points = table.getColumnCount()/3;
    noStroke();
  } catch (Exception e) {
    println(e);
    exit();
  }
}

void draw() {
  // background
  fill(0, 0, 0, 10);
  rect(0,0,width,height);

  // markers
  fill(255);
  for (int i=0; i<points; i++) {
    ellipse(table.getFloat(frame+2, x+i*3)*scale + shiftX + width/2, -table.getFloat(frame+2, y+i*3)*scale + height, 3, 3);
  }

  // Grid
  stroke(255);
  line(width/2 + shiftX, 0, width/2 + shiftX, height);

  // button
  fill(0);
  rect(width - 48, height - 48, 40, 40); // move right
  rect(width - 98, height - 48, 40, 40); // move left
  rect(width - 48, 8, 40, 40); // quit
  
  // frame
  rect(width - 408, 8, 300, 40);

  // text
  fill(255);
  textAlign(LEFT, TOP);
  textSize(14);
  text("RIGHT", width-48, height-48);
  text("LEFT", width-98, height-48);
  text("QUIT", width-48, 8);
  textAlign(RIGHT, TOP);
  textSize(28);
  text("Frame : "+frame+"/"+frames, width-108, 8);

  // frame number increment
  if (frame+1 < frames) {
    frame++;
  } else {
    frame=0;
  }
}

void mouseClicked(){
  // move right
  if(mouseX>=width - 48 && mouseX<=width - 8 && mouseY>=height - 48 && mouseY<=height - 8){
    shiftX -= 50;
  }
  // move left
  if(mouseX>=width - 98 && mouseX<=width - 58 && mouseY>=height - 48 && mouseY<=height - 8){
    shiftX += 50;
  }
  // quit
  if(mouseX>=width - 48 && mouseX<=width - 8 && mouseY>=8 && mouseY<=48){
    exit();
  }
}