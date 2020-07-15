//
//  VetInfoVC.swift
//  iVetAR
//
//  Created by Huda on 7/6/20.
//  Copyright © 2020 shaikha aljenaidel. All rights reserved.
//

import UIKit
    
class VetInfoVC: UIViewController {
    @IBOutlet weak var otherSolutionOutlet: UIButton!
    @IBOutlet weak var petNameLabel: UILabel!
    var petName: String!
    var showButton: Bool = false
    var showImage: Bool = false
    var btnText: String!
    var titleLabel = ""
    var btnColor: UIColor!
    @IBOutlet weak var buttonImage: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setBtnColor()
        textLabel.numberOfLines = 0
        hide()
        textLabel.text = titleLabel
        petNameLabel.text = petName
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        otherSolutionOutlet.setTitle(btnText!, for: .normal)
    }
    
    @IBAction func vetLocationsBtn(_ sender: Any) {
        openUrl(urlStr: "https://www.google.com/maps/search/pet+hospital/@29.2982093,47.9496513,12z/data=!3m1!4b1")
            }
            func openUrl(urlStr:String!) {

                     if let url = NSURL(string:urlStr) {
                        UIApplication.shared.open(url as URL)
                }

            }
        
    @IBAction func otherSolution(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tips") as! tipsTableVC
        vc.tips = catTipsP5
        vc.subTitle = "فقط قم باتباع هذه الخطوات لحل مشكلة العين عند \(myPet.petName)"
        self.navigationController?.pushViewController(vc, animated: true)
        view.window?.rootViewController = vc
        view.window?.makeKeyAndVisible()
    }
    
    func setBtnColor() {
         otherSolutionOutlet.backgroundColor = btnColor
    }
    func hide() {
        if showButton == false {
            buttonImage.isHidden = true
            otherSolutionOutlet.isHidden = true
        } else {
            otherSolutionOutlet.isHidden = false
            buttonImage.isHidden = false
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
