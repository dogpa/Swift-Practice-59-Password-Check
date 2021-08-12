//
//  ViewController.swift
//  Swift Practice # 59 Password Check
//
//  Created by CHEN PEIHAO on 2021/8/12.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    
    //密碼規則的label
    @IBOutlet weak var passwordRuleLabel: UILabel!
    
    //帳號的TextField
    @IBOutlet weak var accountTextField: UITextField!
    
    //兩個密碼的TextField
    @IBOutlet weak var firstPassword: UITextField!
    @IBOutlet weak var secondPassword: UITextField!
    
    
    //建立提醒的標題的Array
    let alertTitle = ["設定失敗","設定成功"]
    
    //建立提醒視窗的文字Array
    let wordOfWarringArray = ["密碼兩次輸入不一致，手有問題？",//0
                              "密碼需超過十個字元，不會算？",
                              "密碼英文小寫各一，不會英文？",
                              "沒有數字0-9，老師沒教數學？",//3
                              "缺少特殊符號，來點亂碼好嗎",
                              "密碼不可包含帳號，是想被盜",
                              "不要用低級密碼，是想被盜？",//6
                              "帳號請大於六位數字元好嗎",
                              "恭喜完成註冊"
    ]

    //設定提醒的返回動作按鈕的提醒語
    let alertActionTitle = ["重設密碼","重設帳號","下一步"]
    
    //Apple官方常見簡單密碼Array
    let mostCommonPasswords = [
        "123456",
        "password",
        "12345678",
        "qwerty",
        "12345",
        "123456789",
        "letmein",
        "1234567",
        "football",
        "iloveyou"
    ]
    
    //Apple官方的數字與特殊符號字串
    let digits = "0123456789"
    let punctuation = "!@#$%^&*(),.<>;'`~[]{}\\|/?_-+= "
    
    //建立五個變數個字代表數字、標點符號、字母、大小、小寫
    //給後續for迴圈檢查數字使用
    var numbersOfDigits = 0 //數字
    var numbersOfPunctuation = 0 //標點符號
    var numbersOfRegularLetter = 0 //字母
    var numbersOfUppercase = 0 //大寫
    var numbersOfLowercase = 0 //小寫
    
    
    //任意鍵換頁
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        }
        @objc func dismissKeyboard() {
        view.endEditing(true)
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //收鍵盤
        self.hideKeyboardWhenTappedAround()
        
        //透過程式碼建立label的換行規則
        passwordRuleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        passwordRuleLabel.numberOfLines = 0
        passwordRuleLabel.text = "密碼規則要求\n1.至少十位數\n2.至少一個英文大寫與小寫\n3.至少一個數字\n4.至少一個符號\n5.不可包含使用者名稱"
 
    }

    //建立function遇到密碼有誤狀況跳出不同提示內容的警告
    func SHowWarning (index0:Int, index1:Int, index2:Int) {
    let alertController = UIAlertController(title:
        alertTitle[index0], message: wordOfWarringArray[index1], preferredStyle: .alert)
                let okAction = UIAlertAction(title: alertActionTitle[index2], style: .default)
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
    }
    
    
    
    @IBAction func passwordCheck(_ sender: UIButton) {
        //檢查帳號是否有輸入值
        if accountTextField.text!.count < 6 {
            SHowWarning(index0: 0, index1: 7, index2: 1)
        }
        
        //列印密碼在xcode確認狀況
        print(firstPassword.text!)
        print(secondPassword.text!)
        
        //檢查兩次密碼輸入值是否一樣
        if firstPassword.text != secondPassword.text {
            SHowWarning(index0: 0, index1: 0, index2: 0)
        }
        
            //若是密碼輸入值兩個都一樣，檢查是否符合所有條件
        if firstPassword.text == secondPassword.text {
            
            //如果輸入密碼與常見密碼一致
            for i in 0...mostCommonPasswords.count-1 {
                if secondPassword.text?.contains(mostCommonPasswords[i]) == true {
                    SHowWarning(index0: 0, index1: 6, index2: 0)
                }
            }

                //透過迴圈檢查是否有包含數字、標點符號、字母、大小、小寫
                //有的話再各自變數內 +1
            for password in secondPassword.text! {
                if digits.contains(password){
                    numbersOfDigits += 1 //密碼數字的值
                }else if punctuation.contains(password){
                    numbersOfPunctuation += 1 //密碼標點符號的值
                }else{
                    numbersOfRegularLetter += 1 //密碼字母的值
                }
                
                if password.isUppercase {
                    numbersOfUppercase += 1 //密碼大寫數的值
                }else{
                    numbersOfLowercase += 1 //密碼小寫數的值
                }
            }
            
            
                //所有檢查
                //密碼輸入值小於十位元
            if secondPassword.text!.count < 10 {
                SHowWarning(index0: 0, index1: 1, index2: 0)
                //密碼包含帳號字元
            }else if secondPassword.text!.contains(accountTextField.text!){
                SHowWarning(index0: 0, index1: 5, index2: 0)
                //密碼沒有數值的值
            }else if numbersOfDigits == 0 {
                SHowWarning(index0: 0, index1: 3, index2: 0)
                //缺標點符號
            }else if numbersOfPunctuation == 0 {
                SHowWarning(index0: 0, index1: 4, index2: 0)
                //缺字母或大小寫缺一
            }else if numbersOfRegularLetter == 0 || numbersOfUppercase == 0 || numbersOfLowercase == 0 {
                SHowWarning(index0: 0, index1: 2, index2: 0)
            }else{
                //設定成功
                SHowWarning(index0: 1, index1: 8, index2: 2)
            }
            
        }

    }
    
    
    
    
    @IBAction func accountReturn(_ sender: Any) {
    }
    @IBAction func firstPasswordReturn(_ sender: Any) {
    }
    @IBAction func secondPasswordReturn(_ sender: Any) {
    }
    

    
}
