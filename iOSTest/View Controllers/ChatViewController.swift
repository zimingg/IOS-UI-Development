//
//  ChatViewController.swift
//  iOSTest
//
//  Created by App Partner on 1/22/18.
//  Copyright © 2018 AppPartner. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Using the following endpoint, fetch chat data
     *    URL: http://dev3.apppartner.com/AppPartnerDeveloperTest/scripts/chat_log.php
     *
     * 3) Parse the chat data using 'Message' model
     *
     **/
    
    // MARK: - Properties
    private var client: ChatClient?
    private var messages: [NewMessage]?
    
    // MARK: - Outlets
    @IBOutlet weak var chatTable: UITableView!
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //set navigation bar
        self.navigationController!.navigationBar.topItem?.title = "Back"
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        
        //set chat table
        chatTable.rowHeight = UITableViewAutomaticDimension
        chatTable.estimatedRowHeight = 140
        chatTable.separatorStyle = .none
        
        //get data from the api
        getData()
        
        messages = [NewMessage]()
        configureTable(tableView: chatTable)
        title = "Chat"
        
        chatTable.reloadData()
    }
    
    //function to get data from api
    func getData(){
        
        let url = URL(string: "http://dev3.apppartner.com/AppPartnerDeveloperTest/scripts/chat_log.php")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                //print("error=\(error!)")
                print("error")
                self.messages = []
                return
            }
            else{
                do{
                    let List = try JSONDecoder().decode(AllData.self, from: data!)
                    self.messages = List.data!
                    //asynchronous reload tableview with data
                    DispatchQueue.main.async {
                        self.chatTable.reloadData()
                    }
                }
                catch let jsonerr{
                    print("Error Serialization JSON: \(jsonerr)")
                }
            }
        }
        task.resume()
    }
    
    // MARK: - Private
    private func configureTable(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatTableViewCell")
        //tableView.tableFooterView = UIView(frame: .zero)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: ChatTableViewCell? = nil
        if cell == nil {
            let nibs = Bundle.main.loadNibNamed("ChatTableViewCell", owner: self, options: nil)
            cell = nibs?[0] as? ChatTableViewCell
        }
        cell?.setCellData(message: messages![indexPath.row])
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages!.count
    }
    
//     MARK: - UITableViewDelegate
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }
    
    // MARK: - IBAction
    @IBAction func backAction(_ sender: Any) {
        let mainMenuViewController = MenuViewController()
        self.navigationController?.pushViewController(mainMenuViewController, animated: true)
    }
}
