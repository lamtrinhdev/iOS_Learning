//
//  ActivityIndicatorViewController.swift
//  Weather
//
//  Created by Lam Trinh Tran Truc on 19-November-2021.
//

import UIKit

class ActivityIndicatorViewController: UIViewController {
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        loadingActivityIndicator.hidesWhenStopped = true
    }

    func startLoading() {
        loadingActivityIndicator.startAnimating()
    }

    func stopLoading() {
        loadingActivityIndicator.stopAnimating()
    }
}
