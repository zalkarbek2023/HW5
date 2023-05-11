//
//  ViewController.swift
//  HW5-1
//
//  Created by zalkarbek on 10/5/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private lazy var orderCollectionView: UICollectionView = {
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
    
    private lazy var statusCollectionView: UICollectionView = {
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
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.tableViewCellReuseID)
        return view
    }()
    
    private var orderArray = [
        OrderModel(img: UIImage(systemName: "car")!, lbl: "Delivery", isSelected: false),
        OrderModel(img: UIImage(systemName: "shippingbox")!, lbl: "Pickup", isSelected: false),
        OrderModel(img: UIImage(systemName: "fork.knife")!, lbl: "Catering", isSelected: false),
        OrderModel(img: UIImage(systemName: "rectangle.roundedtop")!, lbl: "Curbside", isSelected: false)
    ]
    
    private var statusArray = [
        StatusModel(name: "Grocery", image: UIImage(named: "grocery")!),
        StatusModel(name: "Convenience", image: UIImage(named: "convenience")!),
        StatusModel(name: "Food", image: UIImage(named: "food")!),
        StatusModel(name: "Pharmacy", image: UIImage(named: "pharmacy")!),
        StatusModel(name: "Skincare", image: UIImage(named: "skincare")!)
    ]
    
    private var viewModel: ViewModel
//     var characters: [RickCharacter] = []
    
    init() {
        viewModel = ViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        viewModel = ViewModel()
        super.init(coder: coder)
    }
    
    private var takeAways = [ProductModel]() {
        didSet {
            filteredTakeAways = takeAways
        }
    }
    private var filteredTakeAways = [ProductModel]()
    
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


}


extension ViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        if collectionView == orderCollectionView {
            return orderArray.count
        } else {
            return statusArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == orderCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: OrderCollectionViewCell.reuseID,
                for: indexPath) as? OrderCollectionViewCell else { fatalError() }
            
            let order = orderArray[indexPath.row]
            cell.displayOrder(item: order)
            if !orderArray[indexPath.row].isSelected {
                cell.backgroundColor = .white
            } else {
                cell.backgroundColor = .yellow
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: StatusCollectionViewCell.reuseID,
                for: indexPath) as? StatusCollectionViewCell else { fatalError() }
            
            let status = statusArray[indexPath.row]
            cell.displayStatus(item: status)
            return cell
        }
        
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView (
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        if collectionView == orderCollectionView {
            return CGSize(width: 150, height: 50)
        } else {
            return CGSize(width: 112, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTakeAways.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductTableViewCell.tableViewCellReuseID,
            for: indexPath) as? ProductTableViewCell else { fatalError() }
        
        let product = filteredTakeAways[indexPath.row]
        cell.displayProduct(item: product)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 380
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
           print("Delete")
        }
    }
}
