//
//  UIControl+Target.swift
//  yun_music
//
//  Created by yang on 22/11/2017.
//  Copyright © 2017 ocean. All rights reserved.
//

import UIKit

protocol TargetAction {
    func performAction()
}

struct TargetActionWrapper<T: AnyObject>: TargetAction {

    weak var target: T?
    let action: (T) -> () -> ()

    func performAction() {
        if let t = target {
            action(t)()
        }
    }
}

enum ControlEvent {
    case touchUpInside
    case valueChanged
}

class Control {
    var actions = [ControlEvent: TargetAction]()
    func setTarget<T:AnyObject>(target: T, action: @escaping (T) -> () -> (), controlEvent: ControlEvent) {
        actions[controlEvent] = TargetActionWrapper(target: target, action: action)
    }
    
    func removeTargetForControlEvent(controlEvent: ControlEvent) {
        actions[controlEvent] = nil
    }
    
    func performActionForControlEvent(controlEvent: ControlEvent) {
        actions[controlEvent]?.performAction()
    }
}

class EViewController: UIViewController {
    let control = Control()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        control.setTarget(target: self, action: EViewController.onBtn, controlEvent: .touchUpInside)
    }
    
    func onBtn() {
        
    }
}
