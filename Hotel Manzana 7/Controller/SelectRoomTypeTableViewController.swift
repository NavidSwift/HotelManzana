//
//  SelectRoomTypeTableViewController.swift
//  Hottel Manzana 7
//
//  Created by Navid on 1/30/22.
//

import UIKit

class SelectRoomTypeTableViewController: UITableViewController {

    
    
    var roomType: RoomType?
     weak var delegate: SelectRoomTypeTableViewControllerDelegate?
   
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return RoomType.all.count
    }
    
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTypeCell", for: indexPath)
        
        let roomType = RoomType.all[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        
        content.text = roomType.name
        content.secondaryText = "$ \(roomType.price)"
        
        cell.contentConfiguration = content
        
        if self.roomType == roomType {
            cell.accessoryType = .checkmark
        }else {
            cell.accessoryType = .none
        }
        
        return cell
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let roomType = RoomType.all[indexPath.row]
        self.roomType = roomType
        
        self.delegate?.selectRoomTypeTableViewController(self, didSelect: roomType)
        
        tableView.reloadData()
        
        
    }
    
    

}



