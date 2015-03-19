//
//  SettingViewController.swift
//  himedore_beta
//
//  Created by Takemi Watanuki on 2015/02/23.
//  Copyright (c) 2015年 watakemi725. All rights reserved.
//

import UIKit



class SettingViewController: UIViewController ,UIAlertViewDelegate{
    
    @IBOutlet var allNumlabel : UILabel!
    @IBOutlet var oujiNumlabel : UILabel!
    
    var allNum = 4
    var oujiNum = 1
    
    var yoiDorei = 0
    var waruiDorei = 0
    var dorei = 0
    
    var k=0 //割り算の答え
    
    var playerArray: NSMutableArray = NSMutableArray()
    
    //デリゲート関係
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        
        //入力された値から役割とか計算する
        
        //        self.haiyaku(1, oujiNum: 3)
        
        allNumlabel.text = "\(allNum)人"
        oujiNumlabel.text = "\(oujiNum)人"
        
        
    }
    
    func haiyaku(allNum:Int,oujiNum:Int){
        
        
        return
    }
    
    @IBAction func plusAllNum(){
        allNum++
        allNumlabel.text="\(allNum)人"
    }
    @IBAction func minusAllNum(){
        if(allNum>4){
            allNum--
        }
        allNumlabel.text="\(allNum)人"
        
    }
    @IBAction func plusOujiNum(){
        oujiNum++
        oujiNumlabel.text="\(oujiNum)人"
    }
    @IBAction func minusOujiNum(){
        if(oujiNum>1){
            oujiNum--
        }
        oujiNumlabel.text="\(oujiNum)人"
    }
    
    @IBAction func start(){
        dorei = allNum - oujiNum
        
        if(dorei>2){
            
            if(dorei%2==0){
                k = (dorei/2)-1
            }else{
                k=dorei/2
            }
            
                
            yoiDorei = Int(arc4random() % UInt32(k) + 1) //キャスト
            println("良い奴隷は\(yoiDorei)人")
            waruiDorei = dorei - yoiDorei
            println("悪い奴隷は\(waruiDorei  )人")
            
            appDelegate.hiritu = "\(yoiDorei):\(waruiDorei)"
            
            for i in 0..<oujiNum{
                playerArray.addObject("王子")
            }
            for i in 0..<(waruiDorei){
                playerArray.addObject("悪奴隷")
            }
            for i in 0..<(yoiDorei){
                playerArray.addObject("良い奴隷")
            }
            
            //        playerArray = ["hoge", "huga", "piyo"]
            playerArray.shuffle(playerArray.count) //外部ファイルの.shuffleで用意したファイルの数字をシャッフルしてくれる
            
            for i in 0...(playerArray.count)-1 {
                println(" \(i+1)人目は\(playerArray[i])")
            }
            
            //配列をnsuserdefaultsに入れる
            
            //NSUserDefaultsのインスタンスを生成
            let playerHokan = NSUserDefaults.standardUserDefaults()
            
            //"NAME"というキーで配列namesを保存
            playerHokan.setObject(playerArray, forKey:"player")
            
            // シンクロを入れないとうまく動作しないときがあります
            playerHokan.synchronize()
            
            
            appDelegate.turnNum = 1 //appDelegateの変数を操作
            
            
            
            
            playerArray.removeAllObjects()
            
            
            var targetView: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier( "haiyaku" )
            
            self.presentViewController( targetView as UIViewController, animated: false
                , completion: nil)
            
        }else{
            //数が足らんor おかしいやろ
            
            println("だめーーー")
            
            func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
                if (buttonIndex == alertView.cancelButtonIndex) {
                    //Canceled
                    println("たんねーのかよーわかったよー")
                    
                    //画面遷移も何もせずにとどまる
                }
            
            }

            
            if objc_getClass("UIAlertController") != nil {
                //UIAlertController使用
                //アラート使うならここも必要らしいぞ!!
                
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
                var av = UIAlertView(title: "警告", message:"王子の数を減らすか、\n全プレーヤー数を増やしてください", delegate: self, cancelButtonTitle: "OK")
                av.show()
            }
            
            
    
            
            
            
        }
        
        
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
