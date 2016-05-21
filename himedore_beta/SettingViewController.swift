//
//  SettingViewController.swift
//  himedore_beta
//
//  Created by Takemi Watanuki on 2015/02/23.
//  Copyright (c) 2015年 watakemi725. All rights reserved.
//

import UIKit


class SettingViewController: UIViewController ,UIAlertViewDelegate{
    
    @IBOutlet var btn : UIButton!
    
    @IBOutlet var allNumlabel : UILabel!
    @IBOutlet var oujiNumlabel : UILabel!
//    @IBOutlet var kanchigaiBtn : UISwitch!
    
    var allNum = 4
    var oujiNum = 1
    
    var yoiDorei = 0
    var waruiDorei = 0
    var dorei = 0
    
    var k=0 //割り算の答え
    
    var playerArray: NSMutableArray = NSMutableArray()
    
    //デリゲート関係
    var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    //AppDelegateのインスタンスを取得
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        
        //入力された値から役割とか計算する
        
        //        self.haiyaku(1, oujiNum: 3)
        
        allNumlabel.text = "\(allNum)人"
        oujiNumlabel.text = "\(oujiNum)人"
        
        //檻の設定
        appDelegate.oriNum = Int(arc4random() % 5 + 1)
        
        //ブス番号の設定
        self.busuRandom()
        repeat{
            self.busuRandom()
        }while appDelegate.busuNum == appDelegate.oriNum
        
        print("ぶすは\(appDelegate.busuNum),おりは\(appDelegate.oriNum)")
        
        appDelegate.busuBool = false
        
    }
    
    func busuRandom(){
     appDelegate.busuNum = Int(arc4random() % 5 + 1)
    }
    
    func haiyaku(allNum:Int,oujiNum:Int){
        
        
        return
    }
    
    @IBAction func busu(sender: UISwitch){
        if sender.on {
            print("on")
            appDelegate.busuBool = true
        }else{
            print("off")
            appDelegate.busuBool = false
        }
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
        appDelegate.doreiNum = dorei-1
        if(dorei>2){
            
            if(dorei%2==0){
                k = (dorei/2)-1
            }else{
                k=dorei/2
            }
            
            
            yoiDorei = Int(arc4random() % UInt32(k) + 1) //キャスト
            print("良い奴隷は\(yoiDorei)人")
            waruiDorei = dorei - yoiDorei
            print("悪い奴隷は\(waruiDorei  )人")
            
            appDelegate.hiritu = "\(yoiDorei):\(waruiDorei)"
            
            
            //配役arrayの仲に追加
            for i in 0..<oujiNum{
                playerArray.addObject("警察官")
            }
            
            for i in 0..<(waruiDorei){
                playerArray.addObject("悪い爆弾班")
                }
            
            for i in 0..<(yoiDorei){
                playerArray.addObject("良い爆弾班")
            }
            
            //        playerArray = ["hoge", "huga", "piyo"]
            playerArray.shuffle(playerArray.count) //外部ファイルの.shuffleで用意したファイルの数字をシャッフルしてくれる
            
            for i in 0...(playerArray.count)-1 {
                print(" \(i+1)人目は\(playerArray[i])")
            }
            
            //配列をnsuserdefaultsに入れる
            
            //NSUserDefaultsのインスタンスを生成
            let playerHokan = NSUserDefaults.standardUserDefaults()
            
            //"NAME"というキーで配列namesを保存
            playerHokan.setObject(playerArray, forKey:"player")
            
            // シンクロを入れないとうまく動作しないときがあります
            playerHokan.synchronize()
            
            
            appDelegate.turnNum = 1 //appDelegateの変数を操作
            
            
            
            //ブスが何番目の人なのかをランダムに決定する。警察かぶらないようにもする
            self.busuBanneRandom(self.dorei)
            repeat {
                print(" ブスは\(appDelegate.busuBanme+1)人目")
                self.busuBanneRandom(appDelegate.doreiNum)
            }while playerArray[appDelegate.busuBanme] as! NSString == "警察官"
            //ブス番目が警察官と一致している間はランダムをまわすようにすること
            
            print(" ブスは\(appDelegate.busuBanme+1)人目")
            
            
            
            
            
            playerArray.removeAllObjects()
            
            
            //数秒待って配役中的なちょっとした動きをつける
            
            let delay = 3.0 * Double(NSEC_PER_SEC)
            let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue(), {
                print("dispatch after!")
                
                var targetView: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier( "haiyaku" )
                
                self.presentViewController( targetView as! UIViewController, animated: false
                    , completion: nil)
                
            })
            
            
            
            
        }else{
            //数が足らんor おかしいやろ
            
            print("だめーーー")
            
            func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
                if (buttonIndex == alertView.cancelButtonIndex) {
                    //Canceled
                    print("たんねーのかよーわかったよー")
                    
                    //画面遷移も何もせずにとどまる
                }
                
            }
            
            
            if objc_getClass("UIAlertController") != nil {
                //UIAlertController使用
                //アラート使うならここも必要らしいぞ!!
                
                var ac = UIAlertController(title: "Title", message: "Message", preferredStyle: .Alert)
                
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
                var av = UIAlertView(title: "警告", message:"王子の数を減らすか、\n全プレーヤー数を増やしてください", delegate: self, cancelButtonTitle: "OK")
                av.show()
            }
            
            
        }
        
        
    }
    
    func busuBanneRandom(dorei:Int) -> Int{
        
        appDelegate.busuBanme = Int(arc4random() % UInt32(dorei) + 1)
        return 0
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
