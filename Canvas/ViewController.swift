//
//  ViewController.swift
//  Canvas
//
//  Created by Sachitha on 8/20/18.
//  Copyright © 2018 Sachitha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var canvas: CanvasView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        canvas.addNewLayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func resetAction(_ sender: UIButton) {
        canvas.resetAll()
        canvas.addNewLayer()
    }
    
}

