import UIKit
import Firebase

class AuthViewController: UIViewController {
    @IBOutlet weak var authSegmentedControl: UISegmentedControl!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
        
    var authSwitcher : Const.authSwitcher = .registration
  
    override func viewDidLoad() {
        super.viewDidLoad()
        enterButton.layer.cornerRadius = 20
    }

    @IBAction func enterButton(_ sender: UIButton) {
        guard let email = emailField.text, let password = passwordField.text, !email.isEmpty, !password.isEmpty else {
            present(alertUserAuthError(authError: Const.userAuthErrorMessage.emptyField.rawValue), animated: true)
            return
        }
        authEnterButtonPresed(authType: authSwitcher)
        
        

        func authEnterButtonPresed(authType:Const.authSwitcher){ //перейменувати і зробити у VM
            if authType == .registration{
                registerUser(name: nameField.text ?? Const.unownName, email: email, password: password)
            }else{
                signInUser(email: email, password: password)
            }
        }
    }
    

    
    @IBAction func authSegmentedControl(_ sender: Any) {
        switch authSegmentedControl.selectedSegmentIndex {
        case 0:
            authSwitcher = .registration
            titleLabel.text = "Registration"
            nameField.isHidden = false
            enterButton.setTitle(String(describing:authSwitcher.self), for: .normal)
        case 1:
            authSwitcher = .login
            titleLabel.text = "Log In"
            nameField.isHidden = true
            enterButton.setTitle("Log In", for: .normal)
        default:
            break
        }
      
    }
    
}


extension AuthViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }else if
            textField == passwordField{
            enterButton
        }
        return true
    }
    
    func alertUserAuthError(authError:String) -> UIAlertController {
        print("error")
        let alert = UIAlertController(title: "Message", message: authError, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        return alert
    }
    
    
    
}

