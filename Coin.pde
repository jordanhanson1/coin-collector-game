
//coin class
class Coin{
  
  //attributes
  int x;
  int y;
  int c;
  boolean checked;
  
  //draw function
  void drawC(){
    drawCoin(x,y,c, checked);
  }
  
  
  //coin constructor function
  Coin(int x1,int y1, int c1){
    x=x1;
    y=y1;
    c=c1;
    checked=false;
  }
  
}
