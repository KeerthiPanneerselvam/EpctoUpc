//
//  ViewController.swift
//  Newprj
//
//  Created by Admin on 19/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        let epctoupc = EpctoUpc()
        let result : String?
        let epc = "3034257BF400B7800004CB2F"
        if epctoupc.checkforhexString(epc) && epctoupc.CheckcorrectEpcLength(epc) {
            result = epctoupc.epctoupc(epc)
            if result != nil
            {
                print(result!)
            }
        }
    }
    
    }


