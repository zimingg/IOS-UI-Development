//
//  ChatTableViewCell.swift
//  iOSTest
//
//  Created by App Partner on 1/22/18.
//  Copyright © 2018 AppPartner. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Setup cell to match mockup
     *
     * 2) Include user's avatar image
     **/
    
    // MARK: - Outlets
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet var avatar: UIImageView!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        avatar.layer.borderWidth = 0
        avatar.layer.masksToBounds = false
        avatar.layer.cornerRadius = avatar.frame.height/2
        avatar.clipsToBounds = true
    }
    
    // MARK: - Public
    func setCellData(message: NewMessage) {
        header.text = message.username
        body.text = message.message
        let url = URL(string: message.avatar_url!)
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        avatar.image = UIImage(data: data!)
        }
       
    }

