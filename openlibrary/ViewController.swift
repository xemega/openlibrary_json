//
//  ViewController.swift
//  openlibrary
//
//  Created by César Méndez on 17/12/15.
//  Copyright © 2015 César Méndez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var isbn: UITextField!
    @IBOutlet weak var datos: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isbn.delegate = self;
        isbn.becomeFirstResponder()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
              return true
        
    }
   
    func textFieldDidBeginEditing(textField: UITextField) {
        isbn.becomeFirstResponder()
        datos.text=""
    }
    func textFieldShouldClear(textField: UITextField) -> Bool {
        datos.text=""
        isbn.becomeFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        isbn.resignFirstResponder()
    }
   
    
 
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        isbn.resignFirstResponder()
        
        
        
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + isbn.text!
        let url = NSURL(string: urls)
       
 
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let sesion = NSURLSession(configuration: config, delegate:nil, delegateQueue:NSOperationQueue.mainQueue())
        let req = NSURLRequest(URL: url!)
        
        
        let dataTask = sesion.dataTaskWithRequest(req) { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            
            if error != nil {
                
                self.isbn.text = ""
                self.datos.text = ""
                
                
                let alerta = UIAlertController(title: "Advertencia", message: error?.localizedDescription, preferredStyle: .Alert)
                let defaultAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                alerta.addAction(defaultAction)
                self.presentViewController(alerta, animated: true, completion: nil)
                
                
            } else {
                
                
                let datosisbn:NSData? = NSData(contentsOfURL: url!)
                self.datos.text = String(data:datosisbn!, encoding:NSUTF8StringEncoding)
                
                
                
            }
    
        
        }
        
        dataTask.resume()
        return false
    }
    
    
 
   
    
    

}

