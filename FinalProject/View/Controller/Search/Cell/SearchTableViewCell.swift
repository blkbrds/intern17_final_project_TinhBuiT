//
//  SearchTableViewCell.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/30/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import UIKit
import RealmSwift

protocol SearchTableViewCellDelegate: class {
    func searchView(view: SearchTableViewCell, needsPerfom actions: SearchTableViewCell.Action)
}

final class SearchTableViewCell: UITableViewCell {

    enum Action {
        case save
        case delete
    }

    // MARK: - IBOutlets
    @IBOutlet private weak var imageEnsign: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!

    // MARK: - Properties
    var viewModel: SearchTableViewCellViewModel? {
        didSet {
            updateViews()
        }
    }

    weak var delegate: SearchTableViewCellDelegate?

    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageEnsign.image = nil
    }

    // MARK: - IBActions
    @IBAction func chooseTochUpInside(_ sender: UIButton) {
        guard let viewModel = viewModel else { return }
        if viewModel.isFavorite {
            delegate?.searchView(view: self, needsPerfom: .delete)
        } else {
            delegate?.searchView(view: self, needsPerfom: .save)
        }
    }

    private func updateViews() {
        guard let viewModel = viewModel, let search = viewModel.search else { return }
        if viewModel.isFavorite {
            favoriteButton.setImage(UIImage(named: "starchoose"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "star"), for: .normal)
        }

        if let cou = search.country {
            let couLow = cou.lowercased()
            nameLabel.text = viewModel.getName()
            WeatherService.loadImageByCountry(couLow) { [weak self](result) in
                guard let this = self else { return }
                switch result {
                case .success(let image):
                    this.imageEnsign.image = image
                case .failure(_):
                    break
                }
            }
        }
    }
}
