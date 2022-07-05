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
        loadMainApi()
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
        title = viewModel.name
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.backgroundColor = .clear
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(searchAction))
        navigationItem.rightBarButtonItem = addItem
        addItem.tintColor = .white

        let item = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: nil )
        navigationItem.leftBarButtonItem = item
        item.tintColor = .white

        let backButton = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(back))
        backButton.tintColor = .white
        if viewModel.isFromSearch {
            navigationItem.rightBarButtonItem = nil
            navigationItem.leftBarButtonItem = backButton
        }
    }

    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func searchAction() {
        let vc = SearchViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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

        let nibWind = UINib(nibName: "WindPressureTableViewCell", bundle: .main)
        tableView.register(nibWind, forCellReuseIdentifier: "WindPressureTableViewCell")

        let nibSun = UINib(nibName: "SunTableViewCell", bundle: .main)
        tableView.register(nibSun, forCellReuseIdentifier: "SunTableViewCell")

        let nibMap = UINib(nibName: "MapTableViewCell", bundle: .main)
        tableView.register(nibMap, forCellReuseIdentifier: "MapTableViewCell")

        tableView.dataSource = self
        tableView.delegate = self
    }

    private func updateUI() {
        tableView.reloadData()
    }

    private func loadMainApi() {
        HUD.show()
        viewModel.getDataMain { [weak self] result in
            guard let this = self else {
                return
            }
            DispatchQueue.main.async {
                switch result {
                case.success:
                    this.tableView.reloadData()
                    HUD.dismiss()
                case .failure(let error):
                    this.alert(msg: error.localizedDescription, handler: nil)
                }
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
            amountCell.viewModel = viewModel.viewModelForAmountOfRainCell(indexPath: indexPath)
            return amountCell
        case .detailCell:
            guard let cellDetail = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as? DetailTableViewCell else { return UITableViewCell() }
            cellDetail.viewModel = viewModel.viewModelForDetailCell(indexPath: indexPath)
            return cellDetail
        case.windCell :
            guard let cellWind = tableView.dequeueReusableCell(withIdentifier: "WindPressureTableViewCell", for: indexPath) as? WindPressureTableViewCell else { return UITableViewCell() }
            cellWind.viewModel = viewModel.viewModelForWindPresureCell(indexPath: indexPath)
            return cellWind
        case.sunCell:
            guard let cellSun = tableView.dequeueReusableCell(withIdentifier: "SunTableViewCell", for: indexPath) as? SunTableViewCell else { return UITableViewCell() }
            cellSun.viewModel = viewModel.viewModelForSunCell(indexPath: indexPath)
            return cellSun
        case.mapCell:
            guard let cellMap = tableView.dequeueReusableCell(withIdentifier: "MapTableViewCell", for: indexPath) as? MapTableViewCell else { return UITableViewCell() }
            cellMap.viewModel = viewModel.viewModelForMapCell(indexPath: indexPath)
            return cellMap
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
