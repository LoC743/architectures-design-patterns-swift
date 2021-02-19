//
//  ResultsTableViewController.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 19.02.2021.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    private let reuseCellIdentifier = "ResultTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = Colors.elementBackground
        tableView.register(UINib(nibName: reuseCellIdentifier, bundle: nil), forCellReuseIdentifier: reuseCellIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Game.results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseCellIdentifier, for: indexPath) as! ResultTableViewCell
        
        let index = Game.results.count - indexPath.row - 1
        let result = Game.results[index]
        
        cell.configure(with: result)
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
