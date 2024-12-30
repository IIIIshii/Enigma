import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
//Pythonのtupleを再現するためのライブラリ
import java.util.AbstractMap; 
import java.util.Map;
import java.util.Arrays;


//ここからグローバル変数とオブジェクトの宣言
//幅と高さの指定
int Width = 3200;  
int Height = 2400; 
//fpsは参考プログラムをもとに設定
int fps=1;

//Enigmaのために作った変数・オブジェクトの宣言
Modulo26 id;
scrambler firstscrambler;
scrambler secondscrambler;
scrambler thirdscrambler;
scrambler reflectscrambler;
Encryptionrotor firstrotor;
Encryptionrotor secondrotor;
Encryptionrotor thirdrotor;
Encryptionrotor reflectrotor;
Modulo26 defaultrotateamount;
Plugboard Plugboard;
String defaultstrsent;
Map.Entry<Character, Character> pair1 = new AbstractMap.SimpleEntry<>('A','A');
Map.Entry<Character, Character> pair2 = new AbstractMap.SimpleEntry<>('A','A');
Map.Entry<Character, Character> pair3 = new AbstractMap.SimpleEntry<>('A','A');

String Key="ABCDFGERTYUI";
int scrambler1[]={18,19,12,9,7,15,8,22,0,6,16,4,1,3,20,11,5,23,24,13,21,14,2,17,10,25};
int scrambler2[]={20,1,24,4,5,12,8,16,3,19,9,18,13,17,11,15,21,23,22,25,0,14,2,7,6,10};
int scrambler3[]={13,22,1,14,18,20,7,24,4,12,2,16,3,23,5,11,0,15,19,21,8,17,10,6,25,9};
int scrambler4[]={25,24,23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0};
int iscrambler1[]={8,12,22,13,11,16,9,4,6,3,24,15,2,19,21,5,10,23,0,1,14,20,7,17,18,25};
int iscrambler2[]={20,1,22,8,3,4,24,23,6,10,25,14,5,12,21,15,7,13,11,9,0,16,18,17,2,19};
int iscrambler3[]={16,2,10,12,8,14,23,6,20,25,22,15,9,0,3,17,11,21,4,18,5,19,1,13,7,24};
scrambler scr[]={firstscrambler,secondscrambler,thirdscrambler};
int keyscr[]={0,0,0};
Encryptionrotor rotorlist[]=new Encryptionrotor[7];
Enigmamain Enigmamain;


JPanel panel;
JTextField boxinput;
inputsomething inputframe;
inputsomething2 inputframe2;
//draw()内の進行を制御する変数situation
int situation=0;
int flag=0;


//入力箱の幅と高さ
int Width_fieldinput = 480;
int Height_fieldinput = 100;


// テキストボックスで入力した文字列
String inputText="ABCAAAABCDEF";
String inputText2="AAAAA";
String outputText1="";//表示する文字列を格納するための変数
String outputText2="";
String outputText3="";
String outputText="";
String temp="";
//ここまで

void settings(){
  size(Width,Height);
}

void setup(){
  //参考プログラムをもとに設定
  background(0);   
  frameRate(fps);  
  


  // 実行画面上のフォントの設定
  PFont font = createFont("MS Gothic", 50, true);
  textFont(font);  
  
  inputframe=new inputsomething();
  inputframe2=new inputsomething2();
  Enigmamain=new Enigmamain();
  //String Sentence=inputText;
  Map.Entry<Character, Character> pair1 = new AbstractMap.SimpleEntry<>('A','A');
Map.Entry<Character, Character> pair2 = new AbstractMap.SimpleEntry<>('A','A');
Map.Entry<Character, Character> pair3 = new AbstractMap.SimpleEntry<>('A','A');
  Plugboard=new Plugboard(pair1,pair2,pair3);
  firstscrambler= new scrambler(scrambler1,iscrambler1);
  secondscrambler=new scrambler(scrambler2,iscrambler2);
  thirdscrambler=new scrambler(scrambler3,iscrambler3);
  reflectscrambler=new scrambler(scrambler4,scrambler4);
  id=new Modulo26(1);
  firstrotor=new Encryptionrotor('A',firstscrambler,id);
  secondrotor=new Encryptionrotor('A',secondscrambler,id);
  thirdrotor=new Encryptionrotor('A',thirdscrambler,id);
  reflectrotor=new Encryptionrotor('A',reflectscrambler,id);
  rotorlist=new Encryptionrotor[7];
  //firstscrambler=new scrambler(scrambler1,iscrambler1);
  
}

void draw(){
  //参考プログラムをもとに設定
  background(0);   // 背景色で塗りつぶす
  fill(255);  // 文字の色
  //inputframe.generate_fieldinput();
  //text(inputText,Width/2, Height/2);
  Enigmamain.progress1();
  if(situation==1){
  Enigmamain.progress2();
  }
  if(situation>1){
    Enigmamain.progress3();
    text(outputText1,Width/10,Height/10);
    text(outputText2,Width/10,Height*2/10);
    text(outputText3,Width/10,Height*3/10);
  }
  if(situation==2){
    Enigmamain.progress4();
  }
  if(situation==3&&flag==0){
    Enigmamain.progress5();
    flag=1;
  }
  if(flag>0){
    Enigmamain.progress6();
    //text("A",Width/10,Height*2/10);
    //text("AAAAAAAAAA",Width/10,Height*4/10);
  }
  
  if(flag>0){
    //Enigmamain.progress7();
    if(flag>1){
    Enigmamain.progress7();
    text(outputText,Width/10,Height*5/10);
    }
  }
  Enigmamain.progress8();
}

class inputsomething extends JFrame implements ActionListener{
  //public void main(String args[]){
    //inputsomething inputframe=new inputsomething();
    //inputframe.setVisible(true);
  //}
  JTextField textfield=new JTextField(30);
  void generate_fieldinput(){
    if(situation==0){
    inputframe.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE); 
    inputframe.setSize(800, 600);
    textfield=new JTextField(30);
    JButton button1=new JButton("OK");
    button1.addActionListener(this);
    JLabel label1=new JLabel();
    label1.setText("Key");
    JPanel panel=new JPanel();
    panel.add(label1);
    panel.add(textfield);
    panel.add(button1);
    inputframe.add(panel);
    inputframe.setVisible(true);
    noLoop();
    }
    
    
  }
  void actionPerformed(ActionEvent e){
     inputText=textfield.getText();
       situation=1;
     inputframe.dispose();
     loop();
  }
}

class inputsomething2 extends JFrame implements ActionListener{
  //public void main(String args[]){
    //inputsomething inputframe=new inputsomething();
    //inputframe.setVisible(true);
  //}
  JTextField textfield2=new JTextField(30);
  void generate_fieldinput(){
    if(situation==3){
    inputframe2.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE); 
    inputframe2.setSize(800, 600);
    textfield2=new JTextField(30);
    JButton button2=new JButton("OK");
    button2.addActionListener(inputframe2);
    JLabel label2=new JLabel();
    label2.setText("Sentence");
    JPanel panel=new JPanel();
    panel.add(label2);
    panel.add(textfield2);
    panel.add(button2);
    inputframe2.add(panel);
    inputframe2.setVisible(true);
    //situation=4;
    noLoop();
    }
    
  }
void actionPerformed(ActionEvent e){
     inputText2=textfield2.getText();
     situation=4;
     inputframe2.dispose();
     
     loop();
  }
}



class Modulo26{
  int value;
  
  Modulo26(int value){
    if(value>25||value<0){
      value=value%26;
    }
    if(value<0){
      value+=26;
    }
    this.value=value;
  }
  void getvalue(){
    System.out.println(this.value);
  }
  Modulo26 add(Modulo26 other){
    int sum=this.value+other.value;
    sum=sum%26;
    return new Modulo26(sum);
  }
  Modulo26 sub(Modulo26 other){
    int gap=this.value-other.value;
    gap=gap%26;
    return new Modulo26(gap);
  }
  Modulo26 mul(int num){
    int pro=this.value*num;
    pro=pro%26;
    return new Modulo26(pro);
  }
  private int val(){
    return this.value;
  }
  
}

class scrambler{
  int func[];
  int ifunc[];
  
  scrambler(int func[],int ifunc[]){
    this.func=func;
    this.ifunc=ifunc;
  }
  //元のコードではfuncを出力していたが、ここではfuncを返すメソッド
  private int[] show(){
    return this.func;
  }
}

class Encryptionrotor{
  char offset;
  scrambler scrambler;
  Modulo26 rotateamount;
  
  Encryptionrotor(char offset, scrambler scrambler, Modulo26 rotateamount){
   this.offset=offset;
   this.scrambler=scrambler;
   this.rotateamount=rotateamount;
  }
  
  private void rotate(){
  }
}

class Plugboard{
  Map.Entry<Character, Character> pair1 = new AbstractMap.SimpleEntry<>('A','A');
  Map.Entry<Character, Character> pair2 = new AbstractMap.SimpleEntry<>('A','A');
  Map.Entry<Character, Character> pair3 = new AbstractMap.SimpleEntry<>('A','A');
  
  Plugboard(Map.Entry<Character, Character> pair1, Map.Entry<Character, Character>pair2, Map.Entry<Character, Character>pair3){
    this.pair1=pair1;
    this.pair2=pair2;
    this.pair3=pair3;
  }
   String Exchange(String strsent){
    StringBuilder sb = new StringBuilder(strsent);
    
    for(int i=0;i<strsent.length();i++){
      if(strsent.charAt(i)==pair1.getKey()){
        sb.setCharAt(i, pair1.getValue());
        strsent = sb.toString();
      }
      else if(strsent.charAt(i)==pair1.getValue()){
        sb.setCharAt(i, pair1.getKey());
        strsent = sb.toString();
      }
      if(strsent.charAt(i)==pair2.getKey()){
        sb.setCharAt(i, pair2.getValue());
        strsent = sb.toString();
      }
      else if(strsent.charAt(i)==pair2.getValue()){
        sb.setCharAt(i, pair2.getKey());
        strsent = sb.toString();
      }
      if(strsent.charAt(i)==pair3.getKey()){
        sb.setCharAt(i, pair3.getValue());
        strsent = sb.toString();
      }
      else if(strsent.charAt(i)==pair3.getValue()){
        sb.setCharAt(i, pair3.getKey());
        strsent = sb.toString();
      }
    }
    return strsent;
  }
}

class Enigmamain{
  PApplet parent;
  void progress1(){
    //Keyの受け取り
    //situation=0;
    inputframe.generate_fieldinput();
  }
  void progress2(){  
    Key=inputText;
    //Plugboardの生成
    pair1= new AbstractMap.SimpleEntry<>(Key.charAt(6),Key.charAt(7));
    pair2= new AbstractMap.SimpleEntry<>(Key.charAt(8),Key.charAt(9));
    pair3= new AbstractMap.SimpleEntry<>(Key.charAt(10),Key.charAt(11));
    Plugboard=new Plugboard(pair1,pair2,pair3);
    //
    firstscrambler=new scrambler(scrambler1,iscrambler1);
    secondscrambler=new scrambler(scrambler2,iscrambler2);
    thirdscrambler=new scrambler(scrambler3,iscrambler3);
    reflectscrambler=new scrambler(scrambler4,scrambler4);
    situation=2;
  }
  void progress3(){
    outputText1="First scrambler is"+Arrays.toString(firstscrambler.show());
    outputText2="Second scrambler is"+Arrays.toString(secondscrambler.show());
    outputText3="Third scrambler is" +Arrays.toString(thirdscrambler.show());
    //parent.text(Arrays.toString(firstscrambler.show()),Width/2, Height/2);
    situation=3;
  }
  void progress4(){
     scrambler scr[]={firstscrambler,secondscrambler,thirdscrambler};
     //Encryptionrotor rotorlist[]={};
     for(int i=0;i<3;i++){
       if(Key.charAt(i)=='A'){
         keyscr[i]=0;
       }
       else if(Key.charAt(i)=='B'){
         keyscr[i]=1;
       }
       else{
         keyscr[i]=2;
       }
     }
     Modulo26 tempa=new Modulo26((int)Key.charAt(3)-(int)'A');
     Modulo26 tempb=new Modulo26((int)Key.charAt(4)-(int)'A');
     Modulo26 tempc=new Modulo26((int)Key.charAt(5)-(int)'A');
     Modulo26 tempd=new Modulo26(0);
     firstrotor=new Encryptionrotor(Key.charAt(3),scr[keyscr[0]],tempa);
     secondrotor=new Encryptionrotor(Key.charAt(4),scr[keyscr[1]],tempb);
     thirdrotor=new Encryptionrotor(Key.charAt(5),scr[keyscr[2]],tempc);
     reflectrotor= new Encryptionrotor('A',reflectscrambler,tempd);
     //rotorlist={firstrotor,secondrotor,thirdrotor,reflectrotor,thirdrotor,secondrotor,firstrotor};
     rotorlist[0]=firstrotor;
     rotorlist[1]=secondrotor;
     rotorlist[2]=thirdrotor;
     rotorlist[3]=reflectrotor;
     rotorlist[4]=thirdrotor;
     rotorlist[5]=secondrotor;
     rotorlist[6]=firstrotor;
     
     situation=3;
  }
  void progress5(){
    inputframe2.generate_fieldinput();
  }
  void progress6(){
    Encryptionrotor rotorlist[]={firstrotor,secondrotor,thirdrotor,reflectrotor,thirdrotor,secondrotor,firstrotor};
    String sentence=inputText2;
    if(inputText2!="AAAAA"){
      flag=2;
    }
    sentence=Plugboard.Exchange(sentence);
    int size=sentence.length();
    Modulo26 ans[]=new Modulo26[size];
    for(int i=0;i<size;i++){
      Modulo26 ansi=new Modulo26((int)sentence.charAt(i)-(int)'A');
      Modulo26 id=new Modulo26(1);
      firstrotor.rotateamount=firstrotor.rotateamount.add(id);
      if(i%26==25){
        secondrotor.rotateamount=secondrotor.rotateamount.add(id);
      }
      if(i%676==675){
        thirdrotor.rotateamount=thirdrotor.rotateamount.add(id);
      }
      for(int r=0;r<7;r++){
        ansi=ansi.sub(rotorlist[r].rotateamount);
        if(r<4){
          ansi=new Modulo26(rotorlist[r].scrambler.func[ansi.val()]);
          ansi=ansi.add(rotorlist[r].rotateamount);
        }
        else{
          ansi=new Modulo26(rotorlist[r].scrambler.ifunc[ansi.val()]);
          ansi=ansi.add(rotorlist[r].rotateamount);
        }
        
      }
      ans[i]=ansi;
    
  }
  if(flag==2){
  for(int a=0;a<size;a++){
    outputText=outputText+(char)(ans[a].val()+(int)'A');
  }
  }
  situation=5;
  }
  void progress7(){
    outputText=Plugboard.Exchange(outputText);
    
  }
  void progress8(){
    if(flag==2){
      noLoop();
    }
  }
}
