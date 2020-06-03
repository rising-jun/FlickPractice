//
//  UiDraw.swift
//  FlickPractice
//
//  Created by 김동준 on 2020/05/19.
//  Copyright © 2020 김동준. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol DefalutViewUI {
    func btnSetting(button: UIButton)
    func pickerSetting(picker: UIPickerView)
    func nLabelSetting(label: UILabel)
}

protocol MainViewUI: DefalutViewUI{
    func imageSetting(imageview: UIImageView)
}

struct StartUiDrawing: DefalutViewUI {
    var view: UIView
    init(view: UIView) {
        self.view = view
    }

    func pickerSetting(picker: UIPickerView) {
        
        self.view.addSubview(picker)
        picker.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view).offset(250)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-100)
                make.leading.equalTo(self.view.safeAreaLayoutGuide).offset(30)
                make.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-30)                
            } else {
                make.top.equalTo(self.view).offset(250)
                make.bottom.equalTo(self.view).offset(-100)
                make.leading.equalTo(self.view).offset(30)
                make.trailing.equalTo(self.view).offset(-30)
            }
        }
    }
    
    func btnSetting(button: UIButton) {
        button.setTitle("start", for: .normal)
        button.backgroundColor = .black
        self.view.addSubview(button)
        button.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide).offset(700)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-50)
                make.leading.equalTo(self.view.safeAreaLayoutGuide).offset(30)
                make.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-30)
            } else {
                make.top.equalTo(self.view).offset(650)
                make.bottom.equalTo(self.view).offset(-100)
                make.leading.equalTo(self.view).offset(30)
                make.trailing.equalTo(self.view).offset(-30)
            }
        }
    }
    
    func nLabelSetting(label: UILabel){
        self.view.addSubview(label)
        label.textColor = .black
        label.text = Util().checkNetwork()
        label.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
                make.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-10)
                make.width.equalTo(100)
                make.height.equalTo(30)
            } else {
                make.top.equalTo(self.view).offset(10)
                make.bottom.equalTo(self.view).offset(-10)
                make.width.equalTo(30)
                make.height.equalTo(100)
            }
        }
        
    }
}

struct MainUiDrawing: MainViewUI {
    func nLabelSetting(label: UILabel) {
        self.view.addSubview(label)
        label.textColor = .black
        label.text = Util().checkNetwork()
        label.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
                make.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-10)
                make.width.equalTo(100)
                make.height.equalTo(30)
            } else {
                make.top.equalTo(self.view).offset(10)
                make.bottom.equalTo(self.view).offset(-10)
                make.width.equalTo(30)
                make.height.equalTo(100)
            }
        }
    }
    
    func imageSetting(imageview: UIImageView) {
        self.view.addSubview(imageview)
        imageview.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view).offset(250)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-100)
                make.leading.equalTo(self.view.safeAreaLayoutGuide).offset(30)
                make.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-30)
            } else {
                make.bottom.equalTo(self.view).offset(-100)
                make.leading.equalTo(self.view).offset(30)
                make.trailing.equalTo(self.view).offset(-30)
            }
        }
    }
    
        var view: UIView
        init(view: UIView) {
            self.view = view
        }
        
        func btnSetting(button: UIButton) {
            self.view.addSubview(button)
            button.setTitle("시작화면으로", for: .normal)
            button.backgroundColor = .black
            button.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide).offset(50)
                make.leading.equalTo(self.view.safeAreaLayoutGuide).offset(50)
                make.width.equalTo(120)
                make.height.equalTo(50)
            } else {
                make.top.equalTo(self.view).offset(50)
                make.bottom.equalTo(self.view).offset(50)
                make.width.equalTo(120)
                make.height.equalTo(50)
                }
            }
        }
        func pickerSetting(picker: UIPickerView) {
            self.view.addSubview(picker)
            picker.snp.makeConstraints { (make) in
                if #available(iOS 11.0, *) {
                    make.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
                    make.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-50)
                    make.width.equalTo(150)
                    make.height.equalTo(100)
                } else {
                    make.top.equalTo(self.view).offset(50)
                    make.bottom.equalTo(self.view).offset(50)
                    make.width.equalTo(120)
                    make.height.equalTo(50)
                }
            }
            
        }
    }

