//
//  WelcomeeViewController.swift
//  random
//
//  Created by Pantos, Thomas on 14/7/22.
//

import UIKit

class WelcomeeViewController: UIViewController {
    
    
    @IBOutlet weak var vwContainer: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwContainer.alpha = 0.0
        self.view.addSubview(vwContainer)
        UIView.animate(withDuration: 1.5, delay: 0.2) {
            self.vwContainer.alpha = 1.0
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
