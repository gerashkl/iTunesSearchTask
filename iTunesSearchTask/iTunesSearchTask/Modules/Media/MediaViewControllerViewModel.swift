//
//  MediaViewControllerViewModel.swift
//  iTunesSearchTask
//
//  Created by Illia Marchenko on 02.04.2023.
//
import UIKit
import Foundation
import Alamofire

extension MediaViewController {
    
    func loadSearchMovies (url:String) {
        
        MediaViewControllerViewModel.NetworkManager().loadMedia(url: url){ mediaArrey in
            self.mainMediaDataList = mediaArrey
            self.mediaTableView.reloadData()
        }
    }
   
}


struct MediaViewControllerViewModel {

    struct NetworkManager  {
        
        func loadMedia(url: String, completition: @escaping([Results])->()){
            AF.request(url,method: .get).responseDecodable(of: Media.self){ TrendingResponse in
                let allData = TrendingResponse.value
                completition(allData?.results ?? [])
            }
        }

    }
}

