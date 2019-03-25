//
//  ViewController.swift
//  TimezoneForFriends
//
//  Created by C02PX1DFFVH5 on 3/18/19.
//  Copyright © 2019 C02PX1DFFVH5. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController, StoryboarProtocol {
    
    weak var coordinator : MainCoordinator?
    
    var selFriend : Int?
    var friends = [Friend]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendsLoad()
        title = "TimeZone for Friends"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(friendAdd))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kCell", for: indexPath)
        let friend =  friends[indexPath.row]
        cell.textLabel?.text = friend.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = friend.timeZone
        dateFormatter.timeStyle = .short
        cell.detailTextLabel?.text = dateFormatter.string(from: Date())
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selFriend = indexPath.row
        coordinator?.configure(friend: friends[indexPath.row])
    }
    
    func friendsLoad() {
        let defaults = UserDefaults.standard
        guard let savedData =  defaults.data(forKey: "Friends") else {
            return
        }
        let decoder = JSONDecoder()
        guard let savedFriends = try? decoder.decode([Friend].self, from: savedData) else {
            return
        }
        friends = savedFriends
    }
    
    func friendsSave() {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        
        guard let savedData =  try? encoder.encode(friends) else {
            fatalError("Unable to encode")
        }
        defaults.set(savedData, forKey: "Friends")
    }
    
    @objc func friendAdd() {
        let friend = Friend()
        friends.append(friend)
        tableView.insertRows(at: [IndexPath(row: friends.count - 1, section: 0)], with: .automatic)
        friendsSave()
        selFriend = friends.count - 1
        coordinator?.configure(friend: friend)
    }
    
    func updater(friend: Friend) {
        guard let selFriend = selFriend else { return }
        friends[selFriend] = friend
        tableView.reloadData()
        friendsSave()
    }
 
}
