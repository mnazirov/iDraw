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
    
    private let colorButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Color", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(colorButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    private let slider: UISlider = {
        let slider = UISlider()
        
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.addTarget(self, action: #selector(handleLineWidth), for: .valueChanged)
        
        return slider
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
        stackView.addArrangedSubview(colorButton)
        stackView.addArrangedSubview(slider)
        
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func cleanButtonPressed() {
        canvas.cleanLines()
    }
    
    @objc private func undoButtonPressed() {
        canvas.undoLine()
    }
    
    @objc private func colorButtonPressed() {
        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        
        present(colorPickerVC, animated: true)
    }
    
    @objc private func handleLineWidth() {
        canvas.changeLineWidth(width: slider.value)
    }
}

extension CanvasViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        canvas.discolorationLine(color: color)
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        canvas.discolorationLine(color: color)
    }
}
