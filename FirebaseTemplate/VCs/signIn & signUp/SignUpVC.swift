//
//  SignUpVC.swift
//  iVetAR
//
//  Created by Huda on 7/6/20.
//  Copyright © 2020 shaikha aljenaidel. All rights reserved.
//
import Firebase
import UIKit
class SignUpVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var petInfo: User?
    @IBOutlet weak var petTypeField: UITextField!
    var currentTextField: UITextField!
    let types = ["قطه", "كلب"]
    @IBOutlet weak var genderField: UITextField!
    let gender = ["Female", "Male"]
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var monthLabel: UILabel!
    let months = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]
    let years = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"]
    var pickerView = UIPickerView()
    @IBOutlet weak var petNameTextField: UITextField!
    @IBOutlet weak var ownerNameTextField: UITextField!
    var flag = 0
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var confirmPasswordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        let error = validateTheFields()
        if error != nil{
            errorMessage(message: error!)
        }else{
            let email = emailTextField.text!
            let password = passwordTextField.text!
            let conformPassword = confirmPasswordField.text!
            let ownerName = ownerNameTextField.text!
            let petName = petNameTextField.text!
            let petType = petTypeField.text!
            let petAge = ageField.text!
            let petGender = genderField.text!
            
            // You can use another User Struct as you wish
            let user = User(ownerName: ownerName,
                            email: email,
                            petName: petName,
                            petType: petType,
                            petGender: petGender,
                            petAge: petAge)
            
            if validatePassword(password: password, conformPassword: conformPassword){
                Networking.signUp(user: user, password: password, success:  { uid in
                    // ✅ Success
                    print("You have signed up successfully")
                    self.getData()
                    myPet.petName = self.petNameTextField.text!
                    myPet.petAge = self.ageField.text!
                    myPet.petGender = self.genderField.text!
                    myPet.petType = self.petTypeField.text!
                    myPets.append(myPet)
                }){
                    // ❌ Failed
                    print("there is a problem🤡")
                    self.errorMessage(message: "Couldn't sign up, make sure the email and password are correct")
                }
            }
            else{
                errorMessage(message: "Password are not matching!")
            }
            
            
        }
    }
    func validatePassword(password: String, conformPassword: String) -> Bool{
        return password == conformPassword
    }
    
    func errorMessage(message: String){
        let alertController = UIAlertController(title: "Opps🙈", message: message , preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signUp" {
            let vc = segue.destination as! ProfileVC
            vc.petNameText = petNameTextField.text!
            vc.petAgeText = ageField.text!
            vc.petType = petTypeField.text!
            vc.petGender = genderField.text!
            vc.year = yearLabel.text
            vc.month = monthLabel.text
            vc.petInfo = petInfo
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        if currentTextField == ageField {
            return 2
        }else {
            return 1
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if currentTextField == petTypeField {
            return types.count
        }else if currentTextField == genderField {
            return gender.count
        }else if currentTextField == ageField {
            if component == 0 {
                return years.count
            }else if component == 1{
                return months.count
            }
        }
            return 0
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == petTypeField {
            return types[row]
        }else if currentTextField == genderField {
            return gender[row]
        }else if currentTextField == ageField {
            if component == 0 {
                return years[row]
            }else if component == 1{
                return months[row]
            }
        }
            return ""
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextField == petTypeField {
            currentTextField.text =  types[row]
            currentTextField.resignFirstResponder()
        }else if currentTextField == genderField {
            currentTextField.text = gender[row]
            currentTextField.resignFirstResponder()
        }else if currentTextField == ageField {
            let year = "\(pickerView.selectedRow(inComponent: 0)) سنه"
            let month = "\(pickerView.selectedRow(inComponent: 1)) شهر"
            currentTextField.text = year + month
            yearLabel.text = "\(pickerView.selectedRow(inComponent: 0))"
            monthLabel.text = "\(pickerView.selectedRow(inComponent: 1))"
           }
        }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        currentTextField = textField
        if currentTextField == petTypeField {
            currentTextField.inputView = pickerView
            print(myPet.petName)
        }else if currentTextField == genderField {
            currentTextField.inputView = pickerView
        }else if currentTextField == ageField {
            currentTextField.inputView = pickerView
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
    func validateTheFields() -> String? {
        if  confirmPasswordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            petTypeField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""     ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            genderField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            ageField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            petNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            ownerNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "املاء جميع الفراغات"
        }
        return nil
    }
    func getData() {
        guard let userID = Auth.auth().currentUser?.uid else {
            fatalError("this user doesnt exist")
        }
        Networking.getSingleDocument("users/\(userID)", success: { (userInfo: User) in
            DispatchQueue.main.async {
                self.petInfo = userInfo
                print("\(userID)🚀")
                print(self.petInfo)
//                self.displayingData()
                self.performSegue(withIdentifier: "signUp", sender: self)
            }
            
        }) { (err) in
            print(err)
        }
    }
}

//class SignUpVC: UIViewController {
//    @IBOutlet weak var firstNameField: UITextField!
//    @IBOutlet weak var lastNameField: UITextField!
//    @IBOutlet weak var phoneNumberField: UITextField!
//    @IBOutlet weak var emailField: UITextField!
//    @IBOutlet weak var passwordField: UITextField!
//    @IBOutlet weak var conformPasswordField: UITextField!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//
//    @IBAction func signUp(){
//        let email = emailField.text!
//        let password = passwordField.text!
//        let conformPassword = conformPasswordField.text!
//        let firstName = firstNameField.text!
//        let lastName = lastNameField.text!
//        let phoneNumber = phoneNumberField.text!
//
//        // You can use another User Struct as you wish
//        let user = User(firstName: firstName,
//                        lastName: lastName,
//                        email: email,
//                        phoneNumber: phoneNumber)
//
//        if validatePassword(password: password, conformPassword: conformPassword){
//            Networking.signUp(user: user, password: password, success:  { uid in
//                // ✅ Success
//                print("You have signed up successfully")
//                self.performSegue(withIdentifier: "signed", sender: nil)
//            }){
//                // ❌ Failed
//                self.errorMessage(message: "Couldn't sign in, make sure the email and password are correct")
//            }
//        }
//        else{
//            errorMessage(message: "Password are not matching!")
//        }
//    }
//
//    func validatePassword(password: String, conformPassword: String) -> Bool{
//        return password == conformPassword
//    }
//
//    func errorMessage(message: String){
//        let alertController = UIAlertController(title: "Opps🙈", message: message , preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "Ok", style: .cancel)
//        alertController.addAction(okAction)
//        present(alertController, animated: true)
//    }
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}


