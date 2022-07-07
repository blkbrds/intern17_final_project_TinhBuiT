//
//  HomeViewController.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/7/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties
    var viewModel: HomeViewModel = HomeViewModel()
    var customSideMenu = CustomSideMenu()
    var isShowMenu: Bool = true
    var sideMenu: UIView = {
        guard let sideMenu = UINib(nibName: "CustomSideMenu", bundle: .main).instantiate(withOwner: nil, options: nil).first as? UIView else { return UIView() }
        return sideMenu
    }()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configTableView()
        loadMainApi()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(tapGesture)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigation()
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
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

        let item = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(showSideMenu))
        navigationItem.leftBarButtonItem = item
        item.tintColor = .white
    }

    @objc private func tap() {
        if sideMenu.isHidden == false {
            isShowMenu = false
            showSideMenu()
        }
    }

    @objc private func showSideMenu() {
        view.addSubview(sideMenu)
        if isShowMenu {
            sideMenu.frame = CGRect(x: -300, y: 0, width: 300, height: UIScreen.main.bounds.height)
            UIView.animate(withDuration: 0.2, delay: 0.1, options: [], animations: {
                self.sideMenu.frame.origin.x = 0
            }, completion: nil)
            isShowMenu = false
            navigationController?.navigationBar.layer.zPosition = -1

        } else {
            UIView.animate(withDuration: 0.2, delay: 0.1, options: [], animations: {
                self.sideMenu.frame.origin.x = -300
            }, completion: nil)
            isShowMenu = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.navigationController?.navigationBar.layer.zPosition = 0

            }
        }
    }

    @objc private func searchAction() {
        let vc = SearchViewController()
        vc.delegate = self
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
            HUD.dismiss()
            guard let this = self else {
                return
            }
            DispatchQueue.main.async {
                switch result {
                case.success:
                    this.tableView.reloadData()
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

// MARK: - SearchViewControllerDelegate
extension HomeViewController: SearchViewControllerDelegate {
    func homeView(view: SearchViewController, needsPerfom actions: SearchViewController.Action) {
        switch actions {
        case .data(lat: let lats, long: let long, name: let name):
            viewModel.updateData(newlat: lats, newlong: long, newname: name)
        }
        loadMainApi()
    }
}
