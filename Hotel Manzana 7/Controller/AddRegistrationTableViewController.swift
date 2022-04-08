//
//  AddRegistrationTableViewController.swift
//  Hottel Manzana 7
//
//  Created by Navid on 1/30/22.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController,SelectRoomTypeTableViewControllerDelegate,RegistrationTableViewControllerProtocol{

 
   

    var roomType: RoomType?
 
    var passedRegistration: Registration? 
    
    var registration: Registration? {
        
        guard let roomType = roomType else {return nil}
        
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let emailAdress = emailAdressTextField.text ?? ""
        let cheakInDate = cheakInDatePicker.date
        let cheakOutDate = cheakOutDatePicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildrens = Int(numberOfChildrenStepper.value)
        let hasWifi = wifiSwitch.isOn
        
        return Registration(firstName: firstName, lastName: lastName, emailAdress: emailAdress, cheakInDate: cheakInDate, cheakOutDate: cheakOutDate, numberOfAdults: numberOfAdults, numberOfChildrens: numberOfChildrens, wifi: hasWifi, roomType: roomType)

        
    }
    
    @IBOutlet var doneBarButton: UIBarButtonItem!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailAdressTextField: UITextField!
    @IBOutlet var cheakInDateLabel: UILabel!
    @IBOutlet var cheakInDatePicker: UIDatePicker!
    @IBOutlet var cheakOutDatLabel: UILabel!
    @IBOutlet var cheakOutDatePicker: UIDatePicker!
    @IBOutlet var numberOfAdultsStepper: UIStepper!
    @IBOutlet var numberOfAdultsLabel: UILabel!
    @IBOutlet var numberOfChildrenStepper: UIStepper!
    @IBOutlet var numberOfChildrenLabel: UILabel!
    @IBOutlet var wifiSwitch: UISwitch!
    @IBOutlet var roomTypeLabel: UILabel!
    @IBOutlet var numberOfNightsTextField: UILabel!
    @IBOutlet var changesDateTextField: UILabel!
    @IBOutlet var changesRoomtypePrice: UILabel!
    @IBOutlet var changesRoomDetail: UILabel!
    @IBOutlet var changedWifiPrice: UILabel!
    @IBOutlet var changedWifiDetail: UILabel!
    @IBOutlet var changedTotalDetailLabel: UILabel!
    
    
    let cheakInDatePickerLabelCellIndexPath = IndexPath(row: 0, section: 1)
    let cheakInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let cheakOutDatePickerLabelCellIndexPath = IndexPath(row: 2, section: 1)
    let cheakOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    
    var isCheakInDatePickerVisible: Bool = false {
        
        didSet {
            cheakInDatePicker.isHidden = !isCheakInDatePickerVisible
        }
        
    }
    
    var isCheakOutDatePickerVisible: Bool = false {
        
        didSet {
            cheakOutDatePicker.isHidden = !isCheakOutDatePickerVisible
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let midNightToday = Calendar.current.startOfDay(for: Date())
        cheakInDatePicker.date = midNightToday
        cheakInDatePicker.minimumDate = midNightToday
        updateDateViews()
        updateNumberOfGuests()
        updateRoomType()
        updateView()
        updateWifiView()
        updateTotal()
        print("OK")
        
    }
    
    func updateView() {
        
        guard let passedRegistration = passedRegistration else {return}

        
        firstNameTextField.text = passedRegistration.firstName
        lastNameTextField.text = passedRegistration.lastName
        emailAdressTextField.text = passedRegistration.emailAdress
        cheakInDatePicker.date = passedRegistration.cheakInDate
        cheakOutDatePicker.date = passedRegistration.cheakOutDate
        numberOfAdultsStepper.value = Double(passedRegistration.numberOfAdults)
        numberOfChildrenStepper.value = Double(passedRegistration.numberOfChildrens)
        wifiSwitch.setOn(passedRegistration.wifi, animated: true)
        self.roomType = passedRegistration.roomType
        
        updateDateViews()
        updateNumberOfGuests()
        updateRoomType()
        
    }

    @IBAction func doneBarButtonTapped(_ sender: Any) {
        
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let emailAdress = emailAdressTextField.text ?? ""
        let cheakInDate = cheakInDatePicker.date
        let cheakOutDate = cheakOutDatePicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildrens = Int(numberOfChildrenStepper.value)
        let hasWifi = wifiSwitch.isOn
        let roomChoice = roomType?.name ?? "Not Set"
        
        
        print("First Name: \(firstName)")
        print("Last Name: \(lastName)")
        print("Email: \(emailAdress)")
        print("Cheak In Date: \(cheakInDate)")
        print("Cheak Out Date: \(cheakOutDate)")
        print("Number Of Adults: \(numberOfAdults)")
        print("Number Of Childrens: \(numberOfChildrens)")
        print("Wifi: \(hasWifi ? "On":"Off")")
        print("Room Type: \(roomChoice)")
        
    }
    
    func updateDateViews() {
        
        cheakInDateLabel.text = cheakInDatePicker.date.formatted(date: .abbreviated, time: .omitted)
        
        cheakOutDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: cheakInDatePicker.date)
        cheakOutDatLabel.text = cheakOutDatePicker.date.formatted(date: .abbreviated, time: .omitted)
        
        
        let cheakInDate = Calendar.current.startOfDay(for: cheakInDatePicker.date)
        let cheakOutDate = Calendar.current.startOfDay(for: cheakOutDatePicker.date)
        let components = Calendar.current.dateComponents([.day], from: cheakInDate, to: cheakOutDate)
        let days = components.day ?? 0
        let detailCheakInDate = cheakInDatePicker.date.formatted(date: .abbreviated, time: .omitted)
        let detailCheakOutDate = cheakOutDatePicker.date.formatted(date: .abbreviated, time: .omitted)
        
        numberOfNightsTextField.text = String(days)
        changesDateTextField.text = "\(detailCheakInDate) - \(detailCheakOutDate)"
    
        
        
        
        
        updateRoomType()
        updateDoneBarButton()
    }
    
    func updateNumberOfGuests() {
        
        numberOfAdultsLabel.text = String(Int(numberOfAdultsStepper.value))
        numberOfChildrenLabel.text = String(Int(numberOfChildrenStepper.value))
        updateDoneBarButton()
        
    }
    
    @IBAction func dateValueChanged(_ sender: Any) {
        
        updateDateViews()
        updateWifiView()
        updateTotal()
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath {
        case cheakInDatePickerCellIndexPath where isCheakInDatePickerVisible == false:
            return 0
        case cheakOutDatePickerCellIndexPath where isCheakOutDatePickerVisible == false:
            return 0
        default:
            return UITableView.automaticDimension
        }
        
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath {
            
        case cheakInDatePickerCellIndexPath:
            return 216
        case cheakOutDatePickerCellIndexPath:
            return 216
        default:
            return UITableView.automaticDimension
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath == cheakInDatePickerLabelCellIndexPath && isCheakOutDatePickerVisible == false {
            isCheakInDatePickerVisible.toggle()
        }else if indexPath == cheakOutDatePickerLabelCellIndexPath && isCheakInDatePickerVisible == false {
            isCheakOutDatePickerVisible.toggle()
        } else if indexPath == cheakInDatePickerLabelCellIndexPath || indexPath == cheakOutDatePickerLabelCellIndexPath {
            isCheakInDatePickerVisible.toggle()
            isCheakOutDatePickerVisible.toggle()
        }
        
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @IBAction func stepperValueChanged(_ sender: Any) {
        
        updateNumberOfGuests()
        updateDoneBarButton()
    }
    
    
    func updateWifiView() {
        
        let cheakInDate = Calendar.current.startOfDay(for: cheakInDatePicker.date)
        let cheakOutDate = Calendar.current.startOfDay(for: cheakOutDatePicker.date)
        let components = Calendar.current.dateComponents([.day], from: cheakInDate, to: cheakOutDate)
        let days = components.day ?? 0
        let wifi = wifiSwitch.isOn
        if wifi == true {
        changedWifiPrice.text = "$\(10 * days)"
        changedWifiDetail.text = "\(wifi ? "On":"Off")"
            
        } else {
            
            changedWifiPrice.text = "$\(0)"
            changedWifiDetail.text = "\(wifi ? "On":"Off")"
            
        }
        
    }
    
    @IBAction func wifiSwitchChanged(_ sender: Any) {
        
     updateWifiView()
        updateTotal()
        
    }
    
    func updateRoomType() {
        
        let cheakInDate = Calendar.current.startOfDay(for: cheakInDatePicker.date)
        let cheakOutDate = Calendar.current.startOfDay(for: cheakOutDatePicker.date)
        let components = Calendar.current.dateComponents([.day], from: cheakInDate, to: cheakOutDate)
        let days = components.day ?? 0
        
        
        if let roomType = roomType {
            roomTypeLabel.text = roomType.name
        }else {
            roomTypeLabel.text = "Not Set"
        }
        updateDoneBarButton()
        let roomTypePrice = self.roomType?.price ?? 0
        let roomTypeName = self.roomType?.name ?? "Not Set"
        changesRoomtypePrice.text = "\(roomTypePrice * days)"
        changesRoomDetail.text = "\(roomTypeName) @ \(roomTypePrice)/night"
    }
    
    func selectRoomTypeTableViewController(_ controller: SelectRoomTypeTableViewController, didSelect roomtype: RoomType) {
        
        
        self.roomType = roomtype
        
        updateRoomType()
        updateTotal()
        
        print("rm")
    }
    
    @IBSegueAction func selectRoomType(_ coder: NSCoder) -> SelectRoomTypeTableViewController? {
        
        let selectRoomTypeController = SelectRoomTypeTableViewController(coder: coder)
        selectRoomTypeController?.delegate = self
        selectRoomTypeController?.roomType = roomType
        
        return selectRoomTypeController
    }
    
    func registrationTableViewController(_ controller: RegistrationTableViewController, didSelect registration: Registration) {
        
        
//        passedRegistration = registration
//
//        guard let passedRegistration = passedRegistration else {return}
//
////        let firstName = registration.firstName
////        let lastName = registration.lastName
////        let email = registration.emailAdress
////        let cheakInDate = registration.cheakInDate
////        let cheakOutDate = registration.cheakOutDate
////        let numberOfAdults = registration.numberOfAdults
////        let numberOfChildren = registration.numberOfChildrens
////        let wifi = registration.wifi
////        let roomType = registration.roomType
//
//        firstNameTextField.text = passedRegistration.firstName
//        lastNameTextField.text = passedRegistration.lastName
//        emailAdressTextField.text = passedRegistration.emailAdress
//        cheakInDatePicker.date = passedRegistration.cheakInDate
//        cheakOutDatePicker.date = passedRegistration.cheakOutDate
//        numberOfAdultsStepper.value = Double(passedRegistration.numberOfAdults)
//        numberOfChildrenStepper.value = Double(passedRegistration.numberOfChildrens)
//        wifiSwitch.setOn(passedRegistration.wifi, animated: true)
//        self.roomType = passedRegistration.roomType
////        updateRoomType()
////        updateDateViews()
////        updateNumberOfGuests()
        print("ok")
        
        
        
        
    }
    
  

    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
      
    }
    
    func updateDoneBarButton() {
        
        if self.registration == nil {
        
         doneBarButton.isEnabled = false
            
         
        }else {
            doneBarButton.isEnabled = true
        }
    }
    
    func updateTotal() {
        
        let cheakInDate = Calendar.current.startOfDay(for: cheakInDatePicker.date)
        let cheakOutDate = Calendar.current.startOfDay(for: cheakOutDatePicker.date)
        let components = Calendar.current.dateComponents([.day], from: cheakInDate, to: cheakOutDate)
        let days = components.day ?? 0
        
        let wifiPrice: Int
        
        if wifiSwitch.isOn {
            wifiPrice = 10 * days
        } else {
            wifiPrice = 0
        }
        
        let roomTypePrice = self.roomType?.price ?? 0
        
        changedTotalDetailLabel.text = "\(wifiPrice + roomTypePrice)"
        
        
        
    
        
        
        
    }
    
 
    
    
    

}
