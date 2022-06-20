//
//  MapView.swift
//  WiFi-Map-Test
//
//  Created by Dima Bazhaniuk on 16.06.2022.
//

import UIKit
import SnapKit
import Lottie

class SplashViewMain: UIView {
    
    private let centerImage = UIImageView()
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        addSubviews()
        makeContraints()
        applyAppearance()
    }

    required init?(coder: NSCoder) {
        fatalError("required init?(coder: NSCoder) not implemented")
    }
    
    private func addSubviews() {
       addSubview(centerImage)
    }
    
    private func makeContraints() {
        centerImage.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(250)
        }
    }
    
    private func applyAppearance() {
        self.backgroundColor = .white
        centerImage.contentMode = .scaleAspectFill
        centerImage.image = UIImage(named: "launch")
    }
    
}

