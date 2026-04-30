// --- RAIN VARIABLES ---
int totalRain = 80;
float[] rx = new float[totalRain];
float[] ry = new float[totalRain];
float[] rspeed = new float[totalRain];

// --- RAIN SPEED CONTROL ---
float speedMult = 1.0;

// --- WINDOW LIGHT FLICKER ---
int flickerTimer = 0;
boolean win1on = true;
boolean win2on = true;

void setup() {
  size(700, 500);
  frameRate(60);

  // give each raindrop a random start position
  for (int i = 0; i < totalRain; i++) {
    rx[i] = random(0, width);
    ry[i] = random(-height, 0);
    rspeed[i] = random(5, 12);
  }
}

void draw() {

  // ---- BACKGROUND SKY ----
  background(15, 18, 40);

  // ---- STARS ----
  fill(255, 255, 255);
  noStroke();
  for (int i = 0; i < 40; i++) {
    float sx = (i * 173) % width;
    float sy = (i * 97) % (height / 2);
    ellipse(sx, sy, 2, 2);
  }

  // ---- MOON ----
  noStroke();
  fill(255, 245, 180);
  ellipse(580, 70, 55, 55);
  fill(15, 18, 40);
  ellipse(595, 65, 46, 48);

  // ---- CLOUDS ----
  noStroke();
  fill(40, 45, 70);
  ellipse(120, 80, 130, 50);
  ellipse(180, 70, 100, 45);
  ellipse(60, 90, 90, 40);

  fill(35, 40, 65);
  ellipse(450, 60, 150, 55);
  ellipse(510, 50, 100, 45);
  ellipse(390, 75, 90, 40);

  // ---- BUILDINGS ----
  drawBuildings();

  // ---- RAIN ----
  float windX = map(mouseX, 0, width, -4, 4);

  stroke(130, 160, 220, 160);
  strokeWeight(1.2);

  for (int i = 0; i < totalRain; i++) {
    line(rx[i], ry[i],
         rx[i] - windX * 2,
         ry[i] + rspeed[i] * speedMult);

    ry[i] += rspeed[i] * speedMult;
    rx[i] += windX;

    if (ry[i] > height) {
      ry[i] = random(-60, -5);
      rx[i] = random(0, width);
    }
  }

  noStroke();

  // ---- WINDOW FLICKER ----
  flickerTimer++;
  if (flickerTimer > 90) {
    win1on = (random(1) > 0.3);
    win2on = (random(1) > 0.4);
    flickerTimer = 0;
  }

  // ---- PUDDLES ----
  stroke(60, 80, 140, 120);
  strokeWeight(1);
  noFill();
  ellipse(120, height - 10, 90, 12);
  ellipse(350, height - 8, 70, 10);
  ellipse(560, height - 11, 80, 11);

  noStroke();

  // ---- HUD ----
  fill(160, 180, 210, 160);
  textSize(12);
  textAlign(LEFT, TOP);
  text("Move mouse left/right - change wind", 10, 10);
  text("UP - faster rain  |  DOWN - slower rain", 10, 26);
}

// ---- DRAW BUILDINGS ----
void drawBuildings() {

  fill(25, 28, 55);
  rect(0, 260, 90, 240);
  drawWindows(0, 260, 90, 240, 4, 5, win1on);

  fill(20, 22, 50);
  rect(95, 300, 70, 200);
  drawWindows(95, 300, 70, 200, 3, 4, true);

  fill(30, 32, 60);
  rect(170, 200, 110, 300);
  drawWindows(170, 200, 110, 300, 4, 6, win2on);

  fill(22, 25, 52);
  rect(285, 250, 85, 250);
  drawWindows(285, 250, 85, 250, 3, 5, true);

  fill(28, 30, 58);
  rect(375, 220, 100, 280);
  drawWindows(375, 220, 100, 280, 4, 6, win1on);

  fill(18, 20, 48);
  rect(480, 280, 80, 220);
  drawWindows(480, 280, 80, 220, 3, 4, true);

  fill(26, 28, 56);
  rect(565, 240, 135, 260);
  drawWindows(565, 240, 135, 260, 4, 5, win2on);

  fill(20, 20, 30);
  rect(0, height - 30, width, 30);

  stroke(60, 60, 80);
  strokeWeight(2);
  for (int i = 0; i < width; i += 60) {
    line(i, height - 15, i + 30, height - 15);
  }
  noStroke();
}

// ---- DRAW WINDOWS ----
void drawWindows(float bx, float by, float bw, float bh,
                 int cols, int rows, boolean lit) {

  float winW = 10;
  float winH = 9;
  float spacingX = bw / (cols + 1);
  float spacingY = bh / (rows + 1);

  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {

      float wx = bx + spacingX * (c + 1) - winW / 2;
      float wy = by + spacingY * (r + 1) - winH / 2;

      if (lit && (r + c) % 3 != 0) {
        fill(255, 240, 140, 200);
      } else if ((r * c) % 5 == 0) {
        fill(120, 180, 255, 160);
      } else {
        fill(20, 22, 40);
      }

      rect(wx, wy, winW, winH);
    }
  }
}

// ---- KEYBOARD ----
void keyPressed() {
  if (keyCode == UP) {
    speedMult = speedMult + 0.5;
    if (speedMult > 3.0) speedMult = 3.0;
  }
  if (keyCode == DOWN) {
    speedMult = speedMult - 0.5;
    if (speedMult < 0.5) speedMult = 0.5;
  }
}
