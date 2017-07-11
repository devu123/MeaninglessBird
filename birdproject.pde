//install these libraries if you don't have them
import ddf.minim.*;
import ddf.minim.analysis.*;
 
//defining variables, types to use later

//song variables
Minim minim;
AudioInput SongPlaying;
BeatDetect beatsong;
BeatListener bl;

float last, now, diff, entries, sum, beat,
lasttail, nowtail, difftail, entriestail,
beattail, sumtail, swingvaluetail, prevswingvaluetail,
swingvalue, prevswingvalue,
wingleftX1, wingleftX2, wingleftX3, wingleftX4, 
wingleftY1, wingleftY2, wingleftY3, wingleftY4,
wingrightX1, wingrightX2, wingrightX3, wingrightX4,
wingrightY1, wingrightY2, wingrightY3, wingrightY4,
tailvertex1X, tailvertex2X, tailvertex3X, tailvertex4X, 
tailvertex5X,
tailvertex1Y, tailvertex2Y, tailvertex3Y, tailvertex4Y,
tailvertex5Y,
hovervalue;


void setup(){
  size(500, 400);
  //initializing last to time program has been running
  last = millis();
  lasttail = millis();
  //initializing beat to random
  beat = 300;
  beattail = 100;
  smooth(4);
  //initialize swingvalues
  swingvalue = .02;
  swingvaluetail = .02;
  prevswingvalue = .01;
  prevswingvaluetail = .01;
  hovervalue = 0;
  //initialize vertices
  wingleftX1 = 223;
  wingleftX2 = 197;
  wingleftX3 = 210;
  wingleftX4 = 213;
  wingleftY1 = 250;
  wingleftY2 = 200;
  wingleftY3 = 150;
  wingleftY4 = 150;
  wingrightX1 = 247;
  wingrightX2 = 250;
  wingrightX3 = 263;
  wingrightX4 = 238;
  wingrightY1 = 150;
  wingrightY2 = 150;
  wingrightY3 = 200;
  wingrightY4 = 250;
  tailvertex1X = 240;
  tailvertex2X = 230;
  tailvertex3X = 220;
  tailvertex4X = 225;
  tailvertex5X = 235;
  tailvertex1Y = 300;
  tailvertex2Y = 290;
  tailvertex3Y = 300;
  tailvertex4Y = 250; 
  tailvertex5Y = 250; 
  //listen to song playing from computer stereo
  minim = new Minim(this);
  SongPlaying = minim.getLineIn(Minim.STEREO, 512);
  beatsong = new BeatDetect(SongPlaying.bufferSize(), SongPlaying.sampleRate());
  //setting sensitivity to 300, should be changed depending on your system.
  beatsong.setSensitivity(300);  
  bl = new BeatListener(beatsong, SongPlaying);  
}

//on keypress, get average time between bass beats
void keyPressed() {
  // wings beat
  if(beatsong.isKick() || beatsong.isSnare()){
     println("kicked");
     now = millis();
     diff =  now - last;
     last = now;
     sum = sum + diff;
     entries++;
     println(sum);
     float average = sum/entries ;
      //restart if too many iterations with sum set to average
     if(sum > 3000){
        sum = average;
        entries = 1;}
      // tracking average beats
      println ("average = " + average);
      beat = average;
      println("beat = " + beat);
      beat = beat / 1000;
      println(beat);
      beat = (beat * frameRate);
      println(beat);
    }
  //tail beat - set yourself by pressing t over and over
  if(key == 't'){
  nowtail = millis();
  difftail =  nowtail - lasttail;
  lasttail = nowtail;
  sumtail = sumtail + difftail;
  entriestail++;
  println(sumtail);
  float averagetail = sumtail/entriestail ;
  //restart if too many iterations with sum set to average
  if(sumtail > 3000){
    sumtail = averagetail;
    entriestail = 1;}
  // printing out average tail 
  println ("averagetail = " + averagetail);
  beattail = averagetail;
  println("beattail = " + beattail);
  beattail = beattail / 1000;
  println(beattail);
  beattail = (beattail * frameRate);
  println(beattail);
  }
}

void draw(){
  background(0);
    //event at average click time
    //increase swingvalue until 1
     
    if(prevswingvalue < swingvalue){ 
      if(swingvalue > .95){
        prevswingvalue = swingvalue;
        swingvalue = swingvalue - (1/beat);
      } else {
      prevswingvalue = swingvalue;
      swingvalue = swingvalue + (1/beat);
      }
    } 
    if(prevswingvalue > swingvalue){
      if(swingvalue < .05){
        prevswingvalue = swingvalue;
        swingvalue = swingvalue + (1/beat);

      } else {
      prevswingvalue = swingvalue;
      swingvalue = swingvalue - (1/beat);

      }
    }
   if(prevswingvaluetail < swingvaluetail){ 
      if(swingvaluetail > .95){
        prevswingvaluetail = swingvaluetail;
        swingvaluetail = swingvaluetail - (1/beattail);
      } else {
      prevswingvaluetail = swingvaluetail;
      swingvaluetail = swingvaluetail + (1/beattail);
      }
    } 
    if(prevswingvaluetail > swingvaluetail){
      if(swingvaluetail < .05){
        prevswingvaluetail = swingvaluetail;
        swingvaluetail = swingvaluetail + (1/beattail);

      } else {
      prevswingvaluetail = swingvaluetail;
      swingvaluetail = swingvaluetail - (1/beattail);
      }
    }
    // interpolate linearly with speed as swingvalue
    hovervalue = lerp(beat/10, beat/10 - 20, swingvalue);


  
  //wingleft1 and wingright4 is  correspond, 2 and 3 correspond
  wingleftX1 = lerp(223, 170, swingvalue);
  wingleftX2 = lerp(197, 90, swingvalue);
  wingleftY1 = lerp(250, 150, swingvalue);
  wingleftY2 = lerp(200, 120, swingvalue);
  wingrightX3 = lerp(263, 370, swingvalue);
  wingrightX4 = lerp(238, 291, swingvalue);
  wingrightY3 = lerp(200, 120, swingvalue);
  wingrightY4 = lerp(250, 150, swingvalue);
  
  //tailmovement
  tailvertex1X = lerp(230, 250, swingvaluetail);
  tailvertex2X = lerp(220, 240, swingvaluetail);
  tailvertex3X = lerp(210, 230, swingvaluetail);
  tailvertex1Y = lerp(305, 295, swingvaluetail);
  tailvertex2Y = lerp(290, 290, swingvaluetail);
  tailvertex3Y = lerp(295, 305, swingvaluetail);
  
  //reset tail to left on beat at top of flap
  if(wingleftY1 < lerp(250, 150, .9)){
    swingvaluetail = .02;
    prevswingvaluetail = .01;
  }
  
  
  //tail
    createShape();
    beginShape();
    fill(30);
    vertex(tailvertex1X,tailvertex1Y + hovervalue); //tail corner
    vertex(tailvertex2X,tailvertex2Y + hovervalue); //tail corner
    vertex(tailvertex3X,tailvertex3Y + hovervalue); //tail corner
    vertex(tailvertex4X,tailvertex4Y + hovervalue); //tail corner
    vertex(tailvertex5X,tailvertex5Y + hovervalue); //tail corner
    endShape();
   //body
    createShape();
    beginShape();  
    fill(121,71,0); 
    vertex(225,250 + hovervalue); //tail corner
    vertex(200,200 + hovervalue);
    vertex(210,150 + hovervalue);
    vertex(250,150 + hovervalue);
    vertex(260,200 + hovervalue);
    vertex(235,250 + hovervalue); //tail corner
    endShape();
   //head
    createShape();
    beginShape();
    vertex(210,150 + hovervalue); //body corner
    vertex(220,140 + hovervalue);
    
    vertex(215,130 + hovervalue); //head
    vertex(218,115 + hovervalue);
    vertex(220,108 + hovervalue);
    vertex(230,100 + hovervalue);
    vertex(240,108 + hovervalue);
    vertex(242,115 + hovervalue);
    vertex(245,130 + hovervalue);
    
    vertex(240,140 + hovervalue);
    vertex(250,150 + hovervalue); //body corner
    endShape();
    //beak
    fill(87,42,0);
    createShape();
    beginShape();
    vertex(230,125 + hovervalue);
    vertex(250,137 + hovervalue);
    vertex(225,135 + hovervalue);
    endShape();
    //eyes
    fill(0);
    ellipse(225, 115 + hovervalue, 7, 6);
    ellipse(235, 115 + hovervalue, 7, 6);
     
    //wings
    fill(114,25,0);
    createShape();
    beginShape();
    vertex(wingleftX1,wingleftY1 + hovervalue); //tail corner
    vertex(wingleftX2,wingleftY2 + hovervalue);
    vertex(wingleftX3,wingleftY3 + hovervalue);
    vertex(wingleftX4,wingleftY4 + hovervalue);
    endShape();
    
    createShape();
    beginShape();
    vertex(wingrightX1,wingrightY1 + hovervalue);
    vertex(wingrightX2,wingrightY2 + hovervalue);
    vertex(wingrightX3,wingrightY3 + hovervalue);
    vertex(wingrightX4,wingrightY4 + hovervalue); //tail corner
    endShape();
}

 
 void stop() {
  //  close Minim audio classes
  SongPlaying.close();
  minim.stop();
  super.stop();
}

  // class beatListener to detect beat
  class BeatListener implements AudioListener
  {
    private BeatDetect beat;
    private AudioInput source;
 
    BeatListener(BeatDetect beat, AudioInput source)
    {
      this.source = source;
      this.source.addListener(this);
      this.beat = beat;
    }
 
    void samples(float[] samps)
    {
      beat.detect(source.mix);
    }
 
    void samples(float[] sampsL, float[] sampsR)
    {
      beat.detect(source.mix);
    }
  } 