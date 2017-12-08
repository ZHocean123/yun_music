//
//  CircleView.swift
//  GitHubClient_Example
//
//  Created by yang on 13/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import pop

class CircleView: UIView {

    public var img: UIImage? {
        didSet {
            self.imageView.image = img
        }
    }
    public var isRuning = false

    public func reset() {
        self.layer.removeAnimation(forKey: animationKey)
    }

    public func resumeAnimation() {
        isRuning = true
        if self.layer.animation(forKey: animationKey) == nil {
            self.layer.add(animation, forKey: animationKey)
        }

        self.layer.resumeAnimation()
    }

    public func pauseAnimation() {
        isRuning = false
        self.layer.pauseAnimation()
    }

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var circleImageView: UIImageView!

    private let animationKey = "animationKey"
    private lazy var animation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0
        animation.toValue = 2 * Float.pi
        animation.repeatCount = Float.greatestFiniteMagnitude
        animation.duration = 3
        return animation
    }()

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }

    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.image = #imageLiteral(resourceName: "cm2_default_cover_play")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        circleImageView.contentMode = .scaleAspectFill
    }

//    func commonInit() {
//        self.addSubview(imageView)
//        self.addSubview(circleImageView)
//
//        self.layer.masksToBounds = true
//
//        imageView.contentMode = .scaleAspectFill
//        imageView.snp.makeConstraints { (make) in
//            make.center.equalTo(self)
//            make.width.equalTo(150)
//            make.height.equalTo(150)
//        }
//        circleImageView.contentMode = .scaleAspectFill
//        circleImageView.snp.makeConstraints { (make) in
//            make.center.equalTo(self)
//            make.width.equalTo(self)
//            make.height.equalTo(self)
//        }
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        self.layer.cornerRadius = self.frame.width / 2
//    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
