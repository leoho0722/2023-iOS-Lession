//
//  DetailViewController.swift
//  CallAPIExample
//
//  Created by Leo Ho on 2023/2/3.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    
    
    // MARK: - Variables
    
    weak var delegate: DetailViewControllerDelegate?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - UI Settings
    
    func setupUI() {
        setupNavigationBarButtonItems()
    }
    
    private func setupNavigationBarButtonItems() {
        let backItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                       style: .done,
                                       target: self,
                                       action: #selector(backItemClicked))
        navigationItem.leftBarButtonItem = backItem
    }
    
    @objc func backItemClicked() {
        delegate?.changeBackgroundColor(wantChangeTo: .systemPink)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - IBAction
    
}

// MARK: - Extensions



// MARK: - Protocol

protocol DetailViewControllerDelegate: NSObjectProtocol {
    
    func changeBackgroundColor(wantChangeTo color: UIColor)
}
