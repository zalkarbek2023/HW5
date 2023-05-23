//
//  Extensions+ViewController.swift
//  HW5-1
//
//  Created by zalkarbek on 17/5/23.
//

import UIKit

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
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: StatusCollectionViewCell.reuseID,
                    for: indexPath) as? StatusCollectionViewCell else { fatalError() }
                
                let status = statusArray[indexPath.row]
                cell.displayStatus(item: status)
                if !statusArray[indexPath.row].isSelected {
                    cell.backgroundColor = .white
                } else {
                    cell.backgroundColor = .yellow
                }
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
            if collectionView == statusCollectionView {
                if !statusArray[indexPath.row].isSelected {
                    for item in 0..<statusArray.count {
                        statusArray[item].isSelected = false
                    }
                    statusArray[indexPath.row].isSelected = true
                    statusCollectionView.reloadData()
                } else {
                    statusArray[indexPath.row].isSelected = false
                    statusCollectionView.reloadData()
                }
            } else {
                
            }
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
