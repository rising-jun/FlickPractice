//
//  MainUiEvent.swift
//  FlickPractice
//
//  Created by 김동준 on 2020/05/20.
//  Copyright © 2020 김동준. All rights reserved.
//

import Foundation
import UIKit

protocol StartEvent {
    func onTabed()
}
protocol BackEvent{
    func onTabed()
}

struct StartButtonEvent: StartEvent {
    var imageList: Array<String>
    var sec: Int
    var vcontroller: UIViewController
    init(imageList : Array<String>, sec : Int, vcontroller : UIViewController?) {
        self.imageList = imageList
        self.sec = sec
        self.vcontroller = vcontroller!
    }
    func onTabed() {
        //start버튼 터치시
        let mainController = MainController()
        mainController.setImageList(imageList: imageList)
        mainController.setRowNum(sec: sec)
        vcontroller.present(mainController, animated: true)
    }
}

struct BackButtonEvent: BackEvent {
    var viewController: MainController
    init(viewController: MainController){
        self.viewController = viewController
    }
    func onTabed() {
        viewController.dismiss(animated: true, completion: {})
    }
}
