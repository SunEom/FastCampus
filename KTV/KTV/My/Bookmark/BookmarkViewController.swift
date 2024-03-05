//
//  BookmarkViewController.swift
//  KTV
//
//  Created by 엄태양 on 3/5/24.
//

import UIKit

class BookmarkViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    private let viewModel: BookmarkViewModel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(
            UINib(nibName: BookmarkCell.identifier, bundle: nil),
            forCellReuseIdentifier: BookmarkCell.identifier
        )
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        bindViewModel()
        viewModel.requestData()
        
    }
    
    private func bindViewModel() {
        self.viewModel.dataChanged = { [weak self] in
            self?.tableView.reloadData()
        }
    }

}

extension BookmarkViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.channels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: BookmarkCell.identifier,
            for: indexPath
        )
        
        guard let cell = cell as? BookmarkCell,
              let item = viewModel.channels?[indexPath.row]
        else { return UITableViewCell() }
        
        cell.setData(item)
        
        return cell
    }
}
