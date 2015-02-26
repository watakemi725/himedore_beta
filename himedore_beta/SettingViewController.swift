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
    
    var yoiDorei = 0
    var waruiDorei = 0
    var dorei = 0
    
    var k=0 //割り算の答え
    
    var playerArray: NSMutableArray = NSMutableArray()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        

        
        //入力された値から役割とか計算する
        
//        self.haiyaku(1, oujiNum: 3)
        
        
        
        
    }
    
    func haiyaku(allNum:Int,oujiNum:Int){
    
        
        return
    }
    
    @IBAction func plusAllNum(){
        allNum++
        allNumlabel.text="\(allNum)人"
    }
    @IBAction func minusAllNum(){
        if(allNum>0){
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
        
        if(dorei%2==0){
            k = (dorei/2)-1
        }else{
            k=dorei/2
        }
        yoiDorei = Int(arc4random() % UInt32(k) + 1) //キャスト
        println("良い奴隷は\(yoiDorei)人")
        waruiDorei = dorei - yoiDorei
        println("悪い奴隷は\(waruiDorei)人")
        
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
        playerArray.removeAllObjects()
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
