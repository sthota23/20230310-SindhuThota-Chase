//
//  SindhuWeatherTaskTests.swift
//  SindhuWeatherTaskTests
//
//  Created by Sindhu Thota on 10/03/23.
//

import XCTest
@testable import SindhuWeatherTask

final class SindhuWeatherTaskTests: XCTestCase {

    var vc: WeatherDetailsViewController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func setUp() {
        vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WeatherDetailsViewController") as? WeatherDetailsViewController
               _ = vc.view
        let mockApiManager = MockAPIManager.sharedManager
        vc.viewModel = WeatherDetailsViewModel(apimanager: mockApiManager)
    }
   
    func testCityWeatherDetails() {
        XCTAssertNotNil(self.vc.viewModel.apiManager)
        vc.viewModel.getCityWeatherDetails(cityName: "texas") { status, error in
            XCTAssertTrue(status)
            XCTAssertNotNil(self.vc.viewModel.coordinate)
        }
    }
    
    func testCoodinatesWeatherDetails() {
        let coodinates = Coord(lon: 25.00, lat: 36.00)
        vc.viewModel.updateCoordinateLocation(location: coodinates)
        let sysLocation = Sys(type: 1, id: 2, country: "US", sunrise: 9, sunset: 6)
        XCTAssertNotNil(self.vc.viewModel.coordinate)
        vc.viewModel.getWeatherResults { status, error in
            XCTAssertTrue(status)
            XCTAssertNotNil(self.vc.viewModel.weatherData)
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
