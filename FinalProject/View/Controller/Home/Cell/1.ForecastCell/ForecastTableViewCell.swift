//
//  ForecastTableViewCell.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/15/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import UIKit

final class ForecastTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties
    var viewModel: ForecastCellViewModel? {
        didSet {
            collectionView.reloadData()
            tableView.reloadData()
        }
    }
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
        configTableView()
    }

    // MARK: - Private functions
    private func configCollectionView() {
        let nib = UINib(nibName: "ForecastCollectionViewCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: "ForecastCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func configTableView() {
        let nib = UINib(nibName: "ForecastDayTableViewCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "ForecastDayTableViewCell")
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension ForecastTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 45, height: 70)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCollectionViewCell", for: indexPath) as? ForecastCollectionViewCell else { return UICollectionViewCell() }
        cell.viewModel = viewModel?.viewModelForCollectin(at: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ForecastTableViewCell: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastDayTableViewCell", for: indexPath) as? ForecastDayTableViewCell,
              let viewModel = viewModel else { return UITableViewCell() }
        cell.viewModel = viewModel.viewModelForForecastDayTableCell(at: indexPath)
        return cell
    }
}
