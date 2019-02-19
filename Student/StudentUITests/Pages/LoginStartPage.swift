//
// Copyright (C) 2018-present Instructure, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Core

enum LoginStartPage: String, UITestElement, CaseIterable {
    case authenticationMethodLabel
    case canvasNetworkButton
    case findSchoolButton
    case helpButton
    case logoView
    case whatsNewLabel
    case whatsNewLink
}

struct LoginPreviousUserItem: RawRepresentable, UITestElement {
    let rawValue: String

    static func item(entry: KeychainEntry) -> LoginPreviousUserItem {
        return LoginPreviousUserItem(rawValue: "\(entry.baseURL.host ?? "").\(entry.userID)")
    }

    static func removeButton(entry: KeychainEntry) -> LoginPreviousUserItem {
        return LoginPreviousUserItem(rawValue: "\(entry.baseURL.host ?? "").\(entry.userID).removeButton")
    }
}
