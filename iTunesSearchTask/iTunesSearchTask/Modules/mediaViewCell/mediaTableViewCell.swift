
import UIKit
import SDWebImage

class mediaTableViewCell: UITableViewCell {

    @IBOutlet weak var titleMediaLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var shortDescriptionMediaCellLabel: UILabel!
    @IBOutlet weak var countryMediaCellLabel: UILabel!
    @IBOutlet weak var generesMediaCellLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
 
    func configure (with moviesFound: Results){
        self.titleMediaLabel.text = moviesFound.trackName
        self.generesMediaCellLabel.text = moviesFound.primaryGenreName
        self.releaseDateLabel.text = convertDateFormat(inputDate: moviesFound.releaseDate)
        self.countryMediaCellLabel.text = moviesFound.country
        self.shortDescriptionMediaCellLabel.text = moviesFound.shortDescription
        setBackdropVideo(imgPath: moviesFound.artworkUrl30)
    }
    func configure (with favoriteMediaList: FavoritesRealm){
        self.titleMediaLabel.text = favoriteMediaList.title
        self.generesMediaCellLabel.text = favoriteMediaList.generes
        self.releaseDateLabel.text = convertDateFormat(inputDate: favoriteMediaList.releaseDate)
        self.countryMediaCellLabel.text = favoriteMediaList.country
        self.shortDescriptionMediaCellLabel.text = favoriteMediaList.shortDescription
        setBackdropVideo(imgPath: favoriteMediaList.artworkUrl)
   }
    
    //MARK: - configure suppot func
    func configureInterfaceSetting (){
        posterImageView.layer.cornerRadius = 5
        backgroundColor = .gray

    }
   
    private  func setBackdropVideo(imgPath: String?){
        guard let imgPath = imgPath else{return}
        let imgUrlString = imgPath.replacingOccurrences(of: "30x30bb", with: "400x400bb") //винести окремо
        let imgUrl = URL(string: imgUrlString)
        self.posterImageView.sd_setImage(with: imgUrl)
    }
    
}
func convertDateFormat(inputDate: String?) -> String {
    guard let inputDate = inputDate else{return "date unknown"
    }
     let olDateFormatter = DateFormatter()
     olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:SS'Z'"
     let oldDate = olDateFormatter.date(from: inputDate)
     let convertDateFormatter = DateFormatter()
     convertDateFormatter.dateFormat = "MMM yyyy"
     return convertDateFormatter.string(from: oldDate!)
}

