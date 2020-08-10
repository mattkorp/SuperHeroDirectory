//
//  Localized.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/10/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//

import Foundation

enum L10n {
    enum General {
        enum Error {
            /// "Error"
            static var title: String { L10n.tr("Localizable", "general.error.title") }
            /// "Something went wrong."
            static var text: String { L10n.tr("Localizable", "general.error.text") }
        }
        enum Alert {
            enum Ok {
                // OK
                static var title: String { L10n.tr("Localizable", "general.alert.ok.title")}
            }
        }
    }
    enum SearchList {
        enum Navigation {
            /// "Superhero Directory"
            static var title: String { L10n.tr("Localizable", "searchList.navigation.title") }
        }
    }
    enum Detail {
        enum Bio {
            static var title: String { L10n.tr("Localizable", "detail.bio.title")}
            static var text: String { L10n.tr("Localizable", "detail.bio.text")}
        }
    }
}

// MARK: - Implementation Details

extension L10n {
    internal static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        let language = NSLocale.current.identifier
        let bundle = getBundle(forLocaleIdentifier: language)

        let format = NSLocalizedString(key, tableName: table, bundle: bundle, comment: "")
        guard format != key else {
            let fallbackBundle = Bundle(path: Bundle.main.path(forResource: "Base", ofType: "lproj")!)!
            let fallbackFormat = NSLocalizedString(key, tableName: table, bundle: fallbackBundle, comment: "")
            return String(format: fallbackFormat, locale: Locale.current, arguments: args)
        }
        return String(format: format, locale: Locale.current, arguments: args)
    }
}

private var bundleCache: [String: Bundle] = [:]
private var bundleCacheQueue = DispatchQueue(label: "bundleCacheQueue")

fileprivate func getBundle(forLocaleIdentifier localeIdentifier: String) -> Bundle {
    if let bundle = bundleCacheQueue.sync(execute: { bundleCache[localeIdentifier] }) {
        return bundle
    }

    let path =
        Bundle.main.path(forResource: localeIdentifier, ofType: "lproj") ??
            Bundle.main.path(forResource: localeIdentifier.split(separator: "-").first!.stringValue, ofType: "lproj")

    let bundle: Bundle = path.map({ Bundle(path: $0) }).flatMap({ $0 }) ?? Bundle(for: BundleToken.self)
    bundleCacheQueue.sync {
        bundleCache[localeIdentifier] = bundle
    }
    return bundle
}

extension String.SubSequence {
    var stringValue: String { String(self) }
}

private final class BundleToken {}
