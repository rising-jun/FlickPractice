//
//  MainController.swift
//  FlickPractice
//
//  Created by 김동준 on 2020/05/20.
//  Copyright © 2020 김동준. All rights reserved.
//
import UIKit
import RxCocoa
import RxSwift
import SnapKit

class MainController: UIViewController {
    let backButton = UIButton()
    let imageView = UIImageView()
    let networkLabel = UILabel()
    var uiImageList: Array<UIImage> = []
    var imageList: Array<String> = []
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
    var sec: Int = 0
    let disposeBag = DisposeBag()
    var secDisposeBag = DisposeBag()
    func setImageList(imageList: Array<String>) {
        self.imageList = imageList
    }
    
    func setRowNum(sec: Int) {
        self.sec = sec
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let mainUiDrawing = MainUiDrawing(view: self.view)
        mainUiDrawing.btnSetting(button: backButton)
        mainUiDrawing.pickerSetting(picker: secPic)
        mainUiDrawing.imageSetting(imageview: imageView)
        mainUiDrawing.nLabelSetting(label: networkLabel)
        
        secPic.selectRow((sec - 1), inComponent: 0, animated: true)
        
        let backEvent = BackButtonEvent(viewController: self)
        backButton.rx.tap.bind {[] in
            backEvent.onTabed()
        }.disposed(by: disposeBag)
        
        var _: Int = 0
        for idx in 0...imageList.count-1 {
            let url = URL(string: imageList[idx])!
            if let data = try? Data(contentsOf: url){
                let image = UIImage(data: data)
                self.uiImageList.append(image!)
            }
        }
        
//        let slideImage = ImageSlide(uiImageList: uiImageList, imageView: imageView)
//        slideImage.slideShow(sec: self.sec)
        
        Observable.zip(Observable.from(self.uiImageList), Observable<Int>.interval(RxTimeInterval.seconds(self.sec), scheduler: MainScheduler.instance))
        .map{$0.0 }
        .subscribe(onNext: { (image) in
        self.imageView.image = image
        }).disposed(by: self.secDisposeBag)
        
        secPic.rx.itemSelected.debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe{(event) in
                self.sec = (event.element!.row) + 1
                    print("no change \((event.element!.row) + 1)")
                    self.secDisposeBag = DisposeBag()
                    Observable.zip(Observable.from(self.uiImageList), Observable<Int>.interval(RxTimeInterval.seconds(self.sec), scheduler: MainScheduler.instance))
                    .map{$0.0 }
                    .subscribe(onNext: { (image) in
                    self.imageView.image = image
                    }).disposed(by: self.secDisposeBag)
            }.disposed(by: self.disposeBag)
        
    }
    
}

extension MainController: UIPickerViewDelegate, UIPickerViewDataSource {
func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
    
} // Data source method that returns the number of rows to display in the picker. // (Implementation required)

func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickArray.count
    
}
// Delegate method that returns the value to be displayed in the picker.
func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    sec = pickArray[row]
    return String(pickArray[row])
    
} // A method called when the picker is selected.

}
