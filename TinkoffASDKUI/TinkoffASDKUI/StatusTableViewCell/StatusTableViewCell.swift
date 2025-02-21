//
//  StatusTableViewCell.swift
//  TinkoffASDKUI
//
//  Copyright (c) 2020 Tinkoff Bank
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

import UIKit

class StatusTableViewCell: UITableViewCell {
    @IBOutlet var labelStatus: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var buttonUpdate: UIButton!

    var onButtonTouch: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()

        defaultUIState()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        defaultUIState()
    }

    @IBAction private func onButtonUpdateTouchUpInside(_: UIButton) {
        onButtonTouch?()
    }

    func defaultUIState() {
        onButtonTouch = nil

        activityIndicator.isHidden = false
        activityIndicator.startAnimating()

        labelStatus.isHidden = true
        labelStatus.text = nil
        labelStatus.attributedText = nil

        buttonUpdate.isHidden = true
        buttonUpdate.setTitle(L10n.TinkoffAcquiring.Button.update, for: .normal)
    }
}
