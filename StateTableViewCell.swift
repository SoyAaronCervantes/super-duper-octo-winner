//
//  StateTableViewCell.swift
//  PetCens
//
//  Created by Aarón Cervantes Álvarez on 23/04/21.
//

import UIKit

class StateTableViewCell: UITableViewCell {

  @IBOutlet weak var name: UILabel!

  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
