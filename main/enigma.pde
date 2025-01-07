
//Pythonのtupleを再現するためのライブラリ
import java.util.AbstractMap; 
import java.util.Map;
import java.util.Arrays;


//宣言
//スクランブラー（ローターの内部配線を持つ）
scrambler scrambler1;
scrambler scrambler2;
scrambler scrambler3;
scrambler reflector;
//ローターの順番どおりに入ったリスト
//ここでは仮に123の順で入れてある
scrambler scr[] = new scrambler[]{scrambler1, scrambler2, scrambler3};



//スクランブラーの中身
int s1func[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25};
int s1ifunc[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25};
int s2func[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25};
int s2ifunc[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25};
int s3func[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25};
int s3ifunc[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25};
int reffunc[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25};


//ローター
//既に並べ替えられたものが入っている
Encryptionrotor firstrotor;
Encryptionrotor secondrotor;
Encryptionrotor thirdrotor;
Encryptionrotor reflectrotor;
//ローターのリスト
Encryptionrotor rotorlist[] = new Encryptionrotor[]{firstrotor, secondrotor, thirdrotor, reflectrotor, thirdrotor, secondrotor, firstrotor};

//プラグボード
Plugboard plugboard;

//メイン関数
Enigmamain enigmaMain;


Modulo26 id;  //Modulo26型の1を入れる
Modulo26 defaultrotateamount;
String defaultstrsent;
Map.Entry<Character, Character> pair1 = new AbstractMap.SimpleEntry<>('A','A');
Map.Entry<Character, Character> pair2 = new AbstractMap.SimpleEntry<>('A','A');
Map.Entry<Character, Character> pair3 = new AbstractMap.SimpleEntry<>('A','A');

int keyscr[]={0,0,0};


String outputText1="";//表示する文字列を格納するための変数
String outputText2="";
String outputText3="";


//26の剰余項のクラス
class Modulo26{
  int value;
  
  //コンストラクタ
  Modulo26(int v){
    if(v>25||v<0){
      v=v%26;
    }
    if(v<0){
      v+=26;
    }
    this.value=v;
  }
  
  private int val() {
    return this.value;
  }
  
  //コンソールに表示
  void getvalue(){
    println(this.value);
  }
  
  //可算、減算、乗算
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
  
}


//スクランブラーのクラス
class scrambler{
  //順方向、逆方向
  int func[];
  int ifunc[];
  
  //コンストラクタ
  scrambler(int cfunc[],int cifunc[]){
    this.func=cfunc;
    this.ifunc=cifunc;
  }
  
  //元のコードではfuncを出力していたが、ここではfuncを返すメソッド
  private int[] show(){
    return this.func;
  }
}


//ローターのクラス
class Encryptionrotor{
  String offset;  //回転初期位置
  scrambler scrambler;  //スクランブラー
  Modulo26 rotateamount;  //回転量
  
  //コンストラクタ
  Encryptionrotor(String coffset, scrambler cscrambler, Modulo26 crotateamount){
   this.offset=coffset;
   this.scrambler=cscrambler;
   this.rotateamount=crotateamount;
  }
  
  private void rotate(){
  }
}


//プラグボードのクラス
class Plugboard{
  //タプル；交換する文字のセット
  Map.Entry<Character, Character> pair1;
  Map.Entry<Character, Character> pair2;
  Map.Entry<Character, Character> pair3;
  
  //コンストラクタ
  Plugboard(Map.Entry<Character, Character> cpair1, Map.Entry<Character, Character>cpair2, Map.Entry<Character, Character>cpair3){
    this.pair1=cpair1;
    this.pair2=cpair2;
    this.pair3=cpair3;
  }
  
  //文字列内のキーを交換
  private String Exchange(String strsent){
    //Stringはイミュータブル；StringBuilderはミュータブル
    //strsentをいったんsbに移して文字を交換してからstrsentに戻す
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
      if(strsent.charAt(i)==pair2.getValue()){
        sb.setCharAt(i, pair2.getKey());
        strsent = sb.toString();
      }
      if(strsent.charAt(i)==pair3.getKey()){
        sb.setCharAt(i, pair3.getValue());
        strsent = sb.toString();
      }
      if(strsent.charAt(i)==pair3.getValue()){
        sb.setCharAt(i, pair3.getKey());
        strsent = sb.toString();
      }
    }
    return strsent;
  }
}

//メイン関数
class Enigmamain{
  //スクランブラーの生成
  void generateScrambler() {
    for(int i = 0; i < 26; i++) {
      s1func[i] = (int)random(0,26);
      s2func[i] = (int)random(0,26);
      s3func[i] = (int)random(0,26);
      reffunc[25 - i] = i;
    }
    for(int i = 0; i < 26; i++) {
      s1ifunc[s1func[i]] = i;
      s2ifunc[s2func[i]] = i;
      s3ifunc[s3func[i]] = i;
    }
    scrambler1 = new scrambler(s1func, s1ifunc);
    scrambler2 = new scrambler(s2func, s2ifunc);
    scrambler3 = new scrambler(s3func, s3ifunc);
    reflector = new scrambler(reffunc, reffunc);
    this.textsetting();
  }
  
  //プラグボードの生成
  void generatePlugboard(String dailykey) {
    pair1= new AbstractMap.SimpleEntry<>(dailykey.charAt(0),dailykey.charAt(1));
    pair2= new AbstractMap.SimpleEntry<>(dailykey.charAt(2),dailykey.charAt(3));
    pair3= new AbstractMap.SimpleEntry<>(dailykey.charAt(4),dailykey.charAt(5));
    plugboard=new Plugboard(pair1,pair2,pair3);
  }
  
  //PApplet parent;
  
  
  //スクランブラーの設定
  void setScrambler(String key1, String key2) {
    /*println(key1);
    println("123".getClass().getSimpleName());
    println(key2);
    println(scrambler1);*/
    if(key1.equals("123")) {
      scr[0] = scrambler1;
      scr[1] = scrambler2;
      scr[2] = scrambler3;
      println("hit");
      
    } else if(key1.equals("132")) {
      scr[0] = scrambler1;
      scr[1] = scrambler3;
      scr[2] = scrambler2;
      
    } else if(key1.equals("213")) {
      scr[0] = scrambler2;
      scr[1] = scrambler1;
      scr[2] = scrambler3;
      
    } else if(key1.equals("231")) {
      scr[0] = scrambler2;
      scr[1] = scrambler3;
      scr[2] = scrambler1;
      
    } else if(key1.equals("312")) {
      scr[0] = scrambler3;
      scr[1] = scrambler1;
      scr[2] = scrambler2;
      
    } else if(key1.equals("321")) {
      scr[0] = scrambler3;
      scr[1] = scrambler2;
      scr[2] = scrambler1;
      
    } else {
      println("err");
      scr[0] = scrambler1;
      scr[1] = scrambler2;
      scr[2] = scrambler3;
      
    }
    //println(scr[0]);
    //ローターをセット
    firstrotor = new Encryptionrotor(String.valueOf(key2.charAt(0)), scr[0], new Modulo26((int)key2.charAt(0) - (int)'A'));
    secondrotor = new Encryptionrotor(String.valueOf(key2.charAt(1)), scr[1], new Modulo26((int)key2.charAt(1) - (int)'A'));
    thirdrotor = new Encryptionrotor(String.valueOf(key2.charAt(2)), scr[2], new Modulo26((int)key2.charAt(2) - (int)'A'));
    reflectrotor = new Encryptionrotor("A", reflector, new Modulo26(0));
  }
  
  //ローターの表示文章生成
  void textsetting(){
    outputText1="First scrambler is"+Arrays.toString(scrambler1.show());
    outputText2="Second scrambler is"+Arrays.toString(scrambler2.show());
    outputText3="Third scrambler is" +Arrays.toString(scrambler3.show());  
  }
  
  void Encrypt(String mes, boolean repeat){
    //暗号化
    StringBuilder sentence = new StringBuilder(mes);
    Encryptionrotor rotorlist[] = new Encryptionrotor[]{firstrotor, secondrotor, thirdrotor, reflectrotor, thirdrotor, secondrotor, firstrotor};
    
    if(repeat) {
      //繰り返しのため
      for(int i = 0; i < mes.length(); i++){
        sentence.append(mes.charAt(i));
      } 
    }
    
    for(int i = 0; i < sentence.length(); i++) {
      //文字を数値化
      Modulo26 a = new Modulo26((int)sentence.charAt(i) - (int)'A');
      
      //ローターを回転
      firstrotor.rotateamount = firstrotor.rotateamount.add(id);
      if(i % 26 == 25) secondrotor.rotateamount = secondrotor.rotateamount.add(id);
      if(i % 676 == 675) thirdrotor.rotateamount = thirdrotor.rotateamount.add(id);
      
      //スクランブラーに通す
      //スクランブラー自体は回っていない
      //回転量の文だけ元に戻している
     for(int j = 0; j < 7; j++) {
       a = a.sub(rotorlist[j].rotateamount);
       if(j < 4) {
         a = new Modulo26(rotorlist[j].scrambler.func[a.val()]);
         a = a.add(rotorlist[j].rotateamount);
       } else {
         a = new Modulo26(rotorlist[j].scrambler.ifunc[a.val()]);
         a = a.add(rotorlist[j].rotateamount);
       }
     }
      
      //数値を文字に戻す
      sentence.setCharAt(i, (char)(a.val() + (int)'A'));
      
      //プラグボードに通す
    }
    
    
    if(repeat) {
      keyRes = plugboard.Exchange(sentence.toString()); 
    } else {
      result = plugboard.Exchange(sentence.toString()); 
    }
  }
  
}
