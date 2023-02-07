//
//  MessageBoardViewController.swift
//  MessageBoard
//
//  Created by Leo Ho on 2023/1/17.
//

import UIKit
import RealmSwift

class MessageBoardViewController: UIViewController {
    
    @IBOutlet weak var messagePeopleLabel: UILabel!
    @IBOutlet weak var messagePeopleTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var messageTableView: UITableView!
    
    /// 用來顯示留言資料的陣列
    var messageArray: [Message] = []
    
    /// 用來顯示排序選項的陣列
    var optionsArray: [String] = ["預設", "舊到新", "新到舊"]
    
    /// 現在是否為更新模式
    var isEdit: Bool = false
    
    /// 目前要更新的那筆資料所在 indexPath.row
    var currentIndex: Int = 0
    
    /// enum 排序規則
    enum SortRule {
        /// 預設的排序規則 = 舊到新
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFromDatabase()
    }
    
    /// 設定 UI 樣式
    func setupUI() {
        setupNavigationBarStyle()
        setupNavigationBarButtonItems()
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
        sendButton.layer.cornerRadius = sendButton.bounds.height / 6
        sendButton.backgroundColor = .systemBlue
        sendButton.setTitleColor(.white, for: .normal)
        
        sortButton.setTitle("排序", for: .normal)
        sortButton.layer.cornerRadius = sortButton.bounds.height / 6
        sortButton.backgroundColor = .systemPink
        sortButton.setTitleColor(.white, for: .normal)
    }
    
    /// 設定 UITableView 樣式
    private func setupTableView() {
        messageTableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil),
                                  forCellReuseIdentifier: MessageTableViewCell.identifier)
        messageTableView.dataSource = self
        messageTableView.delegate = self
    }
    
    /// 設定 UINaviagationBar 外觀樣式
    private func setupNavigationBarStyle() {
        let appearance = UINavigationBarAppearance()
        self.navigationController?.navigationBar.standardAppearance = appearance
    }
    
    /// 設定 NavigationBarButtonItem 樣式
    private func setupNavigationBarButtonItems() {
        let sortItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle.fill"),
                                       style: .done,
                                       target: self,
                                       action: #selector(sortBtnClicked))
        navigationItem.leftBarButtonItem = sortItem
        
        let addItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"),
                                      style: .done,
                                      target: self,
                                      action: #selector(sendBtnClicked))
        navigationItem.rightBarButtonItem = addItem
    }
    
    /// 關鍵盤
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
    
    /// 從 Realm Database 撈資料
    func fetchFromDatabase() {
        LocalDatabase.shared.fetch { messages in
            self.messageArray = []
            for i in messages {
                self.messageArray.append(Message(name: i.name,
                                                 content: i.content,
                                                 createTimestamp: i.createTimestamp,
                                                 updateTimestamp: i.updateTimestamp))
            }
            DispatchQueue.main.async {
                self.messageTableView.reloadData()
            }
        }
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
    func sortMessage(rule: SortRule) {
        let realm = try! Realm()
        var results: Results<MessageTable>
        switch rule {
        case .default, .oldToNew:
            results = realm.objects(MessageTable.self).sorted(byKeyPath: "updateTimestamp", ascending: true)
        case .newToOld:
            results = realm.objects(MessageTable.self).sorted(byKeyPath: "updateTimestamp", ascending: false)
        }
        
        if results.count > 0 {
            messageArray = []
            for i in results {
                messageArray.append(Message(name: i.name,
                                            content: i.content,
                                            createTimestamp: i.createTimestamp,
                                            updateTimestamp: i.updateTimestamp))
            }
            DispatchQueue.main.async {
                self.messageTableView.reloadData()
            }
        }
    }
    
    @IBAction @objc func sendBtnClicked(_ sender: UIButton) {
        closeKeyboard()
        guard let messagePeople = messagePeopleTextField.text, !(messagePeople.isEmpty) else {
            showAlert(title: "錯誤", message: "請輸入留言人", confirmTitle: "關閉")
            return
        }
        guard let message = messageTextView.text, !(message.isEmpty) else {
            showAlert(title: "錯誤", message: "請輸入留言內容", confirmTitle: "關閉")
            return
        }
        print("留言人：\(messagePeople)")
        print("留言內容：\(message)")
        
        if isEdit {
            messageArray[currentIndex].name = messagePeople
            messageArray[currentIndex].content = message
            messageArray[currentIndex].updateTimestamp = Int64(Date().timeIntervalSince1970)
            LocalDatabase.shared.update(message: messageArray[currentIndex])
            isEdit = false
            
            showAlert(title: "成功", message: "留言更新成功！", confirmTitle: "關閉") {
                self.messagePeopleTextField.text = ""
                self.messageTextView.text = ""
            }
        } else {
            let msg = Message(name: messagePeople,
                              content: message,
                              createTimestamp: Int64(Date().timeIntervalSince1970),
                              updateTimestamp: Int64(Date().timeIntervalSince1970))
            LocalDatabase.shared.add(message: msg)
            
            showAlert(title: "成功", message: "留言已送出！", confirmTitle: "關閉") {
                self.messagePeopleTextField.text = ""
                self.messageTextView.text = ""
            }
        }
        fetchFromDatabase()
    }
    
    @IBAction @objc func sortBtnClicked(_ sender: UIButton) {
        showActionSheet(title: "請選擇排序方式",
                        message: "我也不知道要寫什麼",
                        options: optionsArray) { index in
            switch index {
            case 0:
                print("選擇「預設」排序方式")
                self.sortMessage(rule: .default)
            case 1:
                print("選擇「舊到新」排序方式")
                self.sortMessage(rule: .oldToNew)
            case 2:
                print("選擇「新到舊」排序方式")
                self.sortMessage(rule: .newToOld)
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
            LocalDatabase.shared.delete(message: self.messageArray[indexPath.row])
            self.fetchFromDatabase()
            completionHandler(true)
        }
        deleteAction.backgroundColor = .systemRed
        deleteAction.image = UIImage(systemName: "trash")
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    // UITableView 左滑 Action
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .destructive, title: "編輯") { action, sourceView, completionHandler in
            self.isEdit.toggle()
            self.currentIndex = indexPath.row
            self.messagePeopleTextField.text = self.messageArray[indexPath.row].name
            self.messageTextView.text = self.messageArray[indexPath.row].content
            completionHandler(true)
        }
        editAction.backgroundColor = .systemBlue
        editAction.image = UIImage(systemName: "pencil")
        let configuration = UISwipeActionsConfiguration(actions: [editAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}
