//
//  RegistrationTableViewController.swift
//  Hotel_Manzana
//
//  Created by user on 24/04/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

protocol RegistrationDelegate: class {
    func saveRegistration(_ registration: Registration)
}

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
    
    @IBOutlet weak var roomTypeLabel: UILabel!
    
    weak var delegate: RegistrationDelegate?
    
    // MARK: - Properties
        
    var oneDayTimeInterval: TimeInterval {
        return 60 * 60 * 24
    }
    
    var dateFormatter = DateFormatter.dateFormatterShortStyle()
    
    var checkInDatePickerShow = false
    var checkOutDatePickerShow = false
    
    let checkInDatePickerIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerIndexPath = IndexPath(row: 3, section: 1)
    
    var selectRoom: RoomType?
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDatePickers()
        updateDateLabels()
        updateWiFiCostLabel()
    }
    
    // MARK: - Custom Methods
    
    private func createNewRegistration() -> Registration? {
        
        if !validateGuestInfoFields() {
            showAlertWithMessage("Make sure the guest information fields are correct")
            return nil
        }
        
        if selectRoom == nil {
            showAlertWithMessage("Please, select a room type")
            return nil
        }
        
        let firstName = firstNameField.text ?? ""
        let lastName = lastNameField.text ?? ""
        let email = emailField.text ?? ""
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        let isWiFi = wifiSwitch.isOn
        let room = selectRoom!
        
        print("First Name: ", firstName)
        print("Last Name: ", lastName)
        print("Email: ", email)
        print("Check In Date: ", dateFormatter.string(from: checkInDate))
        print("Check Out Date: ", dateFormatter.string(from: checkOutDate))
        print("Number Of Adults: ", numberOfAdults)
        print("Number Of Children: ", numberOfChildren)
        print("Wi-Fi Included: ", isWiFi)
        
        let registration = Registration(firstName: firstName,
                                        lastName: lastName,
                                        email: email,
                                        checkInDate: checkInDate,
                                        checkOutDate: checkOutDate,
                                        numberOfAdults: numberOfAdults,
                                        numberOfChildren: numberOfChildren,
                                        isWiFi: isWiFi,
                                        roomType: room)
        return registration
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
    
    @IBAction func actionSaveBarButtonItem() {
        guard let registration = createNewRegistration() else { return }
        delegate?.saveRegistration(registration)
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - Navigations

extension RegistrationTableViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRoomTypes" {
            let roomTypesVC = segue.destination as! RoomsViewController
            roomTypesVC.selectedRoomType = selectRoom
        }
    }
    
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
        if unwindSegue.identifier == "UnwindRoomTypes" {
            let roomTypesVC = unwindSegue.source as! RoomsViewController
            if let selectedRoom = roomTypesVC.selectedRoomType {
                selectRoom = selectedRoom
                roomTypeLabel.text = selectedRoom.name
            }
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

extension RegistrationTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameField {
            lastNameField.becomeFirstResponder()
        } else if textField == lastNameField {
            emailField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
}
