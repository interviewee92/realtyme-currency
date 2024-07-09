//
//  CoinsViewModelTests.swift
//  InterviewTests
//
//  Created by interviewee92 on 09/07/2024.
//

import Combine
@testable import Interview
import XCTest

final class CoinsViewModelTests: XCTestCase {
    var cancellables: Set<AnyCancellable> = []
    var viewModel: CoinsViewModel<CoinDetailViewModel>!
    var coordinator: MockCoinsCoordinator!

    override func setUpWithError() throws {
        continueAfterFailure = false

        coordinator = MockCoinsCoordinator()

        viewModel = CoinsViewModel(
            fiatService: MockFiatService(),
            coinService: MockCoinService(),
            imageManager: MockImageManager(imageService: MockImageService()),
            coordinator: coordinator
        )
    }

    func testCoinsViewModelIsDownloadingFiatsData() async throws {
        let expectation = XCTestExpectation(description: "Did download and set fiat data from service")

        viewModel
            .fiatDataPublisher
            .filter { !$0.isEmpty }
            .sink { _ in expectation.fulfill() }
            .store(in: &cancellables)

        viewModel.start()
        await fulfillment(of: [expectation], timeout: 15.0)
    }

    func testCoinsViewModelIsDownloadingCoinsData() async throws {
        let expectation = XCTestExpectation(description: "Did download and set crypto data from service")

        viewModel
            .cryptoDataPublisher
            .filter { !$0.isEmpty }
            .sink { _ in expectation.fulfill() }
            .store(in: &cancellables)

        viewModel.start()

        await fulfillment(of: [expectation], timeout: 15.0)
    }

    func testCoinsViewModelIsRequestingCoordinatorToOpenDetails() async throws {
        let expectation = XCTestExpectation(description: "Coordinator viewControllers number increases")

        Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            viewModel
                .cryptoDataPublisher
                .receive(on: DispatchQueue.main)
                .filter { !$0.isEmpty }
                .sink { _ in
                    self.viewModel.userDidSelectItem(at: .init(row: 0, section: 0))

                    Task {
                        if await self.coordinator.navigationController.viewControllers.count == 2 {
                            expectation.fulfill()
                        }
                    }
                }
                .store(in: &cancellables)
        }

        viewModel.start()

        await fulfillment(of: [expectation], timeout: 15.0)
    }
}
