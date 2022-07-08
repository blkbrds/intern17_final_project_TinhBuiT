//
//  AmountOfRainTableViewCell.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/15/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import UIKit

final class AmountOfRainTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    let widthCell = UIScreen.main.bounds.width

    // MARK: - Properties
    var viewModel: AmountOfRainViewModel? {
        didSet {
            collectionView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
    }

    // MARK: - Private functions
    private func configCollectionView() {
        let nib = UINib(nibName: "CollectionViewCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}
// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension AmountOfRainTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: widthCell / 5, height: 140)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        cell.viewModel = viewModel?.viewModelForAmountCollectionView(at: indexPath)
        return cell
    }
}
