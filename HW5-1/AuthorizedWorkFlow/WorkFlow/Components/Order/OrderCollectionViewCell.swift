//
//  OrderCollectionViewCell.swift
//  HW5-1
//
//  Created by zalkarbek on 10/5/23.
//

import UIKit
import SnapKit

class OrderCollectionViewCell: UICollectionViewCell {
    
    static var reuseID = String(describing: OrderCollectionViewCell.self)
    
    private lazy var orderImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var orderNameLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: Constants.Font.fontSize16)
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.addArrangedSubview(orderImageView)
        view.addArrangedSubview(orderNameLabel)
        view.distribution = .fill
        view.axis = .horizontal
        view.spacing = Constants.Padding.padding12
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUp()
        backgroundColor = .red
    }
    
    private func setUp() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func displayOrder(item: OrderModel) {
        orderImageView.image = item.img
        orderNameLabel.text = item.lbl
    }
    
    
}
