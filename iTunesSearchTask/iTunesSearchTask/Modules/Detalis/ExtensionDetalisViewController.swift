import UIKit
import Foundation

extension DetalisViewController {
    func configureVC (){
        guard let mediaDetalis = mediaDetalis else {return}
        titleDetalisLabel.text = mediaDetalis.trackName
        generesDetalisLabel.text = mediaDetalis.primaryGenreName
        countryDetaliLabel.text = mediaDetalis.country
        longDescriptionDetalisLabel.text = mediaDetalis.longDescription
        releaseDateDetalisLabel.text = convertDateFormat(inputDate: mediaDetalis.releaseDate)
        saveMediaButton.setTitle("Save", for: .normal)
        DetalisViewControllerUI()
    }

    func configureSavedMediaVC () {
        guard let savedMediaDetalis = savedMediaDetalis else {return}

        titleDetalisLabel.text = savedMediaDetalis.title
        generesDetalisLabel.text = savedMediaDetalis.generes
        countryDetaliLabel.text = savedMediaDetalis.country
        longDescriptionDetalisLabel.text = savedMediaDetalis.longDescription
        releaseDateDetalisLabel.text = convertDateFormat(inputDate: savedMediaDetalis.releaseDate)
        saveMediaButton.setTitle("Remove", for: .normal)
        DetalisViewControllerUI()
    }
    func DetalisViewControllerUI(){
        saveMediaButton.layer.cornerRadius = 20
    }
    
    
//    //MARK: - buttomAllertAction

    func buttomAllertAction (actionCase: Const.actionCase){
        let saveMediaButtonPresedAlert = viewModel.createAlertController(actionCase: actionCase, titleMovie: titleDetalisLabel.text)

        switch actionCase{
        case .mediaInRealm : do {
            let canselAction = UIAlertAction(title:"Got it", style: .cancel)
            saveMediaButtonPresedAlert.addAction(canselAction)
            present(saveMediaButtonPresedAlert, animated: true)
            return
        }
        case .needSaveInRealm : do {
            let saveAction = UIAlertAction(title: "Save", style: .default) {action in
                DataManager.shared.saveDataToRealm(moviesList: self.mediaDetalis )
            }
            let canselAction = UIAlertAction(title:"Cancel", style: .cancel)
            saveMediaButtonPresedAlert.addAction(saveAction)
            saveMediaButtonPresedAlert.addAction(canselAction)
            present(saveMediaButtonPresedAlert, animated: true)
        }

        case Const.actionCase.needRemoveFromRealm : do {
            guard let savedMediaDetalis = savedMediaDetalis else{ return }

            let delateAction = UIAlertAction(title: "Remove", style: .default) {action in
                DataManager.shared.deleteWathLaterList(item: savedMediaDetalis)
                //need close the View after this event
            }
            let canselAction = UIAlertAction(title:"Cancel", style: .cancel)
            saveMediaButtonPresedAlert.addAction(delateAction)
            saveMediaButtonPresedAlert.addAction(canselAction)
            present(saveMediaButtonPresedAlert, animated: true)
        }
        }
    }
}



