int scene;  //0ならスタートメニュー、1なら日替わり鍵入力、2なら通信鍵入力、3なら本文入力、4なら結果出力
int inputManager;  //文字入力の管理用；各シーンで0スタート
  //綺麗じゃないから後でかえるかも
String dailykey1,dailykey2, dailykey3;  //1にローターの順番、2に回転初期位置、3にプラグボードの設定
String submitkey;  //通信鍵
String keyRes;  //暗号化された通信鍵（送信文の前半）
String message;  //平文
String result;  //暗号化された文（送信文の後半）
String inputText;  //入力受け取り用
  //浅いコピー怖くてまだ使ってない


void setup() {
  
  //初期設定
  size(960, 720);
  background(0);
  scene = 0;
  inputManager = 0;
  dailykey1= "";
  dailykey2= "";
  dailykey3= "";
  submitkey = "";
  message = "";
  result = "";
  inputText = "";
  
  // 実行画面上のフォントの設定
  PFont font = createFont("MS Gothic", 25, true);  // createFont(設定するフォント, フォントサイズ, 文字を滑らかにするか否か)
  textFont(font);  // この処理により, text() で表示する文字を全て設定したフォントにする
  
  //エニグマまわり
  enigmaMain = new Enigmamain();
  //スクランブラーの生成
  enigmaMain.generateScrambler();
  
  id = new Modulo26(1);
}

void draw() {
  //更新
  background(0);
  fill(255);
  textAlign(CENTER, CENTER);
  
  //スタート画面
  if(scene == 0) {
    text("エニグマへようこそ！", 480, 180);
    text("スペースキーを押してください", 480, 240);
    text("@gunjou, @iiiishii", 480, 480);
  } else 
  
  //日替わり鍵入力画面
  if(scene == 1) {
    text("ローターの状態：",480, 30);
    text(outputText1, 480, 60);
    text(outputText2, 480, 90);
    text(outputText3, 480, 120);
    text("日替わり鍵を入力してください",480, 150 );
    
    //入力状態ごとに分岐
      if(inputManager == 0) {
        text("1,2,3の3枚のローターの順番を入力してください（例：132）",480, 240 );
        text("入力：" + dailykey1, 480, 270); 
      } else if(inputManager == 1) {
        text("ローターの順番：" + dailykey1,480, 240 );
        text("それぞれのローターの回転初期位置を入力してください（例：GSU）",480, 270 );
        text("入力：" + dailykey2, 480, 300); 
      } else if(inputManager == 2) {
        text("ローターの順番：" + dailykey1,480, 240 );
        text("ローターの回転初期位置：" + dailykey2,480, 270 );
        text("プラグボードの繋ぎ方を入力してください（例：QHIOSK）",480, 300 );
        text("入力：" + dailykey3, 480, 330); 
      } else if(inputManager == 3) {
        text("ローターの順番：" + dailykey1,480, 240 );
        text("ローターの回転初期位置：" + dailykey2,480, 270 );
        text("プラグボードの繋ぎ方：" + dailykey3,480, 300 );
        text("設定ができました！スペースキーを押してください", 480, 330);
      }
      
  //通信鍵入力
  } else if(scene == 2) {
    text("通信鍵を入力してください！", 480, 60);
    text("通信鍵：" + submitkey, 480, 90);
  
  //本文入力画面
  } else if(scene == 3) {
    text("暗号化する文を入力してください！", 480, 60);
    text("入力された文章：", 480, 90);
    text(message, 480, 120);
      //折り返しに対応する必要がありそう?
    
    text("暗号化の設定", 480, 330);
    text("ローターの順番：" + dailykey1,480, 360 );
    text("ローターの回転初期位置（日替わり鍵）：" + dailykey2,480, 390 );
    text("ローターの回転初期位置（通信鍵）：" + submitkey,480, 420 );
    text("暗号化された通信鍵：" + keyRes,480, 450 );
    text("プラグボードの繋ぎ方：" + dailykey3,480, 480 );
  
  //結果出力画面
  } else if(scene == 4) {
    text("暗号化しました", 480, 60);
    text("もとの文", 480, 90);
    text(message, 480, 120);
    text("暗号文", 480, 210);
    text(result, 480, 240);
    text("暗号化の設定", 480, 330);
    text("ローターの順番：" + dailykey1,480, 360 );
    text("ローターの回転初期位置（日替わり鍵）：" + dailykey2,480, 390 );
    text("プラグボードの繋ぎ方：" + dailykey3,480, 420 );
  }
}

void keyPressed()
{
  //関数つくるべき過ぎる
  if(scene == 0) {
    if(key ==  ' ') {
      //シーン遷移
      scene = 1;
      inputManager = 0;
      inputText = "";
    }
  } else 
  
  //日替わり鍵入力画面
  //本文の入力文字数に制限を導入する、あるいは表示に折り返しを実装する必要がある
  //大文字と小文字とで数字が違うかも；あとで設定する
  if(scene == 1) {
      if(inputManager == 0) {
        if(keyCode == BACKSPACE) {
          if(dailykey1.length() > 0) {
            dailykey1 = dailykey1.substring(0, dailykey1.length() - 1);
          }
        } else if(keyCode == RETURN || keyCode == ENTER) {
          inputManager = 1;
        } else if((key == '1' || key == '2' || key == '3') && (dailykey1.length() < 3)) {
          dailykey1 += key;
        }
        
      } else if(inputManager == 1) {
        if(keyCode == BACKSPACE) {
          if(dailykey2.length() > 0) {
            dailykey2 = dailykey2.substring(0, dailykey2.length() - 1);
          }
        } else if(keyCode == RETURN || keyCode == ENTER) {
          enigmaMain.setScrambler(dailykey1, dailykey2);
          inputManager = 2;
        } else if(keyCode == SHIFT || keyCode == TAB || keyCode == DELETE || keyCode == ALT || key == ' '   /*思いついたやつ書いていく*/) {
        }else if(dailykey2.length() < 3){ 
          char k = key;  //大文字に変換するために挟んでる
          dailykey2 += Character.toUpperCase(k);
        }
      } else if(inputManager == 2) {
        if(keyCode == BACKSPACE) {
          if(dailykey3.length() > 0) {
            dailykey3 = dailykey3.substring(0, dailykey3.length() - 1);
          }
        } else if(keyCode == RETURN || keyCode == ENTER) {
          enigmaMain.generatePlugboard(dailykey3);
          inputManager = 3;
        } else if(keyCode == SHIFT || keyCode == TAB || keyCode == DELETE || keyCode == ALT || key == ' '   /*思いついたやつ書いていく*/) {
        }else if(dailykey3.length() < 6){ 
          char k = key;
          dailykey3 += Character.toUpperCase(k);
        }
      } else if(inputManager == 3) {
        if(key ==  ' ') {
          //シーン遷移
          scene = 2;
          inputManager = 0;
        }
      }
      
  //通信鍵入力画面
  } else if(scene == 2) {
    if(keyCode == BACKSPACE) {
      if(submitkey.length() > 0) {
        submitkey = submitkey.substring(0, submitkey.length() - 1);
      }
    } else if(keyCode == RETURN || keyCode == ENTER) {
      //通信鍵の暗号化処理を呼び出す
      enigmaMain.Encrypt(submitkey, true);
      //本文用に再設定
      enigmaMain.setScrambler(dailykey1, submitkey);
      scene = 3;
    } else if(keyCode == SHIFT || keyCode == TAB || keyCode == DELETE || keyCode == ALT || key == ' '   /*思いついたやつ書いていく*/) {
    }else if(submitkey.length() < 3){ 
      char k = key;
      submitkey += Character.toUpperCase(k);
    }
  
  //本文入力画面
  } else if(scene == 3) {
    if(keyCode == BACKSPACE) {
      if(message.length() > 0) {
        message = message.substring(0, message.length() - 1);
      }
    } else if(keyCode == RETURN || keyCode == ENTER) {
      enigmaMain.Encrypt(message, false);
      scene = 4;
    } else if(keyCode == SHIFT || keyCode == TAB || keyCode == DELETE || keyCode == ALT || key == ' '/*思いついたやつ書いていく*/) {
    } else { 
      char k = key;
      message += Character.toUpperCase(k);
    }
  
  //結果出力画面
  } else if(scene == 4) {
    
  }
}
