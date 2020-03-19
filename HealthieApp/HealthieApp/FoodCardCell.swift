//
//  FoodCardCell.swift
//  HealthieApp
//
//  Created by Guillermo Hernandez on 3/14/20.
//  Copyright © 2020 Guillermo Hernandez. All rights reserved.
//

import UIKit
import VerticalCardSwiper

class FoodCardCell: CardCell {
    override func prepareForReuse() {
        super.prepareForReuse()

    }

    override func layoutSubviews() {

        self.layer.cornerRadius = 12
        super.layoutSubviews()
    }
}
