//
//  CharaViewController.swift
//  himedore_beta
//
//  Created by Takemi Watanuki on 2015/02/23.
//  Copyright (c) 2015年 watakemi725. All rights reserved.
//

import UIKit

class CharaViewController: UIViewController, UIAlertViewDelegate {
    
    //    var alertController = UIAlertController(title: "Hello!", message: "This is sample", preferredStyle: .Alert)
    //
    //    var defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil){
    //        action in
    //    }
    //
    //    alertController.addAction(defaultAction)
    //
    //    presentViewController(alertController, animated: true, completion: nil)
    //
    //
    //    presentview
    //
    
    
    
    //NSUserDefaultsのインスタンスを生成
    let playerHokan = NSUserDefaults.standardUserDefaults()
    
    //空の配列を用意
    var playerArray: NSMutableArray = NSMutableArray()
    
    var appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
    
    var junbanNum : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //順番数字を与える
        
        
        junbanNum = appDelegate.turnNum
        
        if junbanNum == nil {
           
            junbanNum = 0
        }

         
        
        
        //配列も受け取る
        
        
        //前回の保存内容があるかどうかを判定
        if((playerHokan.objectForKey("player")) != nil){
            
            //objectsを配列として確定させ、前回の保存内容を格納
            let objects = playerHokan.objectForKey("player") as? NSMutableArray
            
            //各名前を格納するための変数を宣言
            var nameString:AnyObject
            
            //前回の保存内容が格納された配列の中身を一つずつ取り出す
            for nameString in objects!{
                //配列に追加していく
                playerArray.addObject(nameString as NSString)
            }
        }
        

        
        
        
        
        
        self.alertshow("wao", boxNum: 3, playerNum: 5)
        
        
        
        
        
    }
    
    
    //アラート
    
    
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if (buttonIndex == alertView.cancelButtonIndex) {
            //Canceled
            println("cancle")
            
            //画面遷移も何もせずにとどまる
        } else {
            //OK
            println("ok")
            //画面遷移をして次のページへとすすめる
            //画面遷移したさきで役職を与えられて次へ移動
            
            appDelegate.turnNum = junbanNum  //appDelegateの変数を操作 順番かえる
            
            var targetView: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier( "chara" )
            
            self.presentViewController( targetView as UIViewController, animated: true
                , completion: nil)

        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func alertshow(job:NSString,boxNum:Int,playerNum:Int){
        //ios7ではuialertviewしかつかえない
        
        if objc_getClass("UIAlertController") != nil {
            //UIAlertController使用
            var ac = UIAlertController(title: "Title", message: "Message", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in
                println("Cancel button tapped.")
            }
            
            let okAction = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
                println("OK button tapped.")
            }
            
            ac.addAction(cancelAction)
            ac.addAction(okAction)
            
            presentViewController(ac, animated: true, completion: nil)
            
            
            
        } else {
            //UIAlertView使用
            var av = UIAlertView(title: "本人確認", message:"あなたは\(junbanNum)番目の人ですか?", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "OK")
            av.show()
        }
    }
    
    @IBAction func alertBtn(sender: UIButton) {
        let alertController = UIAlertController(title: "Hello!", message: "This is Alert sample.", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
