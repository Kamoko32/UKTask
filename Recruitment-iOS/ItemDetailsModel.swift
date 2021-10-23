//
//  ItemDetailsModel.swift
//  UKiOSTest
//
//  Created by Paweł Sporysz on 15.09.2016.
//  Copyright © 2016 Paweł Sporysz. All rights reserved.
//

import UIKit

struct ItemDetailsModelNetwork: Codable {
    let name: String
    let color: String
    let desc: String
}

struct ItemDetailsModel {
    let name: String
    let color: UIColor
    var desc: String
}
