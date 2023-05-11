//
//  ProductTableViewCell.swift
//  HW5-1
//
//  Created by zalkarbek on 10/5/23.
//

import UIKit
import SnapKit
import SDWebImage

class ProductTableViewCell: UITableViewCell {

    static var tableViewCellReuseID = String(describing: ProductTableViewCell.self)
    
    private lazy var productImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: Constants.Font.fontSize16)
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: Constants.Font.fontSize16)
        return view
    }()
    
    private lazy var starImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var ratingLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: Constants.Font.fontSize16)
        return view
    }()
    
    private lazy var priceLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: Constants.Font.fontSize16)
        return view
    }()
    
    private lazy var categoryLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: Constants.Font.fontSize16)
        return view
    }()
    
    private lazy var brandLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: Constants.Font.fontSize16)
        return view
    }()
    
    private lazy var discountLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: Constants.Font.fontSize16)
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.addArrangedSubview(productImageView)
        view.addArrangedSubview(titleLabel)
        view.addArrangedSubview(descriptionLabel)
        view.addArrangedSubview(starImageView)
        view.addArrangedSubview(ratingLabel)
        view.addArrangedSubview(priceLabel)
        view.addArrangedSubview(categoryLabel)
        view.addArrangedSubview(brandLabel)
        view.addArrangedSubview(discountLabel)
        view.distribution = .fillProportionally
        view.axis = .vertical
        view.spacing = Constants.Padding.padding8
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
    
    func displayProduct(item: ProductModel) {
        productImageView.sd_setImage(
           with: .init(
            string: item.images.first ?? ""
           ),
           placeholderImage: .init(systemName: "house")
        )
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        ratingLabel.text = "\(item.rating)"
        priceLabel.text = "\(item.price) $"
        discountLabel.text = "\(item.discountPercentage)"
        brandLabel.text = item.brand
        categoryLabel.text = item.category
    }

}
