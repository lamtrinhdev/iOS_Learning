//
//  BaseViewController.swift
//  Weather
//
//  Created by Lam Trinh Tran Truc on 19-November-2021.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    private let viewModel: BaseViewModel
    private let loadingVC = ActivityIndicatorViewController()
    let disposeBag = DisposeBag()

    init(nibName: String? = nil, viewModel: BaseViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nibName, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseUI()
        bindingBaseData()
    }

    private func setupBaseUI() {
        loadingVC.modalTransitionStyle      = .crossDissolve
        loadingVC.modalPresentationStyle    = .overFullScreen
    }

    // Common Alert with OK Button only.
    func showAlertWithOKButton(message: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + kSearchDelayTimeForShowingMessage) { [weak self] in
            guard let self = self else { return }
            let alertVC = UIAlertController(
                title: NSLocalizedString("kBaseViewControllerErrorAlertTitle", comment: "Alert Title"),
                message: message,
                preferredStyle: .alert)

            // Init OK Action and Add OK Action to AlertVC.
            alertVC
                .addAction(
                UIAlertAction(
                    title: NSLocalizedString("kBaseViewControllerOkayButtonTitle", comment: "OK Button Title"),
                    style: .default,
                    handler: nil))
            // Present AlertVC.
            self.present(alertVC, animated: true, completion: nil)
        }
    }

    private func bindingBaseData() {
        viewModel
            .errorData
            .subscribe(onNext: {[weak self] errorMessage in
                guard let self = self, let errorMessage = errorMessage else { return }
                self.showAlertWithOKButton(message: errorMessage)
            })
            .disposed(by: disposeBag)

        viewModel
            .showLoading
            .subscribe(onNext: {[weak self] isShowing in
                guard let self = self, let isShowing = isShowing else { return }
                self.showLoading(isShowing: isShowing)
            })
            .disposed(by: disposeBag)
    }

    private func showLoading(isShowing: Bool) {
        if isShowing {
            self.present(loadingVC, animated: true, completion: nil)
            self.loadingVC.startLoading()
        } else {
            loadingVC.stopLoading()
            loadingVC.dismiss(animated: true, completion: nil)
        }
    }

}
