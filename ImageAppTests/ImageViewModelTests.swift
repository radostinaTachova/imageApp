//
//  ImageViewModelTests.swift
//  ImageAppTests
//
//  Created by Radostina Tachova Chergarska on 12/11/23.
//

import XCTest
@testable import ImageApp


final class ImageViewModelTests: XCTestCase {

    var viewModel: ImageViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let fakeRepository = FakeImageRepository(images: TestsData.images)
        viewModel = ImageViewModel(fakeRepository)
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }

    func testUpdateImagesSuccessfully() throws {
        let expectation = self.expectation(description: "waiting images")
        
        let subscriber = viewModel.$images.sink(receiveValue: { updatedImages in
            guard !updatedImages.isEmpty else { return }
            expectation.fulfill()
        })
        viewModel.updateImages()
        wait(for: [expectation])
        XCTAssertEqual(viewModel.images, TestsData.images)
    }
    
    func testAddImageSuccessfully() throws {
        let expectation = self.expectation(description: "waiting images")
        let nImages = viewModel.images.count
        let subscriber = viewModel.$images.sink(receiveValue: { updatedImages in
            guard !updatedImages.isEmpty else { return }
            expectation.fulfill()
        })
        viewModel.uploadImage(base64: "someimage")
        wait(for: [expectation])
        
        XCTAssertEqual(nImages + 1, viewModel.images.count)
    }

}
