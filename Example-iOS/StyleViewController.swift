//
//  StyleViewController.swift
//
//  Created by Brian King on 8/26/16.
//  Copyright © 2016 Raizlabs. All rights reserved.
//

import UIKit
import BonMot

// UITableViewCell built in labels are re-created when the content size category changes so we use a proper cell subclass.
class MasterTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel?
}

class StyleViewController: UITableViewController {
    var styles: [(String, [NSAttributedString])] = [
        ("XML", [DemoStrings.xml]),
        ("Composition", [DemoStrings.composition]),
        ("Tracking", [DemoStrings.trackingString]),
        ("Images & Special Characters", [DemoStrings.imageString, DemoStrings.noBreakSpaceString]),
        ("Baseline Offset", [DemoStrings.heartsString]),
        ("Indentation", DemoStrings.indentationStrings),
        ("Line Height", [DemoStrings.lineSpacingString]),
        ("Dynamic Type", [DemoStrings.dynamcTypeUIKit, DemoStrings.preferredFonts]),
        ("Figure Style", DemoStrings.proportionalStrings),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
    }

    func cell(at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StyleCell", for: indexPath) as? MasterTableViewCell else {
            fatalError("Misconfigured VC")
        }
        let attributedText = styles[indexPath.section].1[indexPath.row]
        cell.titleLabel?.attributedText = attributedText.adapt(to: traitCollection)
        cell.accessoryType = attributedText.attribute("Storyboard", at: 0, effectiveRange: nil) == nil ? .none : .disclosureIndicator
        return cell
    }

    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        let attributedText = styles[indexPath.section].1[indexPath.row]
        if attributedText.attribute("Storyboard", at: 0, effectiveRange: nil) is String {
            return true
        }
        return false

    }

    func selectRow(at indexPath: IndexPath) {
        let attributedText = styles[indexPath.section].1[indexPath.row]
        if let storyboardIdentifier = attributedText.attribute("Storyboard", at: 0, effectiveRange: nil) as? String {
            guard let nextVC = storyboard?.instantiateViewController(withIdentifier: storyboardIdentifier) else {
                fatalError("No Storyboard identifier \(storyboardIdentifier)")
            }
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

extension StyleViewController {
    #if swift(>=3.0)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return styles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return styles[section].1.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cell(at: indexPath)
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return styles[section].0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectRow(at: indexPath)
    }
    #else
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return styles.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return styles[section].1.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return cell(at: indexPath)
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return styles[section].0
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectRow(at: indexPath)
    }
    #endif
}
