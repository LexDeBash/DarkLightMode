//
//  ViewController.swift
//  DarkLightMode
//
//  Created by Vasichko Anna on 03.05.2022.
//

import UIKit

class ListViewController: UITableViewController {

    private let cellID = "listCell"
    
    private lazy var customSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.isOn = true
        uiSwitch.addTarget(self, action: #selector(changeScreenMode), for: .valueChanged)
        uiSwitch.onTintColor = UIColor.white
        uiSwitch.backgroundColor = .darkGray
        uiSwitch.layer.cornerRadius = 16
        uiSwitch.thumbTintColor = .systemYellow
        return uiSwitch
    }()
    
    private lazy var darkModeLabel: UILabel = {
        let label = UILabel()
        label.text = "Dark Mode"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.separatorInset = .zero
        tableView.separatorColor = .darkGray
        
        setupNavigationBar()
    }
    
// MARK: - Setup NavBar
    private func setupNavigationBar() {
        title = "To Do List"
        navigationController?.navigationBar.prefersLargeTitles = true
       
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navBarAppearance.backgroundColor = .lightGray
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        let navBarSwitch = UIBarButtonItem(customView: customSwitch)
        let navBarLabel = UIBarButtonItem(customView: darkModeLabel)
        navigationItem.leftBarButtonItems = [navBarSwitch, navBarLabel]
    }
    
    @objc private func changeScreenMode(sender: UISwitch) {
        if sender.isOn {
            darkModeLabel.text = "Dark Mode"
            view.backgroundColor = .white
            tableView.separatorColor = .darkGray
            tableView.reloadData()
        } else {
            view.backgroundColor = .darkGray
            tableView.separatorColor = .white
            darkModeLabel.text = "Light Mode"
            tableView.reloadData()
        }
    }
}

// MARK: - Table view data source
extension ListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = "task"
        content.textProperties.color =  .lightGray
        cell.contentConfiguration = content
        
        cell.tintColor = tableView.backgroundColor == .white ? .darkGray : .white
        cell.backgroundColor = tableView.backgroundColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
