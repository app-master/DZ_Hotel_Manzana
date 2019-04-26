//
//  GuestsViewController.swift
//  Hotel_Manzana
//
//  Created by user on 26/04/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

class GuestsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var registrations = [Registration]()
    
    var dateFormatter = DateFormatter.dateFormatterShortStyle()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    // MARK: - Custom Methods
    
    private func configureCell(_ cell: UITableViewCell, with registration: Registration) {
        cell.textLabel?.text = "\(registration.firstName)" + " \(registration.lastName)"
        cell.detailTextLabel?.text = dateFormatter.string(from: registration.checkOutDate)
    }

}

extension GuestsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registrations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "GuestCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell.init(style: .value2, reuseIdentifier: cellIdentifier)
        }
        
        let registration = registrations[indexPath.row]
        
        configureCell(cell!, with: registration)
        
        return cell!
    }
    
}

// MARK: - Navigation

extension GuestsViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRegistration" {
            let registrationVC = segue.destination as! RegistrationTableViewController
            registrationVC.delegate = self
        }
    }
}

// MARK: - RegistrationDelegate

extension GuestsViewController: RegistrationDelegate {
    func saveRegistration(_ registration: Registration) {
        registrations.append(registration)
        let indexPath = IndexPath(row: registrations.count - 1, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
}

