//
//  TimerViewController.swift
//  himedore_beta
//
//  Created by Takemi Watanuki on 2015/02/23.
//  Copyright (c) 2015年 watakemi725. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    
    /*
    1回目
    2回目と
    
    分けてあげないといけないのだ
    
    
    */
    
    var appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
    
    var viewNum : Int?
    
    var cnt : Int = 1000 //timer用のカウント
    
    @IBOutlet var timerLabel : UILabel!
    
    
    //タイマー
    var timer : NSTimer!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        //画面開くとともにタイマー開始
        
        cnt = 10
        
        //timerが動いてるなら.

           
        
        //timerを生成する.
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "onUpdate:", userInfo: nil, repeats: true)
            
        
        viewNum = appDelegate.viewNum
        
        if viewNum == nil {
            viewNum = 1
            
            appDelegate.viewNum = viewNum
            
        }else{
            viewNum = 2
        }
        
    }
    
    
    //NSTimerIntervalで指定された秒数毎に呼び出されるメソッド.
    func onUpdate(timer : NSTimer){
        
        if(cnt>0){
            cnt -= 1
            
            //桁数を指定して文字列を作る.
            let str = "\(cnt)"
            
            timerLabel.text = str
            
        }else{
            //画面遷移
            self.end()

        }
        
}
    //plusされた時
    
    @IBAction func plusone(){
        cnt+=1
    }
    
    //plusされた時
    @IBAction func minuseone(){
        cnt-=1
    }
    
    @IBAction func skip(){
        
        //timerが動いてるなら.

        self.end()
        
    }
    
    func end(){
        
        timer.invalidate()
        
        if viewNum == 1 {
            
            
            var targetView: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier( "hint" )
            
            self.presentViewController( targetView as UIViewController, animated: true
                , completion: nil)
        }else{
            var targetView: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier( "keka" )
            
            self.presentViewController( targetView as UIViewController, animated: true
                , completion: nil)
            appDelegate.viewNum = nil
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
