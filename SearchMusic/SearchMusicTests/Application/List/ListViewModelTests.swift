//
//  ListViewModelTests.swift
//  SearchMusicTests
//
//  Created by Albert Gil Escura on 22/2/21.
//

import XCTest
@testable import SearchMusic
import RxTest
import RxSwift

class ListViewModelTests: XCTestCase {
    
    // MARK: - System Under Test
    
    var sut: ListViewModel!
    
    // MARK: RxTest

    private var scheduler: TestScheduler!
    private var bag: DisposeBag!
    
    // MARK: - Mocks
    
    private var mockUseCase: MockSearchUseCase!
    
    // MARK: - Life Cycle
    
    override func setUp() {
        super.setUp()
        
        scheduler = TestScheduler(initialClock: 0)
        bag = DisposeBag()
        
        mockUseCase = MockSearchUseCase(scheduler: scheduler)
        sut = ListViewModel(with: mockUseCase)
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func test_whenUseCaseEmitsAlbums_thenSectionModelEmits() {
        let type = scheduler.createObserver([ListSectionModel].self)

        sut.albums
            .bind(to: type)
            .disposed(by: bag)

        scheduler.start()

        XCTAssertEqual(type.events, [
            .next(10, []),
            .next(20, [
                ListSectionModel.section(items: [ListSectionItem.search(viewModel: ListViewModelTests.albumFake)])
            ]),
        ])
    }
    
    func test_whenUseCaseEmitsAlbums_thenNumberOfAlbumsEmits() {
        let type = scheduler.createObserver(String.self)

        sut.numberOfAlbums
            .bind(to: type)
            .disposed(by: bag)

        scheduler.start()

        XCTAssertEqual(type.events, [
            .next(10, "0"),
            .next(20, "1"),
        ])
    }
    
    // MARK: - Mocks
    
    private class MockSearchUseCase: SearchUseCaseProtocol {
        
        let scheduler: TestScheduler

        init(scheduler: TestScheduler) {
            self.scheduler = scheduler
        }
        
        var albums: Observable<[Album]> {
            return scheduler
                .createColdObservable([
                    .next(10, []),
                    .next(20, [
                        ListViewModelTests.albumFake
                    ]),
                ])
                .asObservable()
        }
        
        
    }
    
    // MARK: - Fakes
    
    private static let albumFake = Album(title: "title",
                                  genre: "genre",
                                  country: "country",
                                  year: "year")
}
