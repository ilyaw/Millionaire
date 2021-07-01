//
//  ResultsTableViewController.swift
//  Millionaire
//
//  Created by Ilya on 15.06.2021.
//

import UIKit

class ResultsTableViewController: UITableViewController {

    var records: [Record]? {
        return Caretaker<Record>(key: "record").load()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "ResultsTableViewCell", bundle: nil),
                           forCellReuseIdentifier: ResultsTableViewCell.reuseId)
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultsTableViewCell.reuseId, for: indexPath) as? ResultsTableViewCell,
              let record = records?[indexPath.row] else { return UITableViewCell() }
        
        cell.setup(with: record)        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
