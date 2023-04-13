//
//  UIColors+Application.swift
//  Schedule
//
//  Created by Tatyana Anikina on 05.12.2020.
//

import UIKit
import Foundation



extension UIColor {

    static var applicationParchment: UIColor {
        return UIColor(named: "Application Parchment Color")!
    }

    static var applicationSecondaryTint: UIColor {
        return UIColor(named: "Application Secondary Tint Color")!
    }

    static var applicationBackground: UIColor {
        return UIColor(named: "Application Background Color")!
    }

    static var applicationCell: UIColor {
        return UIColor(named: "Application Collection View Cell")!
    }

    static var applicationBadgeLabel: UIColor {
        return UIColor(named: "Application Badge Label Color")!
    }

    static var applicationSecondaryBackground: UIColor {
        return UIColor(named: "Application Secondary Background Color")!
    }

    static var applicationSecondaryParchment: UIColor {
        return UIColor(named: "Application Secondary Parchment Color")!
    }

    static var applicationGroupedBackground: UIColor {
        return UIColor(named: "Application Grouped Background Color")!
    }

    static var applicationSecondaryGroupedBackground: UIColor {
        return UIColor(named: "Application Secondary Grouped Background Color")!
    }

    static var applicationTertiaryGroupedBackground: UIColor {
        return UIColor(named: "Application Tertiary Grouped Background Color")!
    }

    static var applicationFill: UIColor {
        return UIColor(named: "Application Fill Color")!
    }

    static var applicationSecondaryFill: UIColor {
        return UIColor(named: "Application Secondary Fill Color")!
    }

    static var applicationTertiaryFill: UIColor {
        return UIColor(named: "Application Tertiary Fill Color")!
    }

    static var applicationQuaternaryFill: UIColor {
        return UIColor(named: "Application Quaternary Fill Color")!
    }

    static var applicationLabel: UIColor {
        return UIColor(named: "Application Fill Color")!
    }

    static var applicationSecondaryLabel: UIColor {
        return UIColor(named: "Application Secondary Label Color")!
    }

    static var applicationTertiaryLabel: UIColor {
        return UIColor(named: "Application Tertiary Label Color")!
    }

    static var applicationQuaternaryLabel: UIColor {
        return UIColor(named: "Application Quaternary Label Color")!
    }

    static var applicationCurrentParchment: UIColor {
        return UIColor(named: "Application Current Parchment")!
    }

    static var applicationTabBar: UIColor {
        return UIColor(named: "Application Tab Bar Color")!
    }

    static var applicationToolBar: UIColor {
        return UIColor(named: "Application Tool Bar Color")!
    }

    static var applicationTableCell: UIColor {
        return UIColor(named: "Application Table View Cell")!
    }

    static var applicationTableView: UIColor {
        return UIColor(named: "Application Table View Color")!
    }

    static var applicationCollectionView: UIColor {
        return UIColor(named: "Application Collection View Color")!
    }

    static var applicationTextColor: UIColor {
        return UIColor(named: "Application Text Color")!
    }

    static var applicationSubjectCell: UIColor {
        return UIColor(named: "Aplication Subject Cell")!
    }
    static func == (l: UIColor, r: UIColor) -> Bool {
        var r1: CGFloat = 0
        var g1: CGFloat = 0
        var b1: CGFloat = 0
        var a1: CGFloat = 0
        l.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        var r2: CGFloat = 0
        var g2: CGFloat = 0
        var b2: CGFloat = 0
        var a2: CGFloat = 0
        r.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        return r1 == r2 && g1 == g2 && b1 == b2 && a1 == a2
    }


    convenience init?(hex: String) {
            var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

            var rgb: UInt64 = 0

            var r: CGFloat = 0.0
            var g: CGFloat = 0.0
            var b: CGFloat = 0.0
            var a: CGFloat = 1.0

            let length = hexSanitized.count

            guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

            if length == 6 {
                r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
                g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
                b = CGFloat(rgb & 0x0000FF) / 255.0

            } else if length == 8 {
                r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
                g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
                b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
                a = CGFloat(rgb & 0x000000FF) / 255.0

            } else {
                return nil
            }

            self.init(red: r, green: g, blue: b, alpha: a)
        }

        var toHex: String? {
            return toHex()
        }

        // MARK: - From UIColor to String

        func toHex(alpha: Bool = false) -> String? {
            guard let components = cgColor.components, components.count >= 3 else {
                return nil
            }

            let r = Float(components[0])
            let g = Float(components[1])
            let b = Float(components[2])
                    var a = Float(1.0)

                    if components.count >= 4 {
                        a = Float(components[3])
                    }

                    if alpha {
                        return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
                    } else {
                        return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
                    }
                }

            }

let color = UIColor.toHex(.red)

