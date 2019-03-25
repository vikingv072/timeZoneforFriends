//
//  FriendViewController.swift
//  TimezoneForFriends
//
//  Created by C02PX1DFFVH5 on 3/18/19.
//  Copyright © 2019 C02PX1DFFVH5. All rights reserved.
//

import UIKit

class FriendViewController: UITableViewController, StoryboarProtocol {
    
    weak var coordinator : MainCoordinator?
    var friend : Friend!
    
    var timeZones = [TimeZone]()
    var selectedTimeZone = 0
    
    var nameEditingCell : NameTableViewCell? {
        let indexPath = IndexPath(row: 0, section: 0)
        return tableView.cellForRow(at: indexPath) as? NameTableViewCell
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let identifiers = TimeZone.knownTimeZoneIdentifiers
        for identifier in identifiers {
            if let timeZone = TimeZone(identifier: identifier) {
                timeZones.append(timeZone)
            }
        }
        
        let now = Date()
        
        timeZones.sort {
            let ourDiff = $0.secondsFromGMT(for: now)
            let otherDiff = $1.secondsFromGMT(for: now)
            
            if ourDiff == otherDiff {
                return $0.identifier < $1.identifier
            } else {
                return ourDiff < otherDiff
            }
        }
        
        selectedTimeZone = timeZones.index(of: friend.timeZone) ?? 0

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        coordinator?.updater(friend: friend)
    }

    @IBAction func nameChanger(_ sender: UITextField) {
        friend.name = sender.text ?? "Name Unknown"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return timeZones.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
             return "Enter the name"
        } else {
            return "Choose their TimeZone"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Name", for: indexPath) as? NameTableViewCell else {
                fatalError("Unable to create a new cell")
            }
            cell.textField?.text = friend.name
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Timezone", for: indexPath)
            let timeZone = timeZones[indexPath.row]
            cell.textLabel?.text = timeZone.identifier.replacingOccurrences(of: "_", with: " ")
            
            let timeDiff = timeZone.secondsFromGMT(for: Date())
            cell.detailTextLabel?.text = timeDiff.timeString()
            
            if indexPath.row == selectedTimeZone {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            startEditingName()
        } else {
            rowSelect(at: indexPath)
        }
    }
    
    func startEditingName() {
        nameEditingCell?.textField.becomeFirstResponder()
    }
    
    func rowSelect(at indexPath: IndexPath) {
        nameEditingCell?.textField.resignFirstResponder()
        
        for cell in tableView.visibleCells {
            cell.accessoryType = .none
        }
        selectedTimeZone = indexPath.row
        friend.timeZone = timeZones[indexPath.row]
        
        let select = tableView.cellForRow(at: indexPath)
        select?.accessoryType = .checkmark
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
