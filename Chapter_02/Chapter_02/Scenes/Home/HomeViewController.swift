//
//  HomeViewController.swift
//  Chapter_02
//
//  Created by Lam Trinh Tran Truc on 02-December-2021.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    private let disposeBag = DisposeBag()
    var viewModel: HomeViewModel!

    init(useCase: HomeUseCase) {
        viewModel = HomeViewModel(useCase: useCase)
        super.init(nibName: "HomeViewController", bundle: .main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bindViewModel()
    }

    private func configureTableView() {
        let weatherTableViewCellNib = UINib(nibName: "WeatherTableViewCell", bundle: nil)
        tableView.register(weatherTableViewCellNib, forCellReuseIdentifier: WeatherTableViewCell.reuseID)
        tableView.refreshControl = UIRefreshControl()
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
    }

    private func bindViewModel() {
        let input = HomeViewModel.Input(searchWeather: searchBar.rx.searchButtonClicked.asDriver(),
                                        city: searchBar.searchTextField.rx.text.orEmpty.asDriver())
        let output = viewModel.transform(input: input)
//        output.weather.drive().disposed(by: disposeBag)
        output.weather.drive(tableView.rx.items(cellIdentifier: WeatherTableViewCell.reuseID, cellType: WeatherTableViewCell.self)) { tableView, data, cell in
            cell.bind(data)
        }.disposed(by: disposeBag)
    }
}
