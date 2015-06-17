//
//  HanteiViewController.swift
//  himedore_beta
//
//  Created by Takemi Watanuki on 2015/02/23.
//  Copyright (c) 2015年 watakemi725. All rights reserved.
//

import UIKit

class HanteiViewController: UIViewController {
    
    @IBOutlet var haiyakuText : UITextView!
    @IBOutlet var resultLabel : UILabel!
    
    var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    var haiyakuMojiA : NSString!
    var haiyakuMojiB : NSString!
    var haiyakuMojiC : NSString!
    
    //入力画面で入力させてから発表！！
    
    
    //NSUserDefaultsのインスタンスを生成
    let playerHokan = NSUserDefaults.standardUserDefaults()
    
    //空の配列を用意
    var playerArray: NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //ゲームの判定を表示
        
        if appDelegate.Result == true {
        
        resultLabel.text = "無事着陸"

        }else{
            resultLabel.text = "爆弾爆発"
        }
        
        //全員の配役を表示
        
        haiyakuMojiA = ""
        haiyakuMojiB = "正解の箱は\(appDelegate.oriNum)\n勘違いブスは\(appDelegate.busuBanme+1)人目"
        haiyakuMojiC = ""
        
        
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
        
        for i in 0...(playerArray.count)-1 {
            haiyakuMojiA = "\n\(i+1)人目は\(playerArray[i])"
            haiyakuMojiC = haiyakuMojiB + haiyakuMojiA
            
            
            
            haiyakuMojiB = haiyakuMojiC
            
            
            
            println(" \(i+1)人目は\(playerArray[i])")
        }
        
        haiyakuText.text = haiyakuMojiB
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
