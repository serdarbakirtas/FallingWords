//
//  BaseViewController.swift
//  FallingWords
//
//  Created by Hasan on 22.11.20.
//

import UIKit

protocol BaseView: BasePresenterView {
    func showFullScreenActivityIndicator(isShown: Bool)
}

class BaseViewController: UIViewController {
    
    private var presenter: BaseViewPresenter<BaseViewController>!
    
    lazy var fullScreenActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.backgroundColor = ColorPallet.ACCENT
        activityIndicator.color = ColorPallet.ON_ACCENT
        return activityIndicator
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        showFullScreenActivityIndicator(isShown: false)
    }
    
    func presentVC(viewController: UIViewController) {
        viewController.modalPresentationStyle = .fullScreen
        if let presentedVC = self.presentedViewController {
            presentedVC.dismiss(animated: true) {
                self.present(viewController, animated: true)
            }
        } else {
            self.present(viewController, animated: true)
        }
    }
}

extension BaseViewController: BaseView {
    
    func showAlert(title: String?, message: String?, actions: [UIAlertAction]?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        if let actions = actions {
            for action in actions {
                alert.addAction(action)
            }
        } else {
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        }
        presentVC(viewController: alert)
    }
    
    func showFullScreenActivityIndicator(isShown: Bool) {
        if isShown {
            fullScreenActivityIndicator.startAnimating()
        } else {
            fullScreenActivityIndicator.stopAnimating()
        }
    }
}
