//
//  RegistrationTableViewController.swift
//  Hotel_Manzana
//
//  Created by user on 24/04/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

class RegistrationTableViewController: UITableViewController {

    // MARK: - IB Outlets
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    
    @IBOutlet weak var numberOfAdultsLabel: UILabel!
    @IBOutlet weak var numberOfAdultsStepper: UIStepper!
    @IBOutlet weak var numberOfChildrenLabel: UILabel!
    @IBOutlet weak var numberOfChildrenStepper: UIStepper!
    
    @IBOutlet weak var wifiLabel: UILabel!
    @IBOutlet weak var wifiSwitch: UISwitch!
    
    // MARK: - Properties
        
    var oneDayTimeInterval: TimeInterval {
        return 60 * 60 * 24
    }
    
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
        updateWiFiCostLabel()
    }
    
    // MARK: - Custom Methods
    
    private func saveRegistration() {
        
        let firstName = firstNameField.text ?? ""
        let lastName = lastNameField.text ?? ""
        let email = emailField.text ?? ""
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        let isWiFi = wifiSwitch.isOn
        
        print("First Name: ", firstName)
        print("Last Name: ", lastName)
        print("Email: ", email)
        print("Check In Date: ", dateFormatter.string(from: checkInDate))
        print("Check Out Date: ", dateFormatter.string(from: checkOutDate))
        print("Number Of Adults: ", numberOfAdults)
        print("Number Of Children: ", numberOfChildren)
        print("Wi-Fi Included: ", isWiFi)
        
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
        checkOutDatePicker.minimumDate = midnightToday.addingTimeInterval(oneDayTimeInterval)
    }
    
    private func updateDateLabels() {
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
    }
    
    private func updateNumberOfGuestsLabels() {
        numberOfAdultsLabel.text = String(Int(numberOfAdultsStepper.value))
        numberOfChildrenLabel.text = String(Int(numberOfChildrenStepper.value))
    }
    
    private func updateWiFiCostLabel() {
        if wifiSwitch.isOn == false {
           wifiLabel.text = "0$"
        } else {
           wifiLabel.text = String(Registration.calculateWiFiCost(fromDate: checkInDatePicker.date, toDate: checkOutDatePicker.date)) + "$"
        }
    }
    
    private func validateGuestInfoFields() -> Bool {
        
       guard let firstNameText = firstNameField.text else { return false }
       guard let lastNameText = lastNameField.text else { return false }
       guard let emailText = emailField.text else { return false }
        
       if firstNameText.count == 0 ||
        lastNameText.count == 0 ||
        emailText.count == 0 {
          return false
        }
        
       let decimalSet = CharacterSet.decimalDigits
       let firstNameRange = firstNameText.rangeOfCharacter(from: decimalSet)
       let lastNameRange = lastNameText.rangeOfCharacter(from: decimalSet)
        
       if firstNameRange != nil ||
        lastNameRange != nil {
        return false
        }
        
        let charset: Set<Character> = ["@", "."]
        if !charset.isSubset(of: emailText) {
            return false
        }
        
        return true
    }
    
    // MARK: - IB Actions
    
    @IBAction func actionSaveButtonItem(_ sender: UIBarButtonItem) {
        
        if !validateGuestInfoFields() {
            showAlertWithMessage("Make sure the guest information fields are correct")
            return
        }
        
        saveRegistration()
    }
    
    @IBAction func datePickerValueChanged(_ datePicker: UIDatePicker) {
        if (datePicker == checkInDatePicker) {
            checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(oneDayTimeInterval)
        }
        updateDateLabels()
        updateWiFiCostLabel()
    }
    
    @IBAction func stepperValueChanged(_ stepper: UIStepper) {
        updateNumberOfGuestsLabels()
    }
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        updateWiFiCostLabel()
    }
    
    // MARK: - Navigations
    
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
        if unwindSegue.identifier == "UnwindRoomTypes" {
            let roomTypesVC = unwindSegue.source as! RoomTypesViewController
            
        }
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
