//
//  MessageBoardViewController.swift
//  MessageBoard
//
//  Created by Leo Ho on 2023/1/17.
//

import UIKit

class MessageBoardViewController: UIViewController {
    
    @IBOutlet weak var messagePeopleLabel: UILabel!
    @IBOutlet weak var messagePeopleTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var messageTableView: UITableView!
    
    var messageArray: [Message] = []
    
    var optionsArray: [String] = ["預設", "舊到新", "新到舊"]
    
    enum SortRule {
        /// 預設的排序規則
        case `default`
        
        /// 舊到新的排序規則
        case oldToNew
        
        /// 新到舊的排序規則
        case newToOld
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    /// 設定 UI 樣式
    func setupUI() {
        setupLabel()
        setupTableView()
        setupButton()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    /// 設定 UILabel 樣式
    private func setupLabel() {
        messagePeopleLabel.text = "留言人"
        messageLabel.text = "留言內容"
    }
    
    /// 設定 UIButton 樣式
    private func setupButton() {
        sendButton.setTitle("送出", for: .normal)
        sortButton.setTitle("排序", for: .normal)
    }
    
    /// 設定 UITableView 樣式
    private func setupTableView() {
        messageTableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil),
                                  forCellReuseIdentifier: MessageTableViewCell.identifier)
        messageTableView.dataSource = self
        messageTableView.delegate = self
    }
    
    /// 關鍵盤
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
    
    /// 顯示 Alert
    /// - Parameters:
    ///   - title: Alert 的標題
    ///   - message: Alert 的訊息
    ///   - confirmTitle: Alert 確認按鈕的標題
    ///   - confirm: 按下確認按鈕後要做的事情
    func showAlert(title: String?,
                   message: String?,
                   confirmTitle: String,
                   confirm: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default) { _ in
            confirm?()
        }
        alertController.addAction(confirmAction)
        present(alertController, animated: true)
    }
    
    /// 顯示 ActionSheet Alert
    /// - Parameters:
    ///   - title: ActionSheet Alert 的標題
    ///   - message: ActionSheet Alert 的訊息
    ///   - options: ActionSheet Alert 的選項
    ///   - confirm: 按下 ActionSheet Alert 的選項後要做的事情
    func showActionSheet(title: String?,
                         message: String?,
                         options: [String],
                         confirm: ((Int) -> Void)? = nil) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .actionSheet)
        for option in options {
            let index = options.firstIndex(of: option)
            let action = UIAlertAction(title: option, style: .default) { _ in
                confirm?(index!)
            }
            alertController.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    
    /// 留言排序
    /// - Parameter rule: enum SortRule，排序規則
    /// - Returns: 排序完的 [Message]
    func sortMessage(rule: SortRule) -> [Message] {
        return messageArray.sorted(by: { prev, next in
            switch rule {
            case .default: // 預設 = 新到舊
                return prev.timestamp > next.timestamp
            case .oldToNew:
                return prev.timestamp < next.timestamp
            case .newToOld:
                return prev.timestamp > next.timestamp
            }
        })
    }
    
    @IBAction func sendBtnClicked(_ sender: UIButton) {
        closeKeyboard()
        guard let messagePeople = messagePeopleTextField.text, !(messagePeople.isEmpty) else {
            showAlert(title: "錯誤", message: "請輸入留言人", confirmTitle: "關閉")
            return
        }
        guard let message = messageTextView.text, !(message.isEmpty) else {
            showAlert(title: "錯誤", message: "請輸入留言內容", confirmTitle: "關閉")
            return
        }
        showAlert(title: "成功", message: "留言已送出！", confirmTitle: "關閉") {
            self.messagePeopleTextField.text = ""
            self.messageTextView.text = ""
        }
        print("留言人：\(messagePeople)")
        print("留言內容：\(message)")
        messageArray.append(Message(name: messagePeople,
                                    content: message,
                                    timestamp: Int64(Date().timeIntervalSince1970)))
        messageTableView.reloadData()
    }
    
    @IBAction func sortBtnClicked(_ sender: UIButton) {
        showActionSheet(title: "請選擇排序方式",
                        message: "我也不知道要寫什麼",
                        options: optionsArray) { index in
            switch index {
            case 0:
                print("選擇「預設」排序方式")
                print(self.sortMessage(rule: .default))
            case 1:
                print("選擇「舊到新」排序方式")
                print(self.sortMessage(rule: .oldToNew))
            case 2:
                print("選擇「新到舊」排序方式")
                print(self.sortMessage(rule: .newToOld))
            default:
                break
            }
        }
    }
}

extension MessageBoardViewController: UITableViewDataSource, UITableViewDelegate {
    
    // UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.identifier,
                                                       for: indexPath) as? MessageTableViewCell else {
            fatalError("MessageTableViewCell Load Failed")
        }
        cell.messagePeopleLabel.text = "留言人：" + messageArray[indexPath.row].name
        cell.messageLabel.text = "留言內容：" + messageArray[indexPath.row].content
        return cell
    }
    
    // UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    // UITableView 右滑 Action
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "刪除") { action, sourceView, completionHandler in
            self.messageArray.remove(at: indexPath.row)
            tableView.reloadData()
            completionHandler(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
