//
//  RegistrationTableViewController.swift
//  Hotel_Manzana
//
//  Created by user on 24/04/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

class RegistrationTableViewController: UITableViewController {

    // MARK: - IB Outlet
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    
    
    // MARK: - Properties
    
    var dateFormatter: DateFormatter!
    
    var checkInDatePickerShow = false
    var checkOutDatePickerShow = false
    
    let checkInDatePickerIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerIndexPath = IndexPath(row: 3, section: 1)
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateFormatter = obtainDateFormatter()
        
        setupDatePickers()
        updateDateLabels()
    }
    
    // MARK: - Custom Methods
    
    private func saveRegistration() {
        
        let firstName = firstNameField.text ?? ""
        let lastName = lastNameField.text ?? ""
        let email = emailField.text ?? ""
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        
        print("First Name: ", firstName)
        print("Last Name: ", lastName)
        print("Email: ", email)
        print("Check In Date: ", dateFormatter.string(from: checkInDate))
        print("Check Out Date: ", dateFormatter.string(from: checkOutDate))
        
    }
    
    private func obtainDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        return dateFormatter
    }
    
    private func setupDatePickers() {
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkInDatePicker.date = midnightToday
        checkOutDatePicker.minimumDate = midnightToday.addingTimeInterval(60 * 60 * 24)
    }
    
    private func updateDateLabels() {
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
    }

}

// MARK: - Table View Delegate

extension RegistrationTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath {
            case checkInDatePickerIndexPath:
                return checkInDatePickerShow ? super.tableView(tableView, heightForRowAt: indexPath) : 0
            
            case checkOutDatePickerIndexPath:
                return checkOutDatePickerShow ? super.tableView(tableView, heightForRowAt: indexPath) : 0
            
            default:
                return super.tableView(tableView, heightForRowAt: indexPath)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath {
            case checkInDatePickerIndexPath.prevRow:
                checkInDatePickerShow.toggle()
            
                if checkOutDatePickerShow {
                    checkOutDatePickerShow = false
                }
            
            
            case checkOutDatePickerIndexPath.prevRow:
                checkOutDatePickerShow.toggle()
            
                if checkInDatePickerShow {
                    checkInDatePickerShow = false
                }
            
            default:
                return
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
}
