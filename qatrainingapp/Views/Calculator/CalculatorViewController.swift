//
//  CalculatorViewController.swift
//  qatrainingapp
//
//  Created by Neiger Serrano on 19/5/25.
//

import Combine
import UIKit

// MARK: - CalculatorViewController

final class CalculatorViewController: UIViewController {
    // MARK: Internal

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupLabels()
        setupButtons()
        bindViewModel()
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        // Inactivity Timer
        InactivityManager.shared.onTimeout = { [weak self] in
            DispatchQueue.main.async {
                self?.logout()
            }
        }
        InactivityManager.shared.start()
    }

    @objc func logout() {
        InactivityManager.shared.stop()
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
    }

    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    // MARK: Private

    private let viewModel: CalculatorViewModel = .init()
    private var cancellables: Set<AnyCancellable> = .init()

    private let inputLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 68)
        label.textColor = .white
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let outputLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 36)
        label.textColor = .white
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var buttons: [[(title: String, action: () -> Void)]] = [
        [
            ("AC", { self.viewModel.clear() }),
            ("+/-", { self.viewModel.toggleSign() }),
            ("%", { self.viewModel.setOperation(.percent) }),
            ("/", { self.viewModel.setOperation(.divide) }),
        ],
        [
            ("7", { self.viewModel.handleInput("7") }),
            ("8", { self.viewModel.handleInput("8") }),
            ("9", { self.viewModel.handleInput("9") }),
            ("*", { self.viewModel.setOperation(.multiply) }),
        ],
        [
            ("4", { self.viewModel.handleInput("4") }),
            ("5", { self.viewModel.handleInput("5") }),
            ("6", { self.viewModel.handleInput("6") }),
            ("-", { self.viewModel.setOperation(.subtract) }),
        ],
        [
            ("1", { self.viewModel.handleInput("1") }),
            ("2", { self.viewModel.handleInput("2") }),
            ("3", { self.viewModel.handleInput("3") }),
            ("+", { self.viewModel.setOperation(.add) }),
        ],
        [
            ("0", { self.viewModel.handleInput("0") }),
            (".", { self.viewModel.handleInput(".") }),
            ("=", { self.viewModel.calculate() }),
        ],
    ]

    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Back", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private func setupLabels() {
        view.addSubview(backButton)
        view.addSubview(outputLabel)
        view.addSubview(inputLabel)

        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            outputLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            outputLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            inputLabel.topAnchor.constraint(equalTo: outputLabel.bottomAnchor, constant: 12),
            inputLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])
    }

    private func setupButtons() {
        let buttonStack = UIStackView()
        buttonStack.axis = .vertical
        buttonStack.spacing = 12
        buttonStack.translatesAutoresizingMaskIntoConstraints = false

        for row in buttons {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 12
            rowStack.distribution = .fillEqually

            for item in row {
                let button = UIButton(type: .system)
                button.setTitle(item.title, for: .normal)
                button.titleLabel?.font = .systemFont(ofSize: 28)
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = item.title.isOperator ? .orange : .darkGray
                button.layer.cornerRadius = 40
                button.clipsToBounds = true
                button.heightAnchor.constraint(equalToConstant: 80).isActive = true

                button.addAction(UIAction(handler: { _ in item.action() }), for: .touchUpInside)

                rowStack.addArrangedSubview(button)
            }

            buttonStack.addArrangedSubview(rowStack)
        }

        view.addSubview(buttonStack)

        NSLayoutConstraint.activate([
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            buttonStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
        ])
    }

    private func bindViewModel() {
        viewModel.$input
            .receive(on: DispatchQueue.main)
            .map { Optional($0) } // or { $0 as String? }
            .assign(to: \.text, on: inputLabel)
            .store(in: &cancellables)

        viewModel.$output
            .receive(on: DispatchQueue.main)
            .map { Optional($0) }
            .assign(to: \.text, on: outputLabel)
            .store(in: &cancellables)
    }
}

private extension String {
    var isOperator: Bool {
        return ["+", "-", "*", "/", "%", "="].contains(self)
    }
}
