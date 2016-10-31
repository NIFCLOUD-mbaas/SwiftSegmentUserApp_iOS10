//
//  LogoutViewController.swift
//  SwiftLoginApp
//
//  Created by Natsumo Ikeda on 2016/05/26.
//  Copyright © 2016年 NIFTY Corporation. All rights reserved.
//

import UIKit
import NCMB

class LogoutViewController: UIViewController {
    
    // Logoutボタン押下時の処理
    @IBAction func logoutBtn(_ sender: UIButton) {
        NCMBUser.logOut()
        self.dismiss(animated: true, completion: nil)
        print("ログアウトしました")
        
    }
    
}


