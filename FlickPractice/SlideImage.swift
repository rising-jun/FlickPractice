//
//  SlideImage.swift
//  FlickPractice
//
//  Created by 김동준 on 2020/05/25.
//  Copyright © 2020 김동준. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit
struct ImageSlide{
    var uiImageList: Array<UIImage>
    let imageView: UIImageView
    
    init (uiImageList: Array<UIImage>, imageView: UIImageView){
        self.imageView = imageView
        self.uiImageList = uiImageList
    }
    
    func slideShow(sec: Int){
        let disposeBag = DisposeBag()
        Observable.zip(Observable.from(self.uiImageList), Observable<Int>.interval(RxTimeInterval.seconds(sec), scheduler: MainScheduler.instance))
        .map{$0.0 }
        .subscribe(onNext: { (image) in
        self.imageView.image = image
        }).disposed(by: disposeBag)
    }
    
}
