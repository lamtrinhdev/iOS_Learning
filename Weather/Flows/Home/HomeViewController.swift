//
//  HomeViewController.swift
//  Weather
//
//  Created by Lam Trinh Tran Truc on 19-November-2021.
//

import UIKit
import RxCocoa

class HomeViewController: BaseViewController {
    @IBOutlet private weak var searchBarView: UISearchBar!
    @IBOutlet private weak var weatherInfoTableView: UITableView!

    private let viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: self.viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        Log.debug(message: "HomeViewController: Deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindingData()
        bindingActions()
    }

    private func setupUI() {
        self.navigationItem.title = NSLocalizedString("kHomeHeaderTitle", comment: "Header Title")
        searchBarView.placeholder = NSLocalizedString("kHomeSearchBarPlaceHolder", comment: "Search Bar Hint")
        setupTableViewUI()
    }

    private func setupTableViewUI() {
        // Setup tableView.
        weatherInfoTableView.register(UITableViewCell.self, forCellReuseIdentifier: TableViewCellIdentifiers.weatherInfoTableViewCellIdentifier.rawValue)
        weatherInfoTableView.estimatedRowHeight = UITableView.automaticDimension
        weatherInfoTableView.dataSource = self
        weatherInfoTableView.delegate   = self
    }

    private func bindingData() {
        viewModel
            .weatherData
            .skip(1)
            .subscribe(onNext: { [weak self] data in
                guard let self = self else { return }
                self.weatherInfoTableView.reloadData()
            })
            .disposed(by: disposeBag)
    }

    private func bindingActions() {
        searchBarView
            .rx
            .searchButtonClicked
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.validateSearchInput(searchInput: self.searchBarView.text)
            }
            .disposed(by: disposeBag)
    }

    private func validateSearchInput(searchInput: String?) {
        // If the Search Text (City) contains at least kSearchMinimumCharacter (3 characters).
        if let searchInput = searchInput, searchInput.count >= kSearchMinimumCharacter {
            viewModel.requestWeatherInfo(city: searchInput)
        }
        // Show message when Search Text (City) contains less than kSearchMinimumCharacter (3 characters).
        else {
            let errorMessage = String(
                format: NSLocalizedString("kErrorMessageSearchCityMininumCharacters", comment: "Search under minimum characters"),
                String(kSearchMinimumCharacter))

            self.showAlertWithOKButton(message: errorMessage)
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weatherData.value?.listDaily.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.weatherInfoTableViewCellIdentifier.rawValue, for: indexPath) as UITableViewCell

        if let data = viewModel.weatherData.value?.listDaily[indexPath.row] {
            let cellInfo = String(format: NSLocalizedString("kWeatherInfoCellDisplayData", comment: "cell data"), (data.date ?? ""), (data.averageTemp ?? ""))
            cell.textLabel?.text    =  cellInfo
        } else {
            cell.textLabel?.text    = ""
        }

        return cell
    }

}
