//
//  SignUpViewController.swift
//  SwiftSegmentUserApp
//
//  Created by FJCT on 2016/10/31.
//  Copyright 2019 FUJITSU CLOUD TECHNOLOGIES LIMITED All Rights Reserved.
//

import UIKit
import NCMB

class SignUpViewController: UIViewController {
    // User Name
    @IBOutlet weak var userNameTextField: UITextField!
    // Password
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordTextFieldSecond: UITextField!
    
    // errorLabel
    @IBOutlet weak var errorLabel: UILabel!
    

    // 画面表示時に実行される
    override func viewDidLoad() {
        super.viewDidLoad()
        // Passwordをセキュリティ入力に設定
        self.passwordTextField.isSecureTextEntry = true
        self.passwordTextFieldSecond.isSecureTextEntry = true
        
    }
    
    // SignUpボタン押下時の距離
    @IBAction func signUpBtn(_ sender: UIButton) {
        // キーボードを閉じる
        self.closeKeyboad()
        
        // 入力確認
        if self.userNameTextField.text!.isEmpty || self.passwordTextField.text!.isEmpty || self.passwordTextFieldSecond.text!.isEmpty {
            self.errorLabel.text = "未入力の項目があります"
            // TextFieldを空に
            self.cleanTextField()
            
            return
            
        } else if passwordTextField.text! != passwordTextFieldSecond.text! {
            self.errorLabel.text = "Passwordが一致しません"
            // TextFieldを空に
            self.cleanTextField()
            
            return
            
        }
        
        //NCMBUserのインスタンスを作成
        let user = NCMBUser()
        //ユーザー名を設定
        user.userName = self.userNameTextField.text
        //パスワードを設定
        user.password = self.passwordTextField.text
        
        //会員の登録を行う
        user.signUpInBackground(callback: { result in
            // TextFieldを空に
            DispatchQueue.main.async {
                self.cleanTextField()
            }
            
            switch result {
                case .success:
                    // 新規登録成功時の処理
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "signUp", sender: self)
                    }
                    print("ログインに成功しました:\(String(describing: user.objectId))")
                case let .failure(error):
                    // 新規登録失敗時の処理
                    DispatchQueue.main.async {
                        self.errorLabel.text = "ログインに失敗しました:\((error as NSError).code)"
                    }
                    print("ログインに失敗しました:\((error as NSError).code)")
                }
        })
    }
    
    // 背景タップするとキーボードを隠す
    @IBAction func tapScreen(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        
    }
    
    // TextFieldを空にする
    func cleanTextField(){
        userNameTextField.text = ""
        passwordTextField.text = ""
        passwordTextFieldSecond.text = ""
        
    }
    
    // errorLabelを空にする
    func cleanErrorLabel(){
        errorLabel.text = ""
        
    }
    
    // キーボードを閉じる
    func closeKeyboad(){
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        passwordTextFieldSecond.resignFirstResponder()
        
    }
    
}
