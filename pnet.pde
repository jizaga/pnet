import java.net.InetAddress;
import java.util.concurrent.*;

PImage logo;

int cols = 3;
int intervalo;
ExecutorService pool;
PVector botonPos;
int botonW = 120, botonH = 40;

String rutaArchivo;
String rutaArchivoVar;

/********* FUNCIÓN SETUP ***************************************************/
void setup () {
  size(860, 620);
  background(0);
  
  rutaArchivo = dataPath("dispositivos.json");
  rutaArchivoVar = dataPath("var.json");

  cargarDispositivos(rutaArchivo);
  cargarVariables(rutaArchivoVar);
  
  pool = Executors.newFixedThreadPool(10);
  botonPos = new PVector(width - botonW - 20, 20);
  
  for (Dispositivo d : dispositivos) {
    d.online = false;
    d.verificando = false;
    d.ultimaVerificacion = 0;
    d.latencia = -1; // en ms
    d.editando = false;
  }
  
  for (Variable v : variables) {
    intervalo = v.tiempo*1000;
  }
  
  pantalla1();

}

/********* FUNCIÓN DRAW ***************************************************/
void draw(){
  for (int i = 0; i < dispositivos.length; i++) {
    drawCard(dispositivos[i]);
  }

  for (Dispositivo d : dispositivos) {
    if (millis() - d.ultimaVerificacion > intervalo && !d.verificando) {
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
  drawBoton();
}
