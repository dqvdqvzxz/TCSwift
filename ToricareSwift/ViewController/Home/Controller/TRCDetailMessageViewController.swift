//
//  TRCDetailMessageViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/28/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCDetailMessageViewController: UIViewController {

    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var lblTitleMessage: UILabel!
    @IBOutlet weak var lblSender: UILabel!
    @IBOutlet weak var lblLine: UILabel!
    @IBOutlet weak var lblTimeSent: UILabel!
    
    @IBOutlet weak var viewLine: UIView!
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewContentMessage: UIView!
    
    @IBOutlet weak var tvContent: UITextView!
    
    var messageData: TRCMessage!
    
    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Config UI
    func configUI(){
        //navigation
        self.navigationItem.title = Localizable(value: "message_list")
        
        //UI
        lblTitleMessage.labelStyle(title: messageData.title, fontSize: LABEL_FONT_SIZE, isBold: true, textColor: LABEL_FONT_COLOR)
        
        lblSender.labelStyle(title: messageData.sender + " | " + messageData.createdAt, fontSize: LABEL_FONT_SIZE, isBold: false, textColor: BACKGROUND_COLOR)
        
        viewLine.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
        tvContent.text = messageData.message
        
//        lblContent.lineBreakMode = .byWordWrapping
//        lblContent.numberOfLines = 0
//        lblContent.labelStyle(title: "田中様 \n 来店のご予約ですが、\n 明日12月5日（火）10：00となります。\n 何卒宜しくお願い致します。 \n\n ※本メールは、システムより自動的に通知させていただいております。\n\n ○○薬局 \n山田 太郎")
    }
}
