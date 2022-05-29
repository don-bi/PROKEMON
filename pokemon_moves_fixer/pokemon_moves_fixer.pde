
void setup(){
  try {
    int i = 0;
    BufferedReader reader = createReader("pokemon_moves.csv");
    PrintWriter export = createWriter("pokemon_moves1.csv");
    String line = reader.readLine();
    export.println(line);
    line = reader.readLine();
    while (line != null){
      String[] data = line.split(",");
      if (data[1].equals("11") && data[3].equals("1")){
        export.println(line);
      }
      line = reader.readLine();
    }
    export.flush();
    export.close();
    println("done");
  } catch (IOException e){}
}
  
