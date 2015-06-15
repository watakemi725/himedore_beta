//
//  TextViewController.swift
//  himedore_beta
//
//  Created by Takemi Watanuki on 2015/04/11.
//  Copyright (c) 2015年 watakemi725. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {
    var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    var himehako = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        himehako = appDelegate.oriNum
        
        // Do any additional setup after loading the view.
        
        //ここでは箱を選んでもらう
        
        //1~5個の箱を用意buttonで
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func push(sender: UIButton){
        
        if sender.tag == himehako {
            //正解　良い奴隷と王子の勝ち
            println("正解　良い奴隷と王子の勝ち")
        }else{
            //王子の負け
            println("王子の負け")
            
        }
        
        var targetView: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier( "keka" )
        
        self.presentViewController( targetView as UIViewController, animated: true
            , completion: nil)
        
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
