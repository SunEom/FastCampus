//
//  FavoriteViewController.swift
//  KTV
//
//  Created by 엄태양 on 3/5/24.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    private var viewModel: FavoriteViewModel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(
            UINib(nibName: VideoItemCell.identifier, bundle: nil),
            forCellReuseIdentifier: VideoItemCell.identifier
        )
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        bindViewModel()
        self.viewModel.requestData()
        
    }
    
    private func bindViewModel() {
        self.viewModel.dataChanged = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return VideoItemCell.height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: VideoItemCell.identifier,
            for: indexPath
        )
        
        guard let cell = cell as? VideoItemCell,
              let data = viewModel.list?[indexPath.row]
        else { return UITableViewCell() }
        
        cell.setData(data, rank: nil)
        
        return cell
    }
}
