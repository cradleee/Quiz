//
//  QuizViewController.swift
//  Quiz
//
//  Created by kamano yurika on 2018/03/16.
//  Copyright © 2018年 釜野由里佳. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    //問題文を格納する配列
    var quizArray = [Any]()
    
    //正解数
    var correctAnswer: Int = 0
    
    //クイズを表示するTextView
    @IBOutlet var quizTextView: UITextView!
    
    //選択肢のボタン
    @IBOutlet var choiceButton1: UIButton!
    @IBOutlet var choiceButton2: UIButton!
    @IBOutlet var choiceButton3: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //一時的にクイズを格納しておく配列
        var tmpArray = [Any]()
        
        //tmpArrayに問題文、３つの選択肢、答えの番号が入った配列を追加していく
        tmpArray.append(["The Beatlesの前身となるバンドの名前は？","Queen","The Quarry Men"," The Beens",2])
        tmpArray.append(["The Beatlesのベースは？","ポール・スチュアート","ポール・マッカートニー","ポール&ジョー",2])
        tmpArray.append(["レコードデビューはいつ？","1960年","1961年","1962年",3])
        tmpArray.append(["The Beatlesのギターは？","リンゴ・スター","ジョージ・レノン","ジョージ・ハリスン",3])
        tmpArray.append(["リーダーはだれ？","ポール・マッカートニー","ジョン・レノン","リンゴ・スター",2])
        tmpArray.append(["「Here comes The Sun」を作曲したのは？","ジョージ・ハリスン","ポール・マッカートニー","ジョン・レノン",1])
        
        //問題をシャッフルしてquizArrayに格納する
        while (tmpArray.count > 0) {
            let index = Int(arc4random()) % tmpArray.count
            quizArray.append(tmpArray[index])
            tmpArray.remove(at: index)
        }
        
        choiceQuiz()

    }
    
    func choiceQuiz(){
        
        //一時的にクイズを取り出す配列
        let tmpArray = quizArray[0] as! [Any]
        
        //問題文のテキストを表示
        quizTextView.text = tmpArray[0] as! String
        
        //選択肢のボタンにそれぞれ選択肢のテキストをセット
        choiceButton1.setTitle(tmpArray[1] as? String, for: .normal)
        choiceButton2.setTitle(tmpArray[2] as? String, for: .normal)
        choiceButton3.setTitle(tmpArray[3] as? String, for: .normal)
        
    }
    
    @IBAction func choiceAnswer(sender: UIButton) {
        //引数のsender.tagに格納されているTagの値を使って処理を区別する
        
    let tmpArray = quizArray[0] as![Any]
    
        if tmpArray[4] as! Int == sender.tag {
            
            //正解を増やす
            correctAnswer = correctAnswer + 1
        }
        
        //解いた問題をquizArrayから取り除く
        quizArray.remove(at: 0)
        
        //解いた問題の合計があらかじめ設定していた問題数に達したら結果画面へ
        if quizArray.count == 0 {
            performSegueToResult()
        } else {
            choiceQuiz()
        }
    }
    func performSegueToResult() {
        performSegue(withIdentifier: "toResultView", sender: nil)
    }
    //セグエを準備(prepare)するときに呼ばれるメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResultView" {
            let resultViewController = segue.destination as! ResultViewController
            resultViewController.correctAnswer = self.correctAnswer
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
