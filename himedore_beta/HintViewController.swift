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
    
//    var hintNum : Int!
    
    @IBOutlet var label : UILabel!
    
    @IBOutlet var hintText : UITextView!
    
    var appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //AppDelegateのインスタンスを取得
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //ランダムをまわしてヒントをとってくる、情報を呈示する。
        
        
        
        
//self.showKesuBox()
        
        //タイマーもつけちゃって良いかな
    }
    
    @IBAction func hintpush(sender: UIButton){
//        sender.tag = hintNum
        
        switch sender.tag{
        case 0 :
            showHiritu()
            break
            
        case 1 :
            showBusuYaku()
            break
        case 2 :
            showKesuBox()
            break

        default :
            break
        
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //比率を表示する
    func showHiritu(){
        hiritu = appDelegate.hiritu
        
        hintText.text = " 良:悪の比率は\(hiritu) \n  "
    }
    
    //ブスの配役を表示
    func showBusuYaku(){
        hintText.text = " 勘違いの役職は\(appDelegate.busuYaku)  "
    }
    
    //消すボックスを表示
    func showKesuBox(){
        self.kesuBox(appDelegate.oriNum)
        hintText.text = "消す箱は\(appDelegate.kesuBox)番目"
    }
    
    func kesuBox(seikai:Int){
        self.kesuRandom()
        repeat{
            self.kesuRandom()
        }while appDelegate.kesuBox == seikai
    }
    func kesuRandom(){
        appDelegate.kesuBox = Int(arc4random() % 5 + 1)
    }
    
    
    
    @IBAction func back(){
        var targetView: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier( "timer" )
        
        self.presentViewController( targetView as! UIViewController, animated: true
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
