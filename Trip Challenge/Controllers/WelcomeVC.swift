//
//  Welcome.swift
//  Trip Challenge
//
//  Created by Kate on 13/11/2023.
//

import UIKit

class WelcomeVC: UIViewController {

    @IBOutlet weak var startLbl: UILabel!
    @IBOutlet weak var welcomwLbl: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "showMainVC", sender: self)
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