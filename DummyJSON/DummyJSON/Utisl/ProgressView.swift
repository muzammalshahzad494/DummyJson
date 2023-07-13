//
//  ProgressView.swift
//  DummyJSON
//
//  Created by Muzammal Shahzad on 6/26/23.
//

import UIKit


class CustomProgressView: UIView {
    private var progressView: UIProgressView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProgressView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupProgressView()
    }
    
    private func setupProgressView() {
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(progressView)
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: topAnchor),
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 2.0)
        ])
        
        progressView.progress = 0.0
    }
    
    func show() {
        isHidden = false
    }
    
    func hide() {
        isHidden = true
    }
    
    func updateProgress(_ progress: Float) {
        progressView.progress = progress
    }
    
    func resetProgress() {
        progressView.progress = 0.0
    }
}
