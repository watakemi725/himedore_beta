//
//  HaiyakuViewController.swift
//  himedore_beta
//
//  Created by Takemi Watanuki on 2015/03/08.
//  Copyright (c) 2015年 watakemi725. All rights reserved.
//

import UIKit

class HaiyakuViewController: UIViewController {
    
    
    @IBOutlet var hakoLabel : UILabel!
    @IBOutlet var yakuLabel : UILabel!
        @IBOutlet var junLabel : UILabel!

    //NSUserDefaultsのインスタンスを生成
    let playerHokan = NSUserDefaults.standardUserDefaults()
    
    //空の配列を用意
    var playerArray: NSMutableArray = NSMutableArray()
    
    var appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
    
    var junbanNum : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //何番目か確認する
        //nsuserdefaultsで配役の配列はあたえていいんじゃないの
         junbanNum = appDelegate.turnNum
        
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
            
            
            
            //あとは表示してあげる
            junLabel.text = "\(junbanNum+1)"
            hakoLabel.text = "2"
            yakuLabel.text = "\(playerArray[junbanNum])"
            
            
            
        }
        

   
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func complete(){
        //元の画面にもどるか、最後のプレーヤーだったらタイマーを開始するように反手居るしてあげる

        if (playerArray.count==junbanNum+1 ){
            //おわり　タイマーへ
            println("おわりんこ")
                        var targetView: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier( "timer" )
            self.presentViewController( targetView as UIViewController, animated: true
                , completion: nil)
            
        }else{
            appDelegate.turnNum = junbanNum + 1  //appDelegateの変数を操作 順番かえる
            
            var targetView: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier( "haiyaku" )
            
            self.presentViewController( targetView as UIViewController, animated: true
                , completion: nil)
        }
        
        
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
