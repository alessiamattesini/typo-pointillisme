import java.util.Date;
import processing.sound.*;

//image and font
PImage img;
PFont font;


//variables for image and sound checking
String extension1 = "png";
String extension2 = "jpg";
String extension3 = "PNG";
String extension4 = "JPG";
String audioextension1 = "mp3";
String audioextension2 = "MP3";
String audioextension3 = "wav";
String audioextension4 = "WAV";

//variables for the letters grid
int[][] myArray;

char[] letters;
String[] splitted;

//some variables for the letters' movement
float size;
float value;
float brightness_factor;
float smooth = 0.25;

// Declare the sound source and Waveform analyzer variables
SoundFile sample;
Waveform waveform;
String song;

// Define how many samples of the Waveform you want to be able to read at once
int samples;



public void setup() {
  
  //canvas as large as the screen
  fullScreen();
  samples = width;
     
  // Path of the folder data where the image is located
  String path = dataPath("");

  //get all the files in the folder
  File[] files = listFiles(path);
  for (int i = 0; i < files.length; i++) {
    
    //get the name of the files
    File f = files[i];    
    println("Name: " + f.getName());
    
    //split the name file from the extension of the file
    String name_tosplit = f.getName();
    splitted = split(name_tosplit, '.');
    println(splitted[1]);
    
    //WARNING: UPLOAD ONLY ONE IMAGE AND ONE SONG AT A TIME  IN THE DATA FOLDER
    //if the extension is jpg or png
    if(splitted[1].equals(extension1) == true || splitted[1].equals(extension2) == true || splitted[1].equals(extension3) == true || splitted[1].equals(extension4) == true){
        
        //do a character array with the name of the file
        letters = splitted[0].toCharArray();
        println(letters); //check if everything it's okay     
        //get the file
        img = loadImage(splitted[0] + "." + splitted[1]);
      
    }
    
    //if the extension is a mp3 or a wav get the name and assign it to the string song
    if(splitted[1].equals(audioextension1) == true || splitted[1].equals(audioextension2) == true || splitted[1].equals(audioextension3) == true || splitted[1].equals(audioextension4) == true){
    
      song = splitted[0] + "." + splitted[1];
    
    }
    
  }
  
   // Load and play a soundfile.
  sample = new SoundFile(this, song);
  sample.play();
  //sample.loop(); //in case you want to loop  it.

  // Create the Waveform analyzer and connect the playing soundfile to it
  waveform = new Waveform(this, samples);
  waveform.input(sample);
  
  //fit the image to the screen
  if(img.width > img.height){
  
    img.resize(0, height);
    
    if(img.width < width){
    
      img.resize(width, 0);
      
    }
  
  }  else if (img.width <= img.height){
  
    img.resize(width, 0);
  
  }
  
  //center the image
  imageMode(CENTER);
  
  //load the font
  font = createFont("SpaceGrotesk-Regular.ttf", 40);
 
  //assign to every pixel of the image one random letter
  int cols = width;
  int rows = height;
  
  myArray = new int[cols][rows];
  
  //in this way the letter chosen for every pixel is fixed
  for (int ix = 0; ix < width; ix += 1) {
    for (int jy = 0; jy < height; jy += 1) {
      
        myArray[ix][jy] = int(random(letters.length));
        
    }
  }
 
}

public void draw() {
  
  background(0);

  // Perform the analysis
  waveform.analyze();
  

  //draw a grid of letters spaced by 10px, based on the letter value in the setup
  for (int i = 0; i < width; i += 10) {
    for (int j = 0; j < height; j += 10) {
      
      //get the  color of the pixel and then the brightness
      color c = img.get(i , j);
      value = brightness(c);
      
      //I want that the size of the letters is linked to the brightness: the brighter, the bigger
      //brightness value is between 0 and 255, I want to remap from 0px to 10px for the font size
      brightness_factor  = 255/10;
      
     fill(c); 
     text(letters[myArray[i][j]], i, j);
      
    }
    
    //map the value of the waveform:
    //the value of the waveform goes from -1 to 1
    //In this way the minimum depends on the brigthness of the pixel and the maximum is set to 90
    //I have consider a maximum of 90 since I  want to smooth the  animation then
    
    size = map(waveform.data[i], -1, 1, value/brightness_factor, 90);
    
    //multiplying the size for the smooth factor in order to make the animation... smoother
    textSize(size * smooth); 
    
  }
}
