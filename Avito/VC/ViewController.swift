//
//  ViewController.swift
//  Avito
//
//  Created by Максим Клочков on 03.05.2022.
//

import UIKit

class ViewController: UIViewController {

    private var model: Server?
    private let reachability = try! Reachability()
    private var storageManager = StorageManager()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.register(ErrorTableViewCell.self, forCellReuseIdentifier: ErrorTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        networkErrors()
        model = storageManager.loadServer()
        loadDataFromServer()
    }

    deinit {
        reachability.stopNotifier()
    }

    private func networkErrors() {
        DispatchQueue.main.async {
            self.reachability.whenUnreachable = { _ in
                print("Not reachable")
                let networkVC = NetworkErrorViewController()
                self.present(networkVC, animated: true)
            }

            do {
                try self.reachability.startNotifier()
            } catch {
                print("Unable to start notifier")
            }
        }
    }

    private func layout() {
        self.view.backgroundColor = .white

        [tableView].forEach({ self.view.addSubview($0)})

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }

    private func loadDataFromServer() {

        guard model == nil else { return }

        guard let url = URL(string: "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in

            guard let data = data, error == nil else { return }

            do {
                var currentServer = try JSONDecoder().decode(Server.self, from: data)
                currentServer.company.employees = currentServer.company.employees.sorted(by: { $0.name < $1.name} )

                self.storageManager.saveServer(currentServer)
                self.model = currentServer
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            } catch {
                self.model = nil
                print("Something went wrong.")
            }
            
        }.resume()
    }
}

extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let employeesCount = model?.company.employees.count else { return 1 }
        return employeesCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if model != nil {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }

            guard let unwrappingEmployees = model?.company.employees else { return UITableViewCell() }

            cell.configure(model: unwrappingEmployees[indexPath.row])
            cell.selectionStyle = .none
            cell.separatorInset = .init(top: 0, left: 16, bottom: 0, right: 16)
            return cell

        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ErrorTableViewCell.identifier, for: indexPath) as? ErrorTableViewCell else { return UITableViewCell() }
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        1
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderView()
        guard let unwrappingCompany = model?.company else { return UIView() }
        header.configure(model: unwrappingCompany)
        return header
    }
}
