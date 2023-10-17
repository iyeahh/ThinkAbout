//
//  CategoryListCell.swift
//  ThinkingAbout
//
//  Created by Bora Yang on 2023/10/03.
//

import UIKit

class CategoryListCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var numberOfTaskLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        backView.layer.masksToBounds = true
        backView.layer.cornerRadius = 10
    }
}
