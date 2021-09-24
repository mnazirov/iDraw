//
//  ViewController.swift
//  iDraw
//
//  Created by Marat on 23.09.2021.
//

import UIKit

class CanvasViewController: UIViewController {
    
    private let canvas = Canvas()

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCanvas()
    }
    
    private func setCanvas() {
        view.addSubview(canvas)
        canvas.backgroundColor = .white
    }
    
    override func viewWillLayoutSubviews() {
        canvas.frame = view.frame
    }
}

