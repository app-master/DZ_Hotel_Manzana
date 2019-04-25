//
//  RoomTypesViewController.swift
//  Hotel_Manzana
//
//  Created by user on 25/04/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

class RoomTypesViewController: UIViewController {

    // MARK: - Properties
    
    let roomTypes = RoomTypes.loadRoomTypes()
    var selectRoomType: RoomType?
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
    }
    
    // MARK: - Custom Methods
    
    private func configureCell(_ cell: UITableViewCell, with roomType: RoomType) {
        cell.textLabel?.text = roomType.name
        cell.detailTextLabel?.text = String(roomType.price) + " $"
    }
    
    // MARK: IB Actions
    

}

extension RoomTypesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "RoomCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell.init(style: .value2, reuseIdentifier: cellIdentifier)
        }
        
        let roomType = roomTypes[indexPath.row]
        
        configureCell(cell!, with: roomType)
        
        return cell!
    }
    
    
}

extension RoomTypesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let prevSelectRoomType = selectRoomType {
            if let index = roomTypes.firstIndex(of: prevSelectRoomType) {
               let indexPath = IndexPath(row: index, section: 0)
               let prevCell = tableView.cellForRow(at: indexPath)
               prevCell?.accessoryType = .none
            }
            
        }
        
        selectRoomType = roomTypes[indexPath.row]
        let selectCell = tableView.cellForRow(at: indexPath)
        selectCell?.accessoryType = .checkmark
        
    }
    
}
