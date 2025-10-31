void pantalla1(){
 
  logo = loadImage("logo.png");
  image(logo, 40, 5);
  
  textSize(28);
  fill(#FFFFFF); // blanco
  text("ESTADO DE LA RED", 320, 50);
  text("DE COMUNICACIONES", 300, 80);
  textSize(10);
  text("v.3.0", 420, 100);
  textSize(14);
  
  //*********** GRUPO MONITOREO *******************
  text("MONITOREO", 70, 130);   
  noFill();
  stroke(150);
  rect(10,140,200,370);
  
  //*********** GRUPO TRACKERS *******************
  text("SISTEMA DE TRACKERS", 360, 130); 
  noFill();
  stroke(150);
  rect(220,140,200,190);
  
  noFill();
  stroke(150);
  rect(430,140,200,190);
  
  //*********** GRUPO HUAWAEI *******************
  text("STS", 730, 130);
  noFill();
  stroke(150);
  rect(640,140,210,130);
  
  //*********** GRUPO JANITZA *******************
  text("MEDIDOR JANITZA", 690, 380);
  noFill();
  stroke(150);
  rect(640,390,210,130);
  
  //*********** GRUPO RECONECTADOR *******************
  text("RECONECTADOR", 60, 530);
  noFill();
  stroke(150);
  rect(10,540,200,70);
  
  //*********** GRUPO LINEAS *******************
  stroke(#FFFF00); //amarillo
  line(210,440,640,440); // De MONITOREO a MEDIDOR ANITZA
  
  line(210,570,380,570); // Del reconectador (H)
  line(380,570,380,350); // Del reconectador (V)
  
  line(335,350,405,350); // Del NCU1 (H)
  line(335,330,335,350); // Del NCU1 (V)
  line(405,350,475,350); // Del NCU2 (H)
  line(475,330,475,350); // Del NCU2 (V)
  
  line(425,360,425,440); // De las STSs (V)
  line(425,360,660,360); // De las STSs (H)
  line(660,360,660,270); // De las STSs (V)
  
  //*********** SWITCH *******************
  iconoSwitch(370,430,#0000FF);
  
  //*********** Tiempo *******************
  stroke(#FFFFFF); //blanco
  noFill();
  rect(750,546,30,20);
  textSize(12);
  fill(#FFFFFF); // blanco
  text("Tiempo de muestreo:                seg",640,560);
  text(intervalo/1000,755,560);
}

/********************************************************
** iconoSwitch(int x, int y, int colores)
*********************************************************/
void iconoSwitch(int x, int y, int colores) {
  stroke(colores);
  fill(0);
  rect(x,y,86,22);
  noFill();
  for (int i=0; i<10; i++) {
   rect(x+4+i*8,y+4,6,6);
  }
  for (int i=0; i<10; i++) {
   rect(x+4+i*8,y+12,6,6);
  }
}
