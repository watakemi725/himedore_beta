//
//  HintViewController.swift
//  himedore_beta
//
//  Created by Takemi Watanuki on 2015/02/23.
//  Copyright (c) 2015年 watakemi725. All rights reserved.
//

import UIKit

class HintViewController: UIViewController {
    
    var hiritu : NSString!
    
    @IBOutlet var label : UILabel!
    
    @IBOutlet var hintText : UITextView!
    
    var appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //どっちか選べって感じかな
        
        hiritu = appDelegate.hiritu
        
        
        hintText.text = " 良:悪の比率は\(hiritu) \n 勘違いブスは○○を知っている "
        
        //タイマーもつけちゃって良いかな
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(){
        var targetView: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier( "timer" )
        
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
