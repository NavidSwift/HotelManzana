//
//  Cammunicate Selection.swift
//  Hottel Manzana 7
//
//  Created by Navid on 1/30/22.
//

import Foundation


protocol SelectRoomTypeTableViewControllerDelegate: AnyObject {
    
    func selectRoomTypeTableViewController(_ controller: SelectRoomTypeTableViewController, didSelect roomtype: RoomType)
    
}
