//
//  ViewController.swift
//  NGUIViewControllerAnimatedDismissFalseExample
//
//  Created by Noah Gilmore on 5/6/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import UIKit

protocol PresentedViewControllerDelegate: AnyObject {
    func presentedViewControllerDidTapDone()
}

class PresentedViewController: UIViewController {
    weak var delegate: PresentedViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDone(_:)))
        self.navigationItem.rightBarButtonItem = button
    }

    @objc private func didTapDone(_ sender: UIBarButtonItem) {
        delegate?.presentedViewControllerDidTapDone()
    }
}

class ViewController: UIViewController {
    private let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        button.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        button.setTitleColor(.green, for: .normal)
        button.setTitle("Present", for: .normal)
        button.addTarget(self, action: #selector(buttonWasTapped(_:)), for: .touchUpInside)
    }

    @objc private func buttonWasTapped(_ sender: UIButton) {
        self.presentNewViewController()
    }

    func presentNewViewController() {
        let controller = PresentedViewController()
        controller.delegate = self
        let navigationController = UINavigationController(rootViewController: controller)
        self.present(navigationController, animated: true, completion: nil)
    }
}

extension ViewController: PresentedViewControllerDelegate {
    func presentedViewControllerDidTapDone() {
        self.dismiss(animated: true, completion: nil)
        self.presentNewViewController()
    }
}

