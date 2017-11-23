//
//  AdvancedViewController.swift
//  RxDemo
//
//  Created by Frederik Jacques on 21/11/2017.
//  Copyright © 2017 the-nerd. All rights reserved.
//

import UIKit

import RxSwift
import RxSwiftExt
import RxCocoa

class GitHubViewController: UIViewController {
    
    // MARK: - Properties
    // MARK: Public Properties
        
    // MARK: Private Properties
    private let viewModel = GitHubViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: UI Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Life-cycle methods
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupView()
        setupRx()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear( animated )
        
        viewModel.inputs.getRepositories()
        
    }
    
    // MARK: - Public methods
    
    // MARK: - Private methods
    private func setupView() {
        
        title = "GitHub Repos"
        
    }
    
    private func setupRx() {
        
        searchBar.rx.value
            .throttle( 2, scheduler: MainScheduler.instance )
            .unwrap()
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] (query) in

                self?.viewModel.inputs.changed( searchQuery: query )

            }).disposed(by: disposeBag )
        
        viewModel.outputs.repositoriesObservable.asObservable()
            .bind( to: tableView.rx.items(cellIdentifier: "RepositoryCell") ) { index, repository, cell in
            
            cell.textLabel?.text = repository.fullName
            
        }.disposed(by: disposeBag )
        
    }
    
}
