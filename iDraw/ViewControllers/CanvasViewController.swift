//
//  ViewController.swift
//  iDraw
//
//  Created by Marat on 23.09.2021.
//

import UIKit

class CanvasViewController: UIViewController {
    
    // MARK: - Properties UI Elements
    private let canvas = Canvas()
    private let cleanButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clean", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(cleanButtonPressed), for: .touchUpInside)
        
        return button
    }()
    private let undoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Undo", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(undoButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    private let stackView = UIStackView()

    // MARK: - Life Cycle
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCanvas()
        setStackView()
    }
    
    override func viewWillLayoutSubviews() {
        canvas.frame = view.frame
    }
    
    // MARK: - Setting up the UI
    private func setCanvas() {
        view.addSubview(canvas)
        canvas.backgroundColor = .white
    }
    
    private func setStackView() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(cleanButton)
        stackView.addArrangedSubview(undoButton)
        
        stackView.distribution = .fillEqually
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func cleanButtonPressed() {
        canvas.cleanLines()
    }
    
    @objc private func undoButtonPressed() {
        canvas.undoLine()
    }
}

