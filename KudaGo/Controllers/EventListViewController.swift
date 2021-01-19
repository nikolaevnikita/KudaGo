//
//  EventListViewController.swift
//  KudaGo
//
//  Created by Николаев Никита on 13.01.2021.
//

import UIKit

class EventListViewController: UICollectionViewController {
    private var events: [Event]?
    private var currentPage = 1
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPageOfEvents()
    }
    
    // MARK: Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segues.toDetail {
            guard let detailVC = segue.destination as? DetailEventViewController,
                  let selectedItem = collectionView.indexPathsForSelectedItems?.first?.row,
                  let selectedEvent = events?[selectedItem] else { return }
            detailVC.event = selectedEvent
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let id = Constants.ReuseIdentificators.collectionCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as! EventListCell
        guard let curentEvent = events?[indexPath.row] else { return cell }
        cell.setup(by: curentEvent)
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let events = events else { return }
        if indexPath.row == events.count - 1 {
            getNextEvents()
        }
    }

    // MARK: Fetch Data
    
    private func getPageOfEvents() {
        NetworkManager.shared.fetchEvents(for: currentPage) { result in
            switch result {
            case .success(let data): self.updateEventList(data)
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
    
    private func getNextEvents() {
        currentPage += 1
        getPageOfEvents()
    }
    
    private func updateEventList(_ data: [Event]) {
        guard let eventsArray = events else {
            events = data
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            return
        }
        var indexPaths = [IndexPath]()
        for item in 0..<Constants.API.pageSize {
            let indexPath = IndexPath(row: item + eventsArray.count, section: 0)
            indexPaths.append(indexPath)
        }
        events! += data
        DispatchQueue.main.async {
            self.collectionView.insertItems(at: indexPaths)
        }
    }
}

// MARK: - FlowLayout

extension EventListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow = Constants.CollectionViewSettings.itemsPerRow
        let inset = Constants.CollectionViewSettings.inset
        let paddingWidth = inset * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        let heightPerItem = Constants.CollectionViewSettings.cellAspectRatio * widthPerItem
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset = Constants.CollectionViewSettings.inset
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.CollectionViewSettings.inset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.CollectionViewSettings.inset
    }
}
