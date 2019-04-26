//
//  RoomTypesViewController.swift
//  Hotel_Manzana
//
//  Created by user on 25/04/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

class RoomsViewController: UIViewController {

    // MARK: - IB Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var roomTypes = RoomTypes()
    var selectedRoomType: RoomType?
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        roomTypes = RoomTypes.loadRoomTypes()
    }
    
    // MARK: - Custom Methods
    
    private func configureCell(_ cell: UITableViewCell, with roomType: RoomType) {
        cell.textLabel?.text = roomType.name
        cell.detailTextLabel?.text = String(roomType.price) + " $"
        
        if selectedRoomType == roomType {
            cell.accessoryType = .checkmark
        }
    }
    
    private func cellForRoomType(_ roomType: RoomType) -> UITableViewCell? {
        if let index = roomTypes.firstIndex(of: roomType) {
            let indexPath = IndexPath(row: index, section: 0)
            return tableView.cellForRow(at: indexPath)
        }
        return nil
    }

}

extension RoomsViewController: UITableViewDataSource {
    
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

extension RoomsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let prevSelectedRoomType = selectedRoomType {
            let prevCell = cellForRoomType(prevSelectedRoomType)
            prevCell?.accessoryType = .none
        }
        
        selectedRoomType = roomTypes[indexPath.row]
        let selectedCell = tableView.cellForRow(at: indexPath)
        selectedCell?.accessoryType = .checkmark
    }
    
}
