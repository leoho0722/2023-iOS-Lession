//
//  MainViewController.swift
//  CallAPIExample
//
//  Created by Leo Ho on 2023/2/3.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var aqiTableView: UITableView!
    
    // MARK: - Variables
    
    var aqiArray: [AQIResponse.Records] = []
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        hideKeyboardWhenTapped()
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
        setupTableView()
        setupTextField()
        setupButton()
    }
    
    private func setupTableView() {
        aqiTableView.delegate = self
        aqiTableView.dataSource = self
        aqiTableView.register(UINib(nibName: "AQITableViewCell", bundle: nil),
                              forCellReuseIdentifier: AQITableViewCell.identifier)
    }
    
    private func setupTextField() {
        numberTextField.placeholder = "請輸入要查詢的筆數"
        numberTextField.keyboardType = .numberPad
        numberTextField.text = UserPreferences.shared.lastSearchNum
    }
    
    private func setupButton() {
        searchButton.setTitle("開始查詢", for: .normal)
    }
    
    // MARK: - IBAction
 
    @IBAction func searchBtnClicked(_ sender: UIButton) {
        guard let text = numberTextField.text, !text.isEmpty else {
            return
        }
        UserPreferences.shared.lastSearchNum = text
        NetworkManager.shared.requestData(limit: text.toInt()) { (response: ResponseResult<AQIResponse>) in
            switch response {
            case .success(let results):
                print(results.records)
                self.aqiArray = results.records
                
                DispatchQueue.main.async {
                    self.aqiTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    // UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aqiArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AQITableViewCell.identifier,
                                                       for: indexPath) as? AQITableViewCell else {
            fatalError("AQITableViewCell Load Failed！")
        }
        
        cell.setInit(county: aqiArray[indexPath.row].county,
                     status: aqiArray[indexPath.row].status,
                     aqi: aqiArray[indexPath.row].aqi.toInt())
        
        return cell
    }
    
    // UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let nextVC = DetailViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}

// MARK: - Protocol


