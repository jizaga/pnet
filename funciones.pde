
/***********************************************
** class Dispositivo
************************************************/
class Dispositivo {
  String nombre;
  String ip;
  int xpos, ypos;
  int icono;
  int ixpos, iypos;
  boolean online = false;
  boolean verificando = false;
  long ultimaVerificacion = 0;
  int latencia = -1; // en ms
  boolean editando = false;

  Dispositivo(String nombre, String ip, int xpos, int ypos, int icono, int ixpos, int iypos) {
    this.nombre = nombre;
    this.ip = ip;
    this.xpos = xpos;
    this.ypos = ypos;
    this.icono = icono;
    this.ixpos = ixpos;
    this.iypos = iypos;
  }
}

Dispositivo[] dispositivos;

/***********************************************
** class Variables
************************************************/
class Variable {
  int tiempo;
  
  Variable(int tiempo) {
    this.tiempo = tiempo;
  }
}

Variable[] variables;

//*********************************************************************************************
// Convertir un dispositivo a JSONObject
JSONObject dispositivoToJSON(Dispositivo d) {
  JSONObject json = new JSONObject();
  json.setString("nombre", d.nombre);
  json.setString("ip", d.ip);
  json.setInt("xpos", d.xpos);
  json.setInt("ypos", d.ypos);
  json.setInt("icono", d.icono);
  json.setInt("ixpos", d.ixpos);
  json.setInt("iypos", d.iypos);
  json.setBoolean("online", d.online);
  json.setBoolean("verificando", d.verificando);
  json.setLong("ultimaVerificacion", d.ultimaVerificacion);
  json.setInt("latencia", d.latencia);
  json.setBoolean("editando", d.editando);
  return json;
}

// Convertir una variable a JSONObject
JSONObject variableToJSON(Variable v) {
  JSONObject json = new JSONObject();
  json.setInt("tiempo", v.tiempo);
  return json;
}

//*********************************************************************************************
// Convertir de JSONObject a Dispositivo
Dispositivo dispositivoFromJSON(JSONObject json) {
  Dispositivo d = new Dispositivo(
    json.getString("nombre"),
    json.getString("ip"),
    json.getInt("xpos"),
    json.getInt("ypos"),
    json.getInt("icono"),
    json.getInt("ixpos"),
    json.getInt("iypos")
  );
  d.online = json.getBoolean("online");
  d.verificando = json.getBoolean("verificando");
  d.ultimaVerificacion = json.getLong("ultimaVerificacion");
  d.latencia = json.getInt("latencia");
  d.editando = json.getBoolean("editando");
  return d;
}

// Convertir de JSONObject a Variable
Variable variableFromJSON(JSONObject json) {
  Variable v = new Variable(
    json.getInt("tiempo")
  );
  return v;
}

//*********************************************************************************************
//******* Guardar arreglo Dispositivo[] a JSON
void guardarDispositivos(String archivo) {
  JSONArray jsonArray = new JSONArray();
  for (Dispositivo d : dispositivos) {
    jsonArray.append(dispositivoToJSON(d));
  }
  saveJSONArray(jsonArray, archivo);
  println("> Dispositivos guardados en: " + archivo);
}

//******* Guardar arreglo Variable[] a JSON
void guardarVariables(String archivo) {
  JSONArray jsonArray = new JSONArray();
  for (Variable v : variables) {
    jsonArray.append(variableToJSON(v));
  }
  saveJSONArray(jsonArray, archivo);
  println("> Variables guardadas en: " + archivo);
}

//*********************************************************************************************
//******** Leer desde JSON y cargar a Dispositivo[]
void cargarDispositivos(String archivo) {
  File f = new File(archivo);
  if (!f.exists()) {
    println(">️ Archivo no existe. Se usará la lista por defecto.");
    return;
  }

  JSONArray jsonArray = loadJSONArray(archivo);
  dispositivos = new Dispositivo[jsonArray.size()];
  for (int i = 0; i < jsonArray.size(); i++) {
    JSONObject obj = jsonArray.getJSONObject(i);
    dispositivos[i] = dispositivoFromJSON(obj);
  }
  println("> Dispositivos cargados desde: " + archivo);
}

//******** Leer desde JSON y cargar a Variables[]
void cargarVariables(String archivo) {
  File f = new File(archivo);
  if (!f.exists()) {
    println(">️ Archivo no existe. Se usará la lista por defecto.");
    return;
  }

  JSONArray jsonArray = loadJSONArray(archivo);
  variables = new Variable[jsonArray.size()];
  for (int i = 0; i < jsonArray.size(); i++) {
    JSONObject obj = jsonArray.getJSONObject(i);
    variables[i] = variableFromJSON(obj);
  }
  println("> Variables cargados desde: " + archivo);
}


/***********************************************
** drawBoton()
************************************************/
void drawBoton() {
  fill(60, 120, 240);
  stroke(20);
  rect(botonPos.x, botonPos.y, botonW, botonH, 10);
  fill(255);
  text("REFRESCAR", botonPos.x + botonW/3-12, botonPos.y + botonH/2+5);
}

/***********************************************
** mousePressed()
************************************************/
void mousePressed() {
  // botón de refresco
  if (mouseX > botonPos.x && mouseX < botonPos.x + botonW && mouseY > botonPos.y && mouseY < botonPos.y + botonH) {
    for (Dispositivo d : dispositivos) {
      if (!d.verificando) {
        d.verificando = true;
        d.ultimaVerificacion = millis();
        pool.submit(() -> {
          long t0 = millis();
          d.online = pingHost(d.ip, 1000);
          d.latencia = d.online ? int(millis() - t0) : -1;
          d.verificando = false;
        });
      }
    }
  }

  // detección de doble clic sobre tarjeta  rect(d.xpos, d.ypos-12, 148, 55);
  if (mouseEvent.getCount() == 2) {
    for (int i = 0; i < dispositivos.length; i++) {
      if (mouseX > dispositivos[i].xpos && mouseX < dispositivos[i].xpos + 148 && mouseY > dispositivos[i].ypos && mouseY < dispositivos[i].ypos + 55) {
        dispositivos[i].editando = true;
        println("Editar: " + dispositivos[i].nombre);
        String nuevo = showInputDialog(dispositivos[i]);
        if (nuevo != null && nuevo.contains("@")) {
          String[] partes = nuevo.split("@");
          if (partes.length == 2) {
            dispositivos[i].nombre = partes[0].trim();
            dispositivos[i].ip = partes[1].trim();
          }
        }
        guardarDispositivos(rutaArchivo);
        dispositivos[i].editando = false;
      }
    }
    
    for (int i = 0; i < variables.length; i++) {
      if (mouseX > 750 && mouseX < 750 + 30 && mouseY > 546 && mouseY < 546 + 20) {
        String nuevo = showInputDialogVar(variables[i]);
        if (nuevo != null) {
          variables[i].tiempo = int(nuevo);
          intervalo = int(nuevo) *1000;
          stroke(#FFFFFF); //blanco
          fill(#000000); // negro
          rect(750,546,30,20);
          textSize(12);
          fill(#FFFFFF); // blanco
          text(intervalo/1000,755,560);
        }
        guardarVariables(rutaArchivoVar);
      }
    }
  }
}

/***********************************************
** showInputDialog(Dispositivo d)
************************************************/
// Mostrar input modal usando JOptionPane
String showInputDialog(Dispositivo d) {
  return javax.swing.JOptionPane.showInputDialog("Editar nombre e IP (formato: Nombre@IP)", d.nombre + "@" + d.ip);
}

/***********************************************
** showInputDialogVar(Variable v)
************************************************/
// Mostrar input modal usando JOptionPane
String showInputDialogVar(Variable v) {
  return javax.swing.JOptionPane.showInputDialog("Editar el tiempo de muestreo (segundos)", v.tiempo);
}

/***********************************************
** pingHost(String ip, int timeout)
************************************************/
boolean pingHost(String ip, int timeout) {
  try {
    InetAddress address = InetAddress.getByName(ip);
    return address.isReachable(timeout);
  } catch (Exception e) {
    println("Error en " + ip + ": " + e.getMessage());
    return false;
  }
}

/***********************************************
** exit()
************************************************/
void exit() {
  pool.shutdownNow();
  super.exit();
}

/***********************************************
** drawCard(Dispositivo d)
************************************************/
void drawCard(Dispositivo d) {
  int colores;
  noStroke();
  fill(0);
  rect(d.xpos, d.ypos-12, 148, 55);

  fill(255);
  if (d.editando) {
    fill(0);
    text(d.nombre + " @ " + d.ip, d.xpos, d.ypos);
  } else {
    text(d.nombre, d.xpos, d.ypos);
    text(d.ip, d.xpos, d.ypos+14);
  }

  if (d.verificando) {
    fill(200, 200, 0);
    text("Verificando...", d.xpos, d.ypos+28);
    colores = #FFFF00; // = amarillo
  } else if (d.online) {
    fill(0, 200, 0);
    text("Online (" + d.latencia + "ms)", d.xpos, d.ypos+28);
    colores = #00FF00; // = verde
  } else {
    fill(200, 0, 0);
    text("Offline", d.xpos, d.ypos+28);
    colores = #FF0000; // = rojo
  }

  switch(d.icono) {
  case 1:  // icono PC
    // limpiar
    fill(0);
    rect(d.ixpos-4,d.iypos-2,36,33);
    // icono
    stroke(colores);
    noFill();
    rect(d.ixpos  ,d.iypos   ,27,20,5);
    rect(d.ixpos+2,d.iypos+2 ,23,16,5);
    rect(d.ixpos-2,d.iypos+24,31,4);
    rect(d.ixpos-2,d.iypos+24,31,2);
    break;
  case 2:  // icono Medidor diferencial
    // limpiar
    fill(0);
    rect(d.ixpos-2,d.iypos-2,36,34);
    // icono
    stroke(colores);
    noFill();
    rect(d.ixpos,d.iypos,30,30,5);
    rect(d.ixpos+9,d.ypos+2,12,9);
    for (int i=0;i<6;i++) {
      rect(d.ixpos+4+(i*4),d.iypos+14,3,3);
    }
    circle(d.ixpos+10,d.iypos+24,8);
    rect(d.ixpos+17,d.iypos+20,7,8);
    break;
  case 3:  // icono Router
    // limpiar
    fill(0);
    rect(d.ixpos-16,d.iypos-16,34,34);
    // icono
    stroke(colores);
    noFill();
    circle(d.ixpos,d.iypos,30);
    line(d.ixpos-10,d.iypos-10,d.ixpos+10,d.iypos+10);
    line(d.ixpos-10,d.iypos+10,d.ixpos+10,d.iypos-10);
    break;
  case 4: // icono Convertidor RS-485 a Ethernet
    // limpiar
    fill(0);
    rect(d.ixpos-4,d.iypos-2,34,24);
    // icono
    stroke(colores);
    noFill();
    rect(d.ixpos,d.iypos,24,17);
    rect(d.ixpos-3,d.iypos+2,3,6);
    rect(d.ixpos-2,d.iypos+10,2,4);
    rect(d.ixpos+24,d.iypos+5,3,5);
    fill(colores);
    textSize(8);
    text("FO",d.ixpos+2,d.iypos+8);
    text("RS485",d.ixpos+2,d.iypos+15);
    fill(#FFFFFF); // blanco
    textSize(14);
    break;
  case 5:  // icono GW de las NCUs
    // limpiar
    fill(0);
    rect(d.ixpos-6,d.iypos-2,34,24);
    // icono
    stroke(colores);
    noFill();
    rect(d.ixpos,d.iypos,21,16);
    rect(d.ixpos-4,d.iypos+5,4,6);
    rect(d.ixpos+21,d.iypos+1,4,6);
    rect(d.ixpos+21,d.iypos+9,4,6);
    fill(colores);
    textSize(10);
    text("GW",d.ixpos+4,d.iypos+12);
    fill(#FFFFFF); // blanco
    textSize(14);
    break;
  case 6:  // icono de la CPU de las NCUs
    // limpiar
    fill(0);
    rect(d.ixpos-4,d.iypos-2,32,38);
    // icono
    stroke(colores);
    noFill();
    rect(d.ixpos,d.iypos,18,32);
    circle(d.ixpos+9,d.iypos+6,4);
    circle(d.ixpos+9,d.iypos+12,4);
    rect(d.ixpos+7,d.iypos+20,3,5);
    rect(d.ixpos+10,d.iypos+21,2,3);
    break;
  case 7:  // icono del Recloser
    // limpiar
    fill(0);
    rect(d.ixpos-7,d.iypos-7,32,39);
    // icono
    stroke(colores);
    noFill();
    circle(d.ixpos,d.iypos,10);
    circle(d.ixpos,d.iypos+6,10);
    line(d.ixpos,d.iypos+11,d.ixpos,d.iypos+18);
    line(d.ixpos,d.iypos+18,d.ixpos-2,d.iypos+15);
    line(d.ixpos,d.iypos+18,d.ixpos+2,d.iypos+15);
  
    circle(d.ixpos+16,d.iypos,10);
    circle(d.ixpos+16,d.iypos+6,10);
    line(d.ixpos+16,d.iypos+11,d.ixpos+16,d.iypos+18);
    line(d.ixpos+16,d.iypos+18,d.ixpos+14,d.iypos+15);
    line(d.ixpos+16,d.iypos+18,d.ixpos+18,d.iypos+15);
  
    fill(colores);
    textSize(10);
    text("TC",d.ixpos-5,d.iypos+30);
    text("TP",d.ixpos+11,d.iypos+30);
    fill(#FFFFFF); // blanco
    textSize(14);
    break;
  case 8:  // icono del Smartlogger
    // limpiar
    fill(0);
    rect(d.ixpos-2,d.iypos-5,38,25);
    // icono
    stroke(colores);
    noFill();
    rect(d.ixpos,d.iypos,32,14);
    rect(d.ixpos+2,d.iypos+7,4,4);
    rect(d.ixpos+9,d.iypos+2,4,2);
    rect(d.ixpos+10,d.iypos+4,2,2);
    rect(d.ixpos+9,d.iypos+8,4,2);
    rect(d.ixpos+10,d.iypos+10,2,2);
    rect(d.ixpos+17,d.iypos+7,3,4);
    rect(d.ixpos+22,d.iypos+7,3,4);
    rect(d.ixpos+27,d.iypos+7,3,4);
    break;
  case 9:  // icono del Janitza
    // limpiar
    fill(0);
    rect(d.ixpos-2,d.iypos-5,38,25);
    // icono
    stroke(colores);
    noFill();
    rect(d.ixpos,d.iypos,32,16); //580, 405
    line(d.ixpos,d.iypos+2,d.ixpos+32,d.iypos+2);
    line(d.ixpos,d.iypos+14,d.ixpos+32,d.iypos+14);
    rect(d.ixpos+27,d.iypos+4,3,3);
    rect(d.ixpos+27,d.iypos+9,3,3);
    rect(d.ixpos+13,d.iypos+4,12,8);
    rect(d.ixpos+2,d.iypos+8,4,3);
    rect(d.ixpos+3,d.iypos+11,2,2);
    break;
  case 10:  // icono del FusionSolar
    // limpiar
    fill(0);
    rect(d.ixpos-2,d.iypos-2,68,68);
    // icono
    if (colores == #FF0000) { //= rojo
      image(loadImage("Fsolar_r.png"), d.ixpos, d.iypos);
    }
    if (colores == #00FF00) { //= verde
      image(loadImage("Fsolar_v.png"), d.ixpos, d.iypos);
    }
    if (colores == #FFFF00) { //= amarillo
      image(loadImage("Fsolar_a.png"), d.ixpos, d.iypos);
    }
    break;
  }
  fill(100);
  text("Última: " + (d.ultimaVerificacion > 0 ? nf(int((millis()-d.ultimaVerificacion)/1000), 0) + "s" : "N/A"), d.xpos, d.ypos+40);
}
