import UIKit
import AVKit


class DetalisViewController: UIViewController {

    @IBOutlet weak var titleDetalisLabel: UILabel!
    @IBOutlet weak var releaseDateDetalisLabel: UILabel!
    @IBOutlet weak var countryDetaliLabel: UILabel!
    @IBOutlet weak var generesDetalisLabel: UILabel!
    @IBOutlet weak var prevuewPlayerView: UIView!
    @IBOutlet weak var longDescriptionDetalisLabel: UILabel!
    @IBOutlet weak var saveMediaButton: UIButton!
    
    var mediaDetalis : Results?
    var savedMediaDetalis: FavoritesRealm?
    var videoURLString = ""
    var playerLayer = AVPlayerLayer()
    var player = AVPlayer()
    var viewModel = DetalisViewControllerViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureVC()
        self.configureSavedMediaVC()
        loadTrailer(previewUrl: mediaDetalis?.previewUrl ?? savedMediaDetalis?.previewUrl ?? Const.Request.errorMovieURL) // переробити
    }
    
    override func viewWillAppear(_ animated: Bool) {
        playerPlay()
    }
    override func viewWillDisappear(_ animated: Bool) {
        playerPause()
    }
    
    private func loadTrailer(previewUrl:String) {
        guard let videoURL = URL(string: previewUrl ) else {
            return
        }
        player = AVPlayer(url: videoURL)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = prevuewPlayerView.bounds
        playerLayer.videoGravity = .resizeAspectFill
        prevuewPlayerView.layer.addSublayer(playerLayer)
        player.play()
        
        }
    private func playerPause(){
        player.pause()
    }
    private func playerPlay(){
        player.play()
    }
        
    @IBAction func saveMediaButtonPressed(_ sender: Any) {
        saveMediaButtonPressed ()
        delateMediaButtonPressed ()
    }
    
    //MARK: - func saveMediaButtonPressed
    
    func saveMediaButtonPressed (){
        guard let mediaDetalis = mediaDetalis else{ return }
        if DataManager.checkItemInRealm(trackName:mediaDetalis.trackName!){
            buttomAllertAction(actionCase: Const.actionCase.mediaInRealm)
        }
        buttomAllertAction(actionCase: Const.actionCase.needSaveInRealm)
    }
    func delateMediaButtonPressed (){
        buttomAllertAction(actionCase: Const.actionCase.needRemoveFromRealm)
    }
    
}
