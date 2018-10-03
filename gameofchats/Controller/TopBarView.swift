//
//  TopBarView.swift
//  gameofchats
//
//  Created by dev-mac on 2018/10/03.
//  Copyright © 2018 lara-bell. All rights reserved.
//

import UIKit

class TopBarView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    // https://qiita.com/KikurageChan/items/f42f8e687888ee944c35
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 150, height: 36)
    }
}
