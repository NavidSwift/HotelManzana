//
//  RegistrationTableViewController.swift

//
//  Created by Navid on 1/30/22.
//

import UIKit

class RegistrationTableViewController: UITableViewController {

      var delegate: RegistrationTableViewControllerProtocol?
    var registrations: [Registration] = []
    override func viewDidLoad() {
        super.viewDidLoad()

     
        delegate = AddRegistrationTableViewController()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return registrations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationCell", for: indexPath)
        
        let registration = registrations[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        
        content.text = registration.firstName + " " + registration.lastName
        content.secondaryText = (registration.cheakInDate..<registration.cheakOutDate).formatted(date: .numeric, time: .omitted) + ": " + registration.roomType.name
        cell.contentConfiguration = content
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let registration = registrations[indexPath.row]
        
        delegate?.registrationTableViewController(self, didSelect: registration)
        
        
     
        
    }
    
    @IBAction func unwindFromRegistration(unwindSeague: UIStoryboardSegue) {
        
        guard let addRegistrationTableViewController = unwindSeague.source as? AddRegistrationTableViewController,let registration = addRegistrationTableViewController.registration else {return}
        guard unwindSeague.identifier != "Cancel" else {return}
        if let indexPath = tableView.indexPathForSelectedRow?.row {
            
            self.registrations[indexPath] = registration
            tableView.reloadData()
        } else {
        self.registrations.append(registration)
        tableView.reloadData()
            }
        
        
    }

    @IBSegueAction func addRegistration(_ coder: NSCoder) -> AddRegistrationTableViewController? {
        
        let addRegistrationController = AddRegistrationTableViewController(coder: coder)
        
         let indexPath = tableView.indexPathForSelectedRow!.row
        addRegistrationController?.passedRegistration = self.registrations[indexPath]
        
        return addRegistrationController
    }
    

}
