//
//  StatusCollectionViewCell.swift
//  HW5-1
//
//  Created by zalkarbek on 10/5/23.
//

import UIKit

class StatusCollectionViewCell: UICollectionViewCell {
    
    static var reuseID = String(describing: StatusCollectionViewCell.self)
    
     lazy var statusImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
     lazy var statusNameLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: Constants.Font.fontSize16)
        return view
    }()
    
     lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.addArrangedSubview(statusImageView)
        view.addArrangedSubview(statusNameLabel)
        view.distribution = .equalSpacing
        view.axis = .vertical
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
    
    func displayStatus(item: StatusModel) {
        statusImageView.image = item.image
        statusNameLabel.text = item.name
    }

    
}
