//
//  MoreViewController.swift
//  KTV
//
//  Created by 엄태양 on 3/6/24.
//

import UIKit

class MoreViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    private let viewModel: MoreViewModel = .init()
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.modalPresentationStyle = .overFullScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = MoreTableViewCell.height
        self.tableView.register(
            UINib(nibName: MoreTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: MoreTableViewCell.identifier
        )
        
        self.setupConerRadius()

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.setupConerRadius()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate { _ in
            self.setupConerRadius()
        }
        super.viewWillTransition(to: size, with: coordinator)
    }

    @IBAction func closeDidtap(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    private func setupConerRadius() {
        let path = UIBezierPath(
            roundedRect: self.headerView.bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: 13, height: 13)
        )
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.headerView.layer.mask = maskLayer
    }
    
}


extension MoreViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: MoreTableViewCell.identifier,
            for: indexPath
        )
        
        if let cell = cell as? MoreTableViewCell {
            cell.setItem(self.viewModel.items[indexPath.row], separatorHidden: indexPath.row + 1 == self.viewModel.items.count)
        }
        
        return cell
    }
}
