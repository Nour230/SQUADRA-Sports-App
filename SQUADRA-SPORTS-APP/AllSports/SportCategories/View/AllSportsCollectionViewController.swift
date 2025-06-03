//
//  AllSportsCollectionViewController.swift
//  SQUADRA-SPORTS-APP
//
//  Created by nourhan essam on 30/05/2025.
//

import UIKit

private let reuseIdentifier = "Cell"

protocol AllSportsProtocol{
   func displaySports(sports: [AllSportsModel])
}

class AllSportsCollectionViewController: UICollectionViewController ,UICollectionViewDelegateFlowLayout , AllSportsProtocol{
    
    var sportsPresenter : AllSportsPresenter!
    var sportsData : [AllSportsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        navigationItem.title = "AllSports"
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        let nib = UINib(nibName:"CollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier:"sportsCell")
        // Do any additional setup after loading the view.
        
         sportsPresenter = AllSportsPresenter(allSportsViewController: self)
        sportsPresenter.sendAllSportsCategories()
    }
    
    func displaySports(sports: [AllSportsModel]) {
        sportsData = sports
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 15
        let inset: CGFloat = 25
        let itemsPerRow: CGFloat = 2

        let totalSpacing = spacing + inset * 2
        let width = (collectionView.bounds.width - totalSpacing) / itemsPerRow
        return CGSize(width: width, height: 220)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        // Default horizontal padding (will center horizontally)
        return UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let cellHeight: CGFloat = 350
        let lineSpacing: CGFloat = 20
        let numberOfRows: CGFloat = 2

        let totalHeight = (cellHeight * numberOfRows) + lineSpacing
        let verticalInset = max((collectionView.bounds.height - totalHeight) / 2, 0)

        collectionView.contentInset = UIEdgeInsets(top: verticalInset, left: 0, bottom: 0, right: 0)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return sportsData.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportsCell", for: indexPath) as! CollectionViewCell
        cell.sportsName.text = sportsData[indexPath.row].name!
        cell.sportsImageView.image = UIImage(named: sportsData[indexPath.row].img!)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let leaguesStoryboard = UIStoryboard(name: "Leagues", bundle: nil)
        if let leaguesTableVC = leaguesStoryboard.instantiateViewController(withIdentifier: "Leagues") as? LeaguesTableViewController {
            
            guard let name = sportsData[indexPath.row].name else { return }
            let sportName = name.lowercased()
            let leaguesPresenter = LeaguesPresenter(leaguesTableView: leaguesTableVC, sportName: sportName)
            leaguesTableVC.leaguesPresenter = leaguesPresenter
            
            NetworkManager.isInternetAvailable{ isConnected in
                DispatchQueue.main.async {
                    if isConnected {
                        self.navigationController?.pushViewController(leaguesTableVC, animated: true)
                    } else {
                        let alert = UIAlertController(
                            title: "No Internet Connection",
                            message: "Check Your Internet Connection!",
                            preferredStyle: .alert
                        )
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                        self.present(alert, animated: true)
                    }
                }
            }
        }
    }




    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
