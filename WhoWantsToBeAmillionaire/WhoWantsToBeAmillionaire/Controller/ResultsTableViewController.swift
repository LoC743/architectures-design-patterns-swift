//
//  ResultsTableViewController.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 19.02.2021.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = Colors.elementBackground
        tableView.allowsSelection = false
        tableView.register(UINib(nibName: ResultTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ResultTableViewCell.reuseIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Game.shared.results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.reuseIdentifier, for: indexPath) as! ResultTableViewCell
        
        let index = Game.shared.results.count - indexPath.row - 1
        let result = Game.shared.results[index]
        
        cell.configure(with: result)
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
