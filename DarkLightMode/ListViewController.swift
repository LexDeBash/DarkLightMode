//
//  ViewController.swift
//  DarkLightMode
//
//  Created by Vasichko Anna on 03.05.2022.
//

import UIKit

class ListViewController: UITableViewController {

    private let cellID = "listCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.separatorInset = .zero
        tableView.separatorColor = .darkGray
        
        setupNavigationBar()
        setupCustomSwitch()
    }
    
// MARK: - Setup NavBar
    private func setupNavigationBar() {
        title = "To Do List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
       
        let navBarAppearence = UINavigationBarAppearance()
        navBarAppearence.configureWithOpaqueBackground()
        navBarAppearence.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearence.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navBarAppearence.backgroundColor = .lightGray
        
        navigationController?.navigationBar.standardAppearance = navBarAppearence
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearence
        
    }

//MARK: - Setup Custom Switch
    private func setupCustomSwitch() {
        
        let customSwitch = UISwitch()
        customSwitch.isOn = true
        customSwitch.addTarget(self, action: #selector(changeScreenMode), for: .valueChanged)
        customSwitch.onTintColor = UIColor.white
        customSwitch.backgroundColor = .darkGray
        customSwitch.layer.cornerRadius = 16
        customSwitch.layer.masksToBounds = true
        customSwitch.thumbTintColor = .systemYellow
        
        let navBarSwitch = UIBarButtonItem(customView: customSwitch)
        
        let darkModeLabel = UILabel()
        darkModeLabel.text = "Dark Mode"
        darkModeLabel.textColor = .white
        darkModeLabel.font = UIFont.systemFont(ofSize: 16)
        darkModeLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        let navModeLabel = UIBarButtonItem(customView: darkModeLabel)
        navigationItem.leftBarButtonItems = [navBarSwitch, navModeLabel]
    }
    
    @objc private func changeScreenMode(sender: UISwitch) {
        guard let label = navigationItem.leftBarButtonItems?.last?.customView as? UILabel else { return }
        
        if sender.isOn {
            label.text = "Dark Mode"
            view.backgroundColor = .white
            tableView.separatorColor = .darkGray
            tableView.reloadData()
        } else {
            view.backgroundColor = .darkGray
            tableView.separatorColor = .white
            label.text = "Light Mode"
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
