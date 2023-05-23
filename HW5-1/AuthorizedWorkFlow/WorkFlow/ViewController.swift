//
//  ViewController.swift
//  HW5-1
//
//  Created by zalkarbek on 10/5/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    lazy var orderCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 300, height: 300)
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.register(
            OrderCollectionViewCell.self,
            forCellWithReuseIdentifier:
                OrderCollectionViewCell.reuseID)
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        return view
    }()
    
     lazy var statusCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = .init(width: 300, height: 300)
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.register(
           StatusCollectionViewCell.self,
            forCellWithReuseIdentifier:
                StatusCollectionViewCell.reuseID)
        view.backgroundColor = .clear
        return view
    }()
    
     lazy var tableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.tableViewCellReuseID)
        return view
    }()
    
     var orderArray = [
        OrderModel(img: UIImage(systemName: "car")!, lbl: "Delivery"),
        OrderModel(img: UIImage(systemName: "shippingbox")!, lbl: "Pickup"),
        OrderModel(img: UIImage(systemName: "fork.knife")!, lbl: "Catering"),
        OrderModel(img: UIImage(systemName: "rectangle.roundedtop")!, lbl: "Curbside")
    ]
    
    var statusArray = [
        StatusModel(name: "Grocery", image: UIImage(named: "grocery")!, isSelected: false),
        StatusModel(name: "Convenience", image: UIImage(named: "convenience")!, isSelected: false),
        StatusModel(name: "Food", image: UIImage(named: "food")!, isSelected: false),
        StatusModel(name: "Pharmacy", image: UIImage(named: "pharmacy")!, isSelected: false),
        StatusModel(name: "Skincare", image: UIImage(named: "skincare")!, isSelected: false)
    ]
    
     var viewModel: ViewModel
    var statusType = [StatusModel]()
    
    init() {
        viewModel = ViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        viewModel = ViewModel()
        super.init(coder: coder)
    }
    
     var takeAways = [ProductModel]() {
        didSet {
            filteredTakeAways = takeAways
        }
    }
     var filteredTakeAways = [ProductModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        configureProductArray()
    }
    
    private func configureProductArray() {
        Task {
            do {
                self.filteredTakeAways = try await viewModel.fetchProducts()
                self.tableView.reloadData()
            }
        }
    }
    
    private func setUp() {
        view.backgroundColor = .red
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        view.addSubview(orderCollectionView)
        orderCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(60)
            make.left.equalTo(view.snp.left).offset(10)
            make.right.equalTo(view.snp.right).offset(-10)
            make.bottom.equalTo(view.snp.bottom).offset(-800)
        }
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(orderCollectionView.snp.top).offset(80)
            make.left.equalTo(view.snp.left).offset(10)
            make.right.equalTo(view.snp.right).offset(-10)
            make.bottom.equalTo(view.snp.bottom).offset(-730)
        }
        view.addSubview(statusCollectionView)
        statusCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.top).offset(80)
            make.left.equalTo(view.snp.left).offset(10)
            make.right.equalTo(view.snp.right).offset(-10)
            make.bottom.equalTo(view.snp.bottom).offset(-600)
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(statusCollectionView.snp.top).offset(150)
            make.left.equalTo(view.snp.left).offset(10)
            make.right.equalTo(view.snp.right).offset(-10)
            make.bottom.equalTo(view.snp.bottom).offset(-10)
        }
        
    }
    
    private func configureCategoryArrays(indexPath: IndexPath) {
        let category = statusArray[indexPath.row].name.lowercased()
        filteredTakeAways = takeAways.filter { $0.category == category }
    }


}
