//
//  CatalogViewController.swift
//
//  Created by Brian King on 7/27/16.
//  Copyright © 2016 Raizlabs. All rights reserved.
//

import UIKit

class CatalogViewController: UIViewController {
    @IBAction func displayAlert() {
        let controller = UIAlertController(title: "Alert", message: "This is a message", preferredStyle: .Alert)
        controller.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        presentViewController(controller, animated: true, completion: nil)
    }
}
