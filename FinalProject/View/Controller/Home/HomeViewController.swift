//
//  HomeViewController.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/7/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties
    var viewModel: HomeViewModel = HomeViewModel()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configTableView()
        configNavigation()
        loadAPI()
    }

    // MARK: - Private functions
    private func setupUI() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "cloudBackground")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill

        tableView.backgroundColor = UIColor.clear
        self.view.insertSubview(backgroundImage, at: 0)
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }

    private func configNavigation() {
        title = "Da Nang"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.backgroundColor = .clear

        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        navigationItem.rightBarButtonItem = addItem
        addItem.tintColor = .white

        let item = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = item
        item.tintColor = .white
    }

    private func configTableView() {
        let nib = UINib(nibName: "HomeTableViewCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "HomeTableViewCell")

        let nibForecast = UINib(nibName: "ForecastTableViewCell", bundle: .main)
        tableView.register(nibForecast, forCellReuseIdentifier: "ForecastTableViewCell")

        let nibAmount = UINib(nibName: "AmountOfRainTableViewCell", bundle: .main)
        tableView.register(nibAmount, forCellReuseIdentifier: "AmountOfRainTableViewCell")

        let nibDetail = UINib(nibName: "DetailTableViewCell", bundle: .main)
        tableView.register(nibDetail, forCellReuseIdentifier: "DetailTableViewCell")

        tableView.dataSource = self
        tableView.delegate = self
    }

    private func updateUI() {
        tableView.reloadData()
    }

    private func loadAPI() {
        HUD.show()
        let group = DispatchGroup()
        group.enter()
        loadWeather {
            group.leave()
        }
        group.enter()
        loadMainApi {
            group.leave()
        }
        group.notify(queue: .main, execute: { [weak self] in
            HUD.dismiss()
            self?.tableView.reloadData()
        })
    }

    private func loadWeather(completion: @escaping () -> Void) {
        viewModel.getDataWeather { [weak self] result in
            guard let this = self else {
                completion()
                return
            }
            DispatchQueue.main.async {
                switch result {
                case .success:
                    break
                case .failure(let error):
                    this.alert(msg: error.localizedDescription, handler: nil)
                }
                completion()
            }
        }
    }

    private func loadMainApi(completion: @escaping () -> Void) {
        viewModel.getDataMain { [weak self] result in
            guard let this = self else {
                completion()
                return
            }
            DispatchQueue.main.async {
                switch result {
                case.success:
                    break
                case .failure(let error):
                    this.alert(msg: error.localizedDescription, handler: nil)
                }
                completion()
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = HomeViewModel.TypeCell(rawValue: indexPath.row)
        switch type {
        case .homeCell:
            guard let homeCell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
            homeCell.viewModel = viewModel.viewModelForHomeCell(indexPath: indexPath)
            return homeCell
        case .forecastCell:
            guard let forecastCell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell", for: indexPath) as? ForecastTableViewCell else { return UITableViewCell() }
            forecastCell.viewModel = viewModel.viewModelForForecastCell(indexPath: indexPath)
            return forecastCell
        case .amountOfRainCell:
            guard let amountCell = tableView.dequeueReusableCell(withIdentifier: "AmountOfRainTableViewCell", for: indexPath) as? AmountOfRainTableViewCell else { return UITableViewCell() }
            return amountCell
        case .detailCell:
            guard let cellDetail = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as? DetailTableViewCell else { return UITableViewCell() }
            return cellDetail
        default: break
        }
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightcell(at: indexPath)
    }
}
