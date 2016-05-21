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
    
    
    @IBOutlet var hakoLabel : UILabel!
    @IBOutlet var yakuLabel : UILabel!
    @IBOutlet var junLabel : UILabel!
    
    
    
    
    
    //NSUserDefaultsのインスタンスを生成
    let playerHokan = NSUserDefaults.standardUserDefaults()
    
    //空の配列を用意
    var playerArray: NSMutableArray = NSMutableArray()
    
    //    var appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
    
    var junbanNum = 1
    
    var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ブスかぶってるか判定
        
        
        

        
        
        
        // Do any additional setup after loading the view.
        
        //順番数字を与える
        
        
        //        junbanNum = appDelegate.turnNum
        //
        //        if junbanNum == nil {
        //
        //            junbanNum = 0
        //        }
        
        
        
        
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
                playerArray.addObject(nameString as! NSString)
            }
        }
        
        
        
        
        
        
        
        self.alertshow("wao", boxNum: 3, playerNum: 5)
        
        //ヒント用ブスの役職を入れる感じ
        appDelegate.busuYaku = playerArray[appDelegate.busuBanme] as! NSString
        
        
    }
    
    

    
    
    //アラートが押されたときの機能
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if (buttonIndex == alertView.cancelButtonIndex) {
            //Canceled
            print("cancle")
            
            //画面遷移も何もせずにとどまる
        } else {
            //OK
            print("ok")
            
            self.display()
            
            
            //画面遷移をして次のページへとすすめる
            //画面遷移したさきで役職を与えられて次へ移動
            
            
            
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
            let ac = UIAlertController(title: "Title", message: "Message", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in
                print("Cancel button tapped.")
            }
            
            let okAction = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
                print("OK button tapped.")
            }
            
            ac.addAction(cancelAction)
            ac.addAction(okAction)
            
            presentViewController(ac, animated: true, completion: nil)
            
            
            
        } else {
            //UIAlertView使用
            let av = UIAlertView(title: "本人確認", message:"あなたは\(junbanNum)番目の人ですか?", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "OK")
            av.show()
            
        }
    }
    
    
    
    
    
    
    
    
    @IBAction func alertBtn() {
        
        if (playerArray.count==junbanNum ){
            //おわり　タイマーへ
            print("おわりんこ")
            var targetView: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier( "timer" )
            self.presentViewController( targetView as! UIViewController, animated: true
                , completion: nil)
            //            self.dismissViewControllerAnimated(true, completion: nil)
        }else{
            //順番を増やして 前の画面へ戻る次の人のターン
            junbanNum++   //appDelegateの変数を操作 順番かえる
            
            //アラートをまた表示する
            
            
            var av = UIAlertView(title: "本人確認", message:"あなたは\(junbanNum)番目の人ですか?", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "OK")
            av.show()
            
            
            
        }
        
        
        
    }
    
    
    func display(){
        //あとは表示してあげる
        junLabel.text = "\(junbanNum)"
        
        //もしも王子なら箱は秘密やで
        if (playerArray[junbanNum-1] as! NSString == "警察官"){
            hakoLabel.text = "秘密やで"
        }else if (appDelegate.busuBool == true){
            //勘違いブスがいる
            print("ブスあり")
            //もしもブス番目と一致したならブス番号を表示
            if junbanNum-1 == appDelegate.busuBanme {
                hakoLabel.text = "\(appDelegate.busuNum)"
                
            }else if junbanNum-1 != appDelegate.busuBanme {
                //それ以外なら普通の数字を表示せよ
                hakoLabel.text = "\(appDelegate.oriNum)"
            }
            
            //ブス機能自体OFF
        }else if (appDelegate.busuBool == false){
            //勘違いブスがいないから普通にやってええよ
            print("ブスなし")
            
            hakoLabel.text = "\(appDelegate.oriNum)"
        }
        
        yakuLabel.text = "\(playerArray[junbanNum-1])"
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
