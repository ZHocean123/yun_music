//
//  PlaySlider.swift
//  yun_music
//
//  Created by yang on 16/11/2017.
//  Copyright © 2017 ocean. All rights reserved.
//

import UIKit

class PlaySlider: UIControl {

    private let leftLabel = UILabel()
    private let rightLabel = UILabel()
    private let progressBar = CALayer()
    private let progressBgBar = CALayer()
    private let slideImage = UIImageView()

    var progress: CGFloat = 0
    var downloadProgress: CGFloat {
        get {
            return innerDownloadProgress
        }
        set {
            self.setDownloadProgress(newValue, animation: true)
        }
    }

    private var innerDownloadProgress: CGFloat = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }

    private func commonInit() {
        backgroundColor = UIColor.clear
        addSubview(leftLabel)
        addSubview(rightLabel)
        layer.addSublayer(progressBgBar)
        layer.addSublayer(progressBar)
        addSubview(slideImage)
        progressBgBar.contents = #imageLiteral(resourceName: "cm2_fm_playbar_bg").cgImage
        progressBar.contents = #imageLiteral(resourceName: "cm2_fm_playbar_ready").cgImage
        slideImage.image = #imageLiteral(resourceName: "cm2_fm_playbar_btn")
        slideImage.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        leftLabel.frame = CGRect(x: 0, y: 0, width: 50, height: 25)
        progressBgBar.frame = CGRect(x: 50, y: 11.5, width: bounds.width - 100, height: 2)
        progressBar.frame = CGRect(x: 50, y: 11.5, width: (bounds.width - 100) * innerDownloadProgress, height: 2)
        slideImage.center = CGPoint(x: (bounds.width - 100) * progress + 50, y: 12.5)
        rightLabel.frame = CGRect(x: bounds.width - 50, y: 0, width: 100, height: 25)
    }

    func setDownloadProgress(_ progress: CGFloat, animation: Bool = false) {
        if animation {
            self.innerDownloadProgress = progress
            CATransaction.begin()
            CATransaction.setDisableActions(false)
//            CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear))
            CATransaction.setAnimationDuration(0.5)
            progressBar.frame = CGRect(x: 50, y: 11.5, width: (bounds.width - 100) * innerDownloadProgress, height: 2)
            CATransaction.commit()
        } else {
            self.innerDownloadProgress = progress
            progressBar.frame = CGRect(x: 50, y: 11.5, width: (bounds.width - 100) * innerDownloadProgress, height: 2)
        }
    }

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let point = touch.location(in: self)
        if slideImage.frame.contains(point) {
            return true
        }
        return super.beginTracking(touch, with: event)
    }

    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let point = touch.location(in: self)
        let centerX = min(max(point.x, 50), bounds.width - 50)
        self.progress = (centerX - 50) / (bounds.width - 100)
        slideImage.center = CGPoint(x: centerX, y: 12.5)
        return super.continueTracking(touch, with: event)
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        if let touch = touch {
            let point = touch.location(in: self)
            let centerX = min(max(point.x, 50), bounds.width - 50)
            self.progress = (centerX - 50) / (bounds.width - 100)
            slideImage.center = CGPoint(x: centerX, y: 12.5)
        }
        self.sendActions(for: .valueChanged)
        super.endTracking(touch, with: event)
    }

    override func cancelTracking(with event: UIEvent?) {
        super.cancelTracking(with: event)
    }
}
