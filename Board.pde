class Board{
  
  //coin vectors
 Vector<Vector<Coin>> board=new Vector<Vector<Coin>>();
 Vector<Pair> toUpdate=new Vector<Pair>();
 
 //initialize board
 Board(){
   for (int i=0; i<8;i++){
     Vector<Coin> temp=new Vector<Coin>();
     for (int j=0; j<8; j++){
       Coin coin=new Coin(90+i*60,140+j*60,floor((float)Math.random()*6));
       temp.add(coin);
       //coin.drawC();
     }
     board.add(temp);
   }
 }
 
 //draw board func
 void drawBoard(){
 for (int i=0; i<8;i++){
     Vector<Coin> temp=board.elementAt(i);
     for (int j=0; j<8; j++){
       Coin coin=temp.elementAt(j);
       coin.drawC();
     }
   }
 }
 
 
 //check if any rows or cols have >=3 colors in a row
 void checkMatching(){
   toUpdate.clear();
   int col=-1;
   int reps=1;
   
    for (int i=0; i<8; i++){
     Vector<Pair> pairs= new Vector<Pair>();
     col=-1;
     for (int j=0; j<8; j++){
       Pair par= new Pair(j,i);
       int temp=col;
       col=board.elementAt(j).elementAt(i).c;
         pairs.add(par);
       if (col==temp && col !=90){
         reps++;
       }
       if (reps>=3 && (col!=temp || j==7 || col==90)){
         if (init==false){
         if (chaching.isPlaying()!=true)
             chaching.play();
         }
         score+=reps;
         reps=1;
         int minus=1;
         if (j==7)
           minus=0;
         for (int x=0; x<pairs.size()-minus;x++){
         toUpdate.add(pairs.elementAt(x));}
         pairs.clear();
         pairs.add(par);
       }
       if (col != temp || col==90){
         reps=1;
         pairs.clear();
         pairs.add(par);
       }
       
     }
   
   }
   
   
   
   for (int i=0; i<8; i++){
     Vector<Pair> pairs= new Vector<Pair>();
     col=-1;
     for (int j=0; j<8; j++){
       Pair par= new Pair(i,j);
       int temp=col;
      
         pairs.add(par);
       
       col=board.elementAt(i).elementAt(j).c;
       if (col==temp && col !=90){
         reps++;
       }
        //print(reps);
       if (reps>=3 && (col!=temp || j==7 || col==90)){
         //print(i);
         //println(j);
         score+=reps;
         reps=1;
         if (init==false){
         if (chaching.isPlaying()!=true)
             chaching.play();
         }
         int minus=1;
         if (j==7)
           minus=0;
         for (int x=0; x<pairs.size()-minus;x++){
         toUpdate.add(pairs.elementAt(x));}
         pairs.clear();
         pairs.add(par);
       }
       if (col != temp || col==90){
         reps=1;
         pairs.clear();
         pairs.add(par);
       }
       
     }
   
   }
 }
 
 //after found matching replace with a random color function
 void update(){
   Pair par=new Pair(0,0);
   for (int i=0; i<toUpdate.size(); i++){
     par=toUpdate.get(i);
     int x=(int)par.getKey();
     int y=(int)par.getValue();
     print(x);
     println(y);
     board.elementAt(x).elementAt(y).c=floor((float)Math.random()*6);
   }
   if (init==true){
     if (score==0)
       init=false;
     score=0;
   }
 }
 
 
 
 
 //function called when click on a coin which sets it to check and swaps if needed
 void clickLocation(int x, int y){
   Coin otherClicked=null;
    for (int i=0; i<8;i++){
     Vector<Coin> temp=board.elementAt(i);
     for (int j=0; j<8; j++){
       Coin coin=temp.elementAt(j);
       if (abs(dist(x,y,coin.x,coin.y))>25 && coin.checked==true){
         otherClicked=coin;
       }
     }}
   
   
   for (int i=0; i<8;i++){
     Vector<Coin> temp=board.elementAt(i);
     for (int j=0; j<8; j++){
       
       Coin coin=temp.elementAt(j);
       if (abs(dist(x,y,coin.x,coin.y))<25 && coin.c!=90){
         if (oneChecked==false){
             coin.checked=true;
             oneChecked=true;
         }
         else{
           if (coin.checked==true){
             coin.checked=false;
             oneChecked=false;
           }
           else{
             if (otherClicked != null){
               otherClicked.checked=false;
               coin.checked=false;
               oneChecked=false;
               int temporaryInt=coin.c;
               coin.c=otherClicked.c;
               otherClicked.c=temporaryInt;
               turns++;
           }
           }
         
         }
       }
     }
   }
   
 }
 
 
 
 //initilizes hard mode
 void hardMode(){
 for (int i=0; i<8;i++){
     Vector<Coin> temp=board.elementAt(i);
     for (int j=0; j<8; j++){
       if (floor((float)Math.random()*7)==6){
       temp.elementAt(j).c=90;
     }
     }}
   
 }
 
 
}
