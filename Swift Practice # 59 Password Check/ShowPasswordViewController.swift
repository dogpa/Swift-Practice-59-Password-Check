//
//  ShowPasswordViewController.swift
//  Swift Practice # 59 Password Check
//
//  Created by CHEN PEIHAO on 2021/8/12.
//

import UIKit



class ShowPasswordViewController: UIViewController {
    
    
    @IBOutlet weak var showPasswordLabel: UILabel!
    
    var password : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showPasswordLabel.text = password
        // Do any additional setup after loading the view.
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
