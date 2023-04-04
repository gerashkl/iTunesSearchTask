import Foundation
import RealmSwift

struct DataManager {
    let realm = try? Realm()
    static let shared = DataManager()
    
    func saveDataToRealm(moviesList: Results?){
        guard moviesList != nil else{return}
        let favoritesListRealm :FavoritesRealm  = FavoritesRealm()
        favoritesListRealm.title = moviesList?.trackName ?? ""
        favoritesListRealm.releaseDate = moviesList?.releaseDate ?? ""
        favoritesListRealm.country = moviesList?.country ?? ""
        favoritesListRealm.generes = moviesList?.primaryGenreName ?? "information available"
        favoritesListRealm.shortDescription = moviesList?.shortDescription ?? moviesList?.longDescription ?? "information available"
        favoritesListRealm.longDescription = moviesList?.longDescription ?? moviesList?.shortDescription ?? "information available"
        favoritesListRealm.artworkUrl = moviesList?.artworkUrl30 ?? ""
        favoritesListRealm.previewUrl = moviesList?.previewUrl ?? ""
        try? realm?.write {
            realm?.add(favoritesListRealm)
        }        
    }

    func getWathLaterList() ->[FavoritesRealm] {
        var moviesFromRealm :[FavoritesRealm] = []
        guard let movieResults = realm?.objects(FavoritesRealm.self) else{return []}
        for movie in movieResults {
            moviesFromRealm.append(movie)
        }
        return moviesFromRealm
    }

    func deleteWathLaterList(item: FavoritesRealm){
        do{
            try realm?.write({
                realm?.delete(item)
            })
        }
        catch{
            print("error when deleting data")
        }
    }

    static func checkItemInRealm(trackName: String) -> Bool{
        let savedMediaList = DataManager.shared.getWathLaterList()
        var itemInRealm:Bool = false
        for (item) in savedMediaList{
            if trackName == item.title {itemInRealm = true }
        }
        return itemInRealm
    }
}
