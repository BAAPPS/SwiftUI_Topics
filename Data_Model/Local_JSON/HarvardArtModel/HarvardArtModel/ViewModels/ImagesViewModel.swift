//
//  ImagesViewModel.swift
//  HarvardArtModel
//
//  Created by D F on 9/7/25.
//

import Foundation

@Observable
class ImagesViewModel {
    private(set) var images: [ImageModel] = []
    private(set) var info: ImagesModel.Info?
    
    init(){
        loadImages()
    }
    
    
    private func loadImages() {
        let response: ImagesModel = Bundle.main.decode("Images.json")
        self.images = response.records
        self.info = response.info
    }
    
    var exampleImage: ImageModel {
        images.first! 
    }}
