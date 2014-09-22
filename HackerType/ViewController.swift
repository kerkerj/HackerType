//
//  ViewController.swift
//  HackerType
//
//  Created by Jerry Huang on 2014/9/22.
//  Copyright (c) 2014年 Jerry Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    var textView: UITextView = UITextView()
    var topBarHeight: Float = 20.0
    var tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
    var fileContents: String = ""
    var fileLength: Int = 0
    var fileReaderStartCount: Int = 0
    
    func _initUI() {
        println(self.view.frame.width)
        println(self.view.frame.height)
        
        fileContents = readFile("kernel", fileExtension: "txt")!
        fileLength = countElements(fileContents)
        
        textView.frame = CGRectMake(0.0, CGFloat(topBarHeight), self.view.frame.width, self.view.frame.height - CGFloat(topBarHeight) - 100)
        textView.backgroundColor = UIColor.blackColor()
        textView.textColor = UIColor.greenColor()
        textView.text = ""
        textView.font = UIFont.systemFontOfSize(14.0)
        textView.editable = false
        textView.selectable = false
        textView.scrollEnabled = true

        self.view.addSubview(textView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        _initUI()
        
        // Set tapGesture
        tapGesture = UITapGestureRecognizer(target: self, action: Selector("getTap:"))
        self.tapGesture.delegate = self
        textView.addGestureRecognizer(self.tapGesture)
    }
    
    func readFile(fileName : String, fileExtension : String) -> String? {
        var myFile = NSBundle.mainBundle().pathForResource(fileName, ofType: fileExtension)
        var fileContents = String.stringWithContentsOfFile(myFile!, encoding: NSUTF8StringEncoding, error: nil)
        return fileContents
    }
    
    func getTap(recognizer: UITapGestureRecognizer) {
        var touchPoint = recognizer.locationInView(self.textView)
        println("taped: \(touchPoint.x), \(touchPoint.y)")
        
        var inteval = 20
        var appendString = String(seq: Array(self.fileContents)[fileReaderStartCount...(fileReaderStartCount+inteval)])
        fileReaderStartCount += (inteval+1)
        
        self.textView.text = self.textView.text.stringByAppendingString(appendString)
        self.textView.scrollRectToVisible(CGRectMake(0, self.textView.contentSize.height, self.textView.contentSize.width, 10), animated: true)
//        self.textView.scrollRangeToVisible(NSRange(location: countElements(self.textView.text), length: 0))
        
        println("contentsize.h: \(self.textView.contentSize.height), contentsize.w: \(self.textView.contentSize.width)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

