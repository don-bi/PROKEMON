
void setup(){
  try {
    BufferedReader reader = createReader("pokemon_moves");
    PrintWriter export = createWriter("pokemon_moves1.csv");
    String line = reader.readLine();
    export.println(line);
    line = reader.readLine();
    while (line != null){
      String[] data = line.split(",");
      if (data[1].equals("8")){
        export.println(line);
      }
    }
    export.flush();
    export.close();
  } catch (IOException e){}
}
  
