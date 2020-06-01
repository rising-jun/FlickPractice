//
//  ViewController.swift
//  FlickPractice
//
//  Created by 김동준 on 2020/05/18.
//  Copyright © 2020 김동준. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class StartController: UIViewController{
    let startbtn = UIButton()
    let networkLabel = UILabel()
    lazy var pickArray: Array<Int> = []
    lazy var secPic : UIPickerView = {
        let picker = UIPickerView()
        for index in 1...10 {
            pickArray.append(index)
        }
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()
    var selectRow : Int = Int()
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        let startUiDrawing = StartUiDrawing(view: self.view)
        
        startUiDrawing.nLabelSetting(label: networkLabel)
        startUiDrawing.pickerSetting (picker: secPic)
        startUiDrawing.btnSetting(button: startbtn)
        var imagelist: Array<String> = []
        
        startbtn.rx.tap.bind {[weak self] in
            //print(self?.pickArray[(self?.secPic.selectedRow(inComponent: 0))!])
            let startEvent = StartButtonEvent(imageList: imagelist, sec: self?.selectRow ?? 11, vcontroller: self)
            startEvent.onTabed()
            
        }.disposed(by: disposeBag)
        
        let urlString: String = "https://www.flickr.com/services/feeds/photos_public.gne?tags=seoul&format=json&nojsoncallback=1"
       URLSession.shared.rx.json(url: URL(string: urlString)!).map { (any) in
        let json = any as? [String: Any]
        if let items = json?["items"] as? [[String:Any]] {
            for item in items {
                let factor = item["description"] as? String ?? "??"
                let regex = try? NSRegularExpression(pattern: "(http|https|ftp|telnet|news|irc)://([-/.a-zA-Z0-9_]+).jpg", options:.caseInsensitive)
                let textToNs = factor as NSString
                regex?.matches(in: factor, options: [], range: NSRange(location: 0, length: textToNs.length)).map {
                    imagelist.append(textToNs.substring(with: $0.range))
                }
            }
        }
       }.subscribe(onNext: { () in
            print(imagelist)
        }).disposed(by: disposeBag)
    }
   
}

extension StartController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    } // Data source method that returns the number of rows to display in the picker. // (Implementation required)

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickArray.count
        
    }
    // Delegate method that returns the value to be displayed in the picker.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        selectRow = pickArray[row]
        return String(pickArray[row])
        
    } // A method called when the picker is selected.

}
