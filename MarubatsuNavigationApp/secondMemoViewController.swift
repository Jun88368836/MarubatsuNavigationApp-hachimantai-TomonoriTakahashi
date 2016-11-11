//
//  secondMemoViewController.swift
//  MarubatsuNavigationApp
//
//  Created by 高橋知憲 on 2016/11/11.
//  Copyright © 2016年 高橋知憲. All rights reserved.
//

import UIKit

class secondMemoViewController: UIViewController {
    
    @IBOutlet weak var questionInputBox: UITextField!
    @IBOutlet weak var answerControl: UISegmentedControl!
    
    // アラートを表示させるための関数(引数として表示させたいmessageをString型で受け取る)
    func showAlert(message: String) {
        // アラートを表示させるための準備 (alertControllerをオブジェクト化)
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        // アラートを閉じるための準備
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        
        // 作成したアラートオブジェクトにcloseイベントを追加
        alert.addAction(close)
        // 作成したアラートを表示
        present(alert, animated: true, completion: nil)
    }

    
    

    // createボタンが押されたときの処理
    
    @IBAction func tappedCreateButton(_ sender: Any) {
        var answer: Bool = true
        
        if answerControl.selectedSegmentIndex == 0 {
            // choose false
            answer = false
        }
        else {
            // choose true
            answer = true
        }
        
        let questionText:String = questionInputBox.text!
        
        //問題文が空白のままcreateされないように場合分け
        if (questionText != "" ){
            
            //空白でなければ保存
            let ud = UserDefaults.standard
            var questions: [[String: Any]] = ud.object(forKey: "questions") as! [[String : Any]]
            
            questions.append( [
                "question": questionText,
                "answer": answer
                ])
            
            ud.setValue(questions, forKey: "questions")
            print(ud)
            
            //次の画面に遷移
            //遷移したいViewControllerがあるstoryboardを指定
            let storyboard: UIStoryboard = self.storyboard!
            
            //遷移先のViewControllerを指定
            let secondMemoView = storyboard.instantiateViewController(withIdentifier: "secondMemo") as! secondMemoViewController
            
            //遷移
            self.present(secondMemoView, animated: true, completion: nil)
            
        }else{
            //空白のときはアラートを表示
            showAlert(message:"問題文を入力してください")
        }
    }
    
    // deleteボタンが押されたときの処理
    @IBAction func tappedDeleteAllQuestionButton(_ sender: UIButton) {
        let ud = UserDefaults.standard
        
        // 保存されている値を削除
        ud.removeObject(forKey: "questions")
        
        // 空のarrayをset(for エラー回避)
        ud.setValue([], forKey: "questions")
        
        //遷移したいViewControllerがあるstoryboardを指定
        let storyboard: UIStoryboard = self.storyboard!
        
        //遷移先のViewControllerを指定
        let View = storyboard.instantiateViewController(withIdentifier: "View") as! ViewController
        
        //遷移
        self.present(View, animated: true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
