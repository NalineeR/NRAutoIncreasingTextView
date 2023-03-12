//
//  ViewController.swift
//  NRAutoIncreasingTextView
//
//  Created by NalineeR on 03/12/2023.
//  Copyright (c) 2023 NalineeR. All rights reserved.
//

import UIKit
import NRAutoIncreasingTextView

class ViewController: UIViewController {

    @IBOutlet weak var txtV:NRAutoIncreasingTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        txtV.maxLinesWithoutScroll = 2
        txtV.minHeightLineMultiplier = 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

