# Musical Typographic Pointillisme 
A simple project done with Processing for the course "Shapes and Algorithms: Computational Tools for Generative Design" held in Politecnico di Milano in 2022
***
The basic idea was to use images from movies that could act as visualizers of the movie soundtracks.  
  
  
First, the code takes the letters of the filename of the image (in these cases the title of the film itself).  
The letters are used to create a grid that recomposes the image based on the brightness and color of the pixel corresponding to the letter coordinates.  
  
The audio file in the data folder is then searched and played. During playback, the waveform of the audio is analyzed and the size of the letters is changed according to it.  

To have harmonious movements and not too large letters, it is used the remap and also it is added a smoothness factor.  
  
### Please note  
Be careful to upload only one image and one song at time in the data folder, otherwise the program does not know which is the file to read.  
There are few more examples in the "other examples" folder, in order to see how the code behaves with other songs and images.

## Results  





https://user-images.githubusercontent.com/60142505/211197236-cd2434f9-e1be-46cb-a766-b17e1687f4f3.mov





https://user-images.githubusercontent.com/60142505/211197306-e0b662f9-392e-471e-9b44-0820ed413a48.mov


