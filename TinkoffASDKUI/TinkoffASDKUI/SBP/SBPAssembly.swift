//
//
//  SBPAssembly.swift
//
//  Copyright (c) 2021 Tinkoff Bank
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//


import TinkoffASDKCore
import UIKit

final class SBPAssembly {
    
    private let coreSDK: AcquiringSdk
    private let style: Style
    
    init(coreSDK: AcquiringSdk,
         style: Style) {
        self.coreSDK = coreSDK
        self.style = style
    }

    func paymentPollingViewController(content: SBPBankListViewController,
                                      configuration: AcquiringViewConfiguration,
                                      completionHandler: PaymentCompletionHandler?) -> PaymentPollingViewController<SBPBankListViewController> {
        let paymentPollingViewController = PaymentPollingViewController(contentViewController: content,
                                                                        paymentService: paymentService,
                                                                        configuration: configuration,
                                                                        completion: completionHandler)
        return paymentPollingViewController
    }

    func banksListViewController(acquiringPaymentStageConfiguration: AcquiringPaymentStageConfiguration,
                                 configuration: AcquiringViewConfiguration) -> SBPBankListViewController {
        SBPBankListViewController(acquiringPaymentStageConfiguration: acquiringPaymentStageConfiguration,
                                  paymentService: paymentService,
                                  sbpBanksService: banksService,
                                  sbpApplicationService: applicationService,
                                  sbpPaymentService: sbpPaymentService,
                                  style: .init(continueButtonStyle: style.bigButtonStyle),
                                  tableManager: banksListTableManager)
    }
    
    func noAvailableBanksViewController(paymentStatusResponse: PaymentStatusResponse,
                                        paymentCompletionHandler: PaymentCompletionHandler?) -> SBPNoAvailableBanksViewController {
        SBPNoAvailableBanksViewController(style: .init(confirmButtonStyle: style.bigButtonStyle),
                                          urlOpener: applicationURLOpener,
                                          paymentStatusResponse: paymentStatusResponse,
                                          completionHandler: paymentCompletionHandler)
    }
}

private extension SBPAssembly {
    var banksService: SBPBanksService {
        DefaultSBPBanksService(coreSDK: coreSDK,
                               bundleImageProvider: bundleImageProvider,
                               bankAppAvailabilityChecker: bankAppAvailabilityChecker)
    }
    
    var applicationService: SBPApplicationOpener {
        DefaultSBPApplicationOpener(application: UIApplication.shared)
    }
    
    var paymentService: PaymentService {
        DefaultPaymentService(coreSDK: coreSDK)
    }
    
    var sbpPaymentService: SBPPaymentService {
        DefaultSBPPaymentService(coreSDK: coreSDK)
    }
    
    var banksListTableManager: SBPBankListTableManager {
        SBPBankListTableManager(cellImageLoader: cellImageLoader)
    }
    
    var bankAppAvailabilityChecker: SBPBankAppAvailabilityChecker {
        SBPBankAppAvailabilityChecker(application: UIApplication.shared)
    }
    
    var cellImageLoader: CellImageLoader {
        CellImageLoader(imageLoader: ImageLoader())
    }
    
    var bundleImageProvider: BundleImageProvider {
        BundleImageProvider(screen: UIScreen.main)
    }
    
    var applicationURLOpener: URLOpener {
        ApplicationURLOpener(application: .shared)
    }
}
