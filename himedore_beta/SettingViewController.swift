//
//  SettingViewController.swift
//  himedore_beta
//
//  Created by Takemi Watanuki on 2015/02/23.
//  Copyright (c) 2015年 watakemi725. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet var allNumlabel : UILabel!
    @IBOutlet var oujiNumlabel : UILabel!
    
    var allNum = 0
    var oujiNum = 0
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        
        
        //入力された値から役割とか計算する
        
        
        
        
        
        
    }

    @IBAction func plusAllNum(){
        allNum++
        allNumlabel.text="\(allNum)"
    }
    @IBAction func minusAllNum(){
        allNum--
        allNumlabel.text="\(allNum)"
    }
    @IBAction func plusOujiNum(){
        oujiNum++
        oujiNumlabel.text="\(oujiNum)"
    }
    @IBAction func minusOujiNum(){
        oujiNum--
        oujiNumlabel.text="\(oujiNum)"
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
