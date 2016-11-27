//
//  ViewTeamsPrototypeCell.swift
//  FanimeWarMapV2
//
//  Created by Jonathan Oh on 11/26/16.
//  Copyright © 2016 Jonathan Oh. All rights reserved.
//

import UIKit

class ViewTeamsPrototypeCell: UITableViewCell {

    @IBOutlet weak var teamIcon: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamMembers: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(icon: UIImage, name: String, members: [String]) {
        self.teamIcon.image = icon
        self.teamName.text = name
        var teamMembersString : String = ""
        for member in members {
            teamMembersString.append("\(member), ")
        }
        self.teamMembers.text = teamMembersString
    }
    

}
