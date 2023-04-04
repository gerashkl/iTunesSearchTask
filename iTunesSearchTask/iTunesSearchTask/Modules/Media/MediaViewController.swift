//
//  MediaViewController.swift
//  iTunesSearchTask
//
//  Created by Illia Marchenko on 31.03.2023.
//

import UIKit

class MediaViewController: UIViewController {
    
    @IBOutlet weak var mediaSearchBar: UISearchBar!
    @IBOutlet weak var mediaTableView: UITableView!
    
    var searchMediaUrl=""

    var mainMediaDataList: [Results] = []
    var searchDelayer: Timer!
    var searchTextRename = ""
    
//    let viewModel = MediaViewControllerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSearchMovies(url: searchMediaUrl)
        setapInterfase()
    }
    
    //MARK:- Private func
    private func setapInterfase(){
        let stringCellIdentifire = String(describing: mediaTableViewCell.self)
        let cellNib = UINib(nibName: stringCellIdentifire, bundle: nil)
        mediaTableView.register(cellNib, forCellReuseIdentifier: stringCellIdentifire)
    }
  

}


//MARK: - UITableView
extension MediaViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ mediaTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainMediaDataList.count
    }
    
    func tableView(_ mediaTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = mediaTableView.dequeueReusableCell(withIdentifier:String(describing: mediaTableViewCell.self)) as? mediaTableViewCell{
            cell.configure(with: mainMediaDataList[indexPath.row])
            cell.configureInterfaceSetting()
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ mediaTableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detalisViewController = storyboard.instantiateViewController(withIdentifier:String(describing: DetalisViewController.self)) as? DetalisViewController{
            detalisViewController.mediaDetalis = mainMediaDataList[indexPath.row]
            navigationController?.pushViewController(detalisViewController, animated: true)
        }
    }
}

//MARK: - SearchBarDelegate

extension MediaViewController:UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTextRename = searchText
        searchDelayer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { searchDelayer in
            guard self.searchTextRename != searchText else
            {
                self.searchMediaUrl = Const.bildSearchMovieUrl(SearchText: searchText)
                self.loadSearchMovies(url:self.searchMediaUrl)
                return
            }
        })
    }
}
