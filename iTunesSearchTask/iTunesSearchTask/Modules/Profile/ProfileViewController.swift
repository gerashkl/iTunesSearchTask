import UIKit
import Firebase
import FirebaseStorage

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileNameLabel: UILabel!
    
    @IBOutlet weak var profileEmailLabel: UILabel!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var LogOutButton: UIButton!
    
    private let storege  = Storage.storage().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePictureImageView.contentMode = .scaleAspectFit
        profilePictureImageView.layer.cornerRadius = 150
        profilePictureImageView.clipsToBounds
        LogOutButton.layer.cornerRadius = 20
    }

    @IBAction func uploadPhotoButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    @IBAction func logOutButton(_ sender: UIButton) {
        do{
            try Auth.auth().signOut()
        } catch{
            print(error)
        }      
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
            return
        }
        profilePictureImageView.image = image
        
//        guard let imageData = image.pngData() else{
//            return
//        }
////        let ref = storege.child("images/file.png")
//        storege.child("images/file.png").putData(imageData, metadata: nil,complection: { storageMetadata, error? in
//            guard error == nil else{
//                print("Failed upload")
//                return
//            }
//            storege.child("images/file.png").downloadURL { url, error in
//                guard let url, error == nil else{
//                    return
//                }
//                let urlString = url.absoluteString
//                print(urlString) /////
//                UserDefaults.standard.set(urlString)
//            }
//        }
        //upload image
    }
   
    
     func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
         picker.dismiss(animated: true)
}
    
}

