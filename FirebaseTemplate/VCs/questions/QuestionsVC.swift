//
//  QuestionsVC.swift
//  iVetAR
//
//  Created by Huda on 7/6/20.
//  Copyright © 2020 shaikha aljenaidel. All rights reserved.
//

import UIKit
var myPet = Profile(petName: "Mochi", petType: "Dog", petGender: "Male", petAge: "21")
class QuestionsVC: UIViewController {
    var year: String!
    var month: String!
    var answers: [Int] = []
    var i = 0
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var petTypeImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        petTypeImg.image = UIImage(named: myPet.petType)
        if myPet.petType == "قطه" {
            checkCatAge()
        }
        setQuestionLabel()
        questionLabel.numberOfLines = 0
        // Do any additional setup after loading the view.
    }
    
    @IBAction func yesBtn(_ sender: Any) {
        answers.append(1)
        i += 1
        setQuestionLabel()
    }
    @IBAction func noBtn(_ sender: Any) {
        answers.append(0)
        i += 1
        setQuestionLabel()
    }
    
    func setQuestionLabel() {
        let packageNumber = checkAnswer(answer: answers)
        if i == catQuestionsM.count && myPet.petType == "قطه" && myPet.petGender == "Male"{
            switch packageNumber {
            case 1:
                choosePackage1(show: false, titleLabel: "بحاجه لتدخل طبي للاسهال !", btnTxt: "", petName: myPet.petName)
            case 2:
                choosePackage2(pText: " فقط قم باتباع هذه الخطوات لحل مشكلة الاسهال عند \(myPet.petName)", tips: catTipsP2)
            case 3:
                choosePackage1(show: true, titleLabel: "بحاجه لتدخل طبي للاسهال !", btnTxt: "اضغط لحل مشكلة العين", petName: myPet.petName)
            case 4:
                choosePackage2(pText: "فقط قم باتباع هذه الخطوات لحل مشكلة العين و الاسهال عند \(myPet.petName)", tips: catTipsP4)
            case 5:
                choosePackage2(pText: "فقط قم باتباع هذه الخطوات لحل مشكلة العين عند \(myPet.petName)", tips: catTipsP5)
            case 6:
                choosePackage1(show: false, titleLabel: "يمكن ان يكون بحاجه لتدخل طبي لشيء لا يعرفه iVet", btnTxt: "", petName: myPet.petName)
            default:
                fatalError()
            }
        }else if myPet.petType == "قطه" && i != catQuestionsM.count && myPet.petGender == "Male"{
            questionLabel.text = "\(catQuestionsM[i].question)"
        }else if myPet.petType == "قطه" && i == catQuestionsF.count && myPet.petGender == "Female"{
            switch packageNumber {
            case 1:
                choosePackage1(show: false, titleLabel: "بحاجه لتدخل طبي للاسهال !", btnTxt: "", petName: myPet.petName)
            case 2:
                choosePackage2(pText: " فقط قم باتباع هذه الخطوات لحل مشكلة الاسهال عند \(myPet.petName)", tips: catTipsP2)
            case 3:
                choosePackage1(show: true, titleLabel: "بحاجه لتدخل طبي للاسهال !", btnTxt: "اضغط لحل مشكلة العين", petName: myPet.petName)
            case 4:
                choosePackage2(pText: "فقط قم باتباع هذه الخطوات لحل مشكلة العين و الاسهال عند \(myPet.petName)", tips: catTipsP4)
            case 5:
                choosePackage2(pText: "فقط قم باتباع هذه الخطوات لحل مشكلة العين عند \(myPet.petName)", tips: catTipsP5)
            case 6:
                choosePackage1(show: false, titleLabel: "يمكن ان تكون بحاجه لتدخل طبي لشيء لا يعرفه iVet", btnTxt: "", petName: myPet.petName)
            default:
                fatalError()
            }
        }else if myPet.petType == "قطه" && i != catQuestionsF.count && myPet.petGender == "Female" {
                questionLabel.text = "\(catQuestionsF[i].question)"
            }else if myPet.petType == "كلب" && i == dogQuestionsM.count && myPet.petGender == "Male" {
            switch packageNumber {
            case 7:
                choosePackage2(pText: "فقط قم باتباع هذه الخطوات لحل مشكلة الحروق عند \(myPet.petName)", tips: dogTips7)
            case 8:
                choosePackage1(show: false, titleLabel: "بحاجه لتدخل طبي لامر غير طبيعي في مفاصله !", btnTxt: "", petName: myPet.petName)
            case 9:
                choosePackage1(show: true, titleLabel: "بحاجه لتدخل طبي لامر غير طبيعي في مفاصله !", btnTxt: "اضغط لحل مشكلة الحروق", petName: myPet.petName)
            case 10:
                choosePackage1(show: false, titleLabel: "يمكن ان يكون بحاجه لتدخل طبي لشيء لا يعرفه iVet", btnTxt: "", petName: myPet.petName)
            default:
                fatalError()
            }
        }else if i != dogQuestionsM.count && myPet.petType == "كلب" && myPet.petGender == "Male" {
            questionLabel.text = "\(dogQuestionsM[i].question)"
        }else if myPet.petType == "كلب" && myPet.petGender == "Female" && i == dogQuestionsF.count{
            switch packageNumber {
            case 7:
                choosePackage2(pText: "فقط قم باتباع هذه الخطوات لحل مشكلة الحروق عند \(myPet.petName)", tips: dogTips7)
            case 8:
                choosePackage1(show: false, titleLabel: "بحاجه لتدخل طبي لامر غير طبيعي في مفاصلها !", btnTxt: "", petName: myPet.petName)
            case 9:
                choosePackage1(show: true, titleLabel: "بحاجه لتدخل طبي لامر غير طبيعي في مفاصلها !", btnTxt: "اضغط لحل مشكلة الحروق", petName: myPet.petName)
            case 10:
                choosePackage1(show: false, titleLabel: "يمكن ان تكون بحاجه لتدخل طبي لشيء لا يعرفه iVet", btnTxt: "", petName: myPet.petName)
            default:
                fatalError()
            }
        }else if i != dogQuestionsF.count && myPet.petType == "كلب" && myPet.petGender == "Female"{
            questionLabel.text = "\(dogQuestionsF[i].question)"
        }
    }
    

//    func choosePackage(show: Bool?, subTitleTxt: String?, tips: [String]?) {
//        if show != nil {
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "VetInfoVC") as! VetInfoVC
//            if show == false {
//                   vc.showButton = false
//                   } else {
//                   vc.showButton = true
//                   }
//            self.navigationController?.pushViewController(vc, animated: true)
//            view.window?.rootViewController = vc
//            view.window?.makeKeyAndVisible()
//        } else if show == nil {
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "tips") as! tipsTableVC
//                   vc.tips = tips!
//                   vc.subTitle = subTitleTxt!
//            self.navigationController?.pushViewController(vc, animated: true)
//            view.window?.rootViewController = vc
//            view.window?.makeKeyAndVisible()
//        }
//    }
    func choosePackage1(show: Bool, titleLabel: String, btnTxt: String, petName: String) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VetInfoVC") as! VetInfoVC
        vc.titleLabel = titleLabel
        vc.petName = petName
        if show == false {
            vc.showButton = false
            vc.btnText = btnTxt
        } else {
            vc.showButton = true
            vc.btnText = btnTxt
               }
        self.navigationController?.pushViewController(vc, animated: true)
        view.window?.rootViewController = vc
        view.window?.makeKeyAndVisible()
    }
    
    func choosePackage2(pText: String, tips: [String]) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tips") as! tipsTableVC
        vc.tips = tips
        vc.subTitle = pText
        self.navigationController?.pushViewController(vc, animated: true)
        view.window?.rootViewController = vc
        view.window?.makeKeyAndVisible()
    }
    func calculateAge() -> Int{
        let result = (Int(year)! * 12) + Int(month)!
        return result
    }
    func checkCatAge() {
        let ageInMonths = calculateAge()
        if  ageInMonths >= 4{
            answers.append(1)
        }else {
            answers.append(0)
            }
    }
}
//extension UIViewController {
//
//    var isModal: Bool {
//
//        let presentingIsModal = presentingViewController != nil
//        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
//        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController
//
//        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
//    }
//}
