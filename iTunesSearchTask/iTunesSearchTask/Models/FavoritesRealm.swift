import Foundation
import RealmSwift

class FavoritesRealm: Object {
    
    @objc dynamic var title : String = ""
    @objc dynamic var releaseDate : String = ""
    @objc dynamic var country : String = ""
    @objc dynamic var generes : String = ""
    @objc dynamic var shortDescription : String = ""
    @objc dynamic var longDescription : String = ""
    @objc dynamic var artworkUrl : String = ""
    @objc dynamic var previewUrl : String = ""

    
    override class func primaryKey() -> String? {
        "title"
    }

}
