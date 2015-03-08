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
    
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //順番数字を与える
        //配列も受け取る
        
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
            var av = UIAlertView(title: "本人確認", message:"あなたは\(playerNum)番目の人ですか?", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "OK")
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
