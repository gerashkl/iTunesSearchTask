import Foundation
import UIKit


struct DetalisViewControllerViewModel{
    var mediaTaitle = ""

    func createAlertController(actionCase: Const.actionCase,titleMovie:String?)->UIAlertController{
        let titleMovie = titleMovie ?? "No name Media"
        switch actionCase{
        case .mediaInRealm : do {
             let itemInRealm = UIAlertController(title: "Oops", message: "'\(titleMovie)' is already saved", preferredStyle: .alert)
            return itemInRealm
        }
        case .needSaveInRealm:
            let saveMediaButtonPressed = UIAlertController(title: "Save", message: "Do you want to save '\(titleMovie)' to favorites list?", preferredStyle: .alert)
            return saveMediaButtonPressed
        case .needRemoveFromRealm:
            let delateMediaButtonPressed = UIAlertController(title: "Remove", message: "Do you want to remove '\(titleMovie)' from your favorites list?", preferredStyle: .alert)
            return delateMediaButtonPressed
        }
    }

}

