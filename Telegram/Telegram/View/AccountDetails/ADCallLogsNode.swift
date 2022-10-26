//
//  ADCallLogsNode.swift
//  Telegram
//
//  Created by Bilal M. on 26/10/2022.
//

import AsyncDisplayKit
import TelegramNetwork

final public class ADCallLogsNode: BaseNode {
    private var contentNode = ASDisplayNode()
    private var dateNode = ASTextNode()
    private var timeNodes: [ASTextNode] = []
    private var statusNodes: [ASTextNode] = []
    
    public override init() {
        super.init()
        
        backgroundColor = .Theme.secondaryBackground
    }
    
    public func configure(with service: WTimeService, call: Call) {
        if let date = DateFormatFactory.shared.iDateFormatter.date(from: call.date) {
            let timeFormatter = DateFormatFactory.shared.timeFormatter
            timeNodes = transform(items: [date], using: timeFormatter.string(from:))
        }
        
        statusNodes = transform(items: [call], using: formatCallStatus(_:))
        
        service.fetchCurrentTime { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let model):
                let text = self.makeReadableWorldTimeDate(datetime: model.datetime)
                self.dateNode.attributedText = self.headerText(text)
                
            case .failure:
                self.dateNode.attributedText = self.headerText("Couldn't get date.")
            }
        }
    }
    
    // MARK: - Support
    private func formatCallStatus(_ call: Call) -> String {
        var text: String = ""
        switch call.type {
        case .incoming:
            if let incomingStatus = call.incomingStatus {
                switch incomingStatus {
                case .accepted:
                    text = "Incoming \(formatCallDuration(call.duration))"
                case .missed:
                    text = "Missed Call"
                case .rejected:
                    text = "Declined Call"
                }
            }
        case .outgoing:
            text = "Outgoing \(formatCallDuration(call.duration))"
        }
        
        return text
    }
    
    private func headerText(_ text: String) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Theme.primaryLabel,
            .font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    private func bodyText(_ text: String) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Theme.primaryLabel,
            .font: UIFont.systemFont(ofSize: 14, weight: .regular)
        ]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    private func formatCallDuration(_ duration: Int?) -> String {
        guard let duration = duration else { return "" }
        
        if duration < 60 {
            return "(\(duration) sec)"
        } else {
            return String(format: "(%d min)", duration / 60)
        }
    }
    
    private func makeReadableWorldTimeDate(datetime: String) -> String {
        let date = (datetime.split(separator: ".").map(String.init))[0]
        guard let date = DateFormatFactory.shared.iDateFormatter.date(from: date) else { return "" }
        return DateFormatFactory.shared.accountDateFormatter.string(from: date)
    }
    
    private func transform<T>(items: [T], using block: (T) -> String) -> [ASTextNode] {
        items
            .map(block)
            .map {
                let textNode = ASTextNode()
                textNode.attributedText = bodyText($0)
                
                return textNode
            }
    }
}

// MARK: - Layout
extension ADCallLogsNode {
    public override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let leftVStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 10,
            justifyContent: .start,
            alignItems: .center,
            children: timeNodes)
        
        let statusSpecs = statusNodes.map {
            let spec = ASInsetLayoutSpec(insets: .zero, child: $0)
            spec.style.flexGrow = 1
            return spec
        }
        
        let rightVStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 10,
            justifyContent: .start,
            alignItems: .center,
            children: statusSpecs)
        
        let callLogHStack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 30,
            justifyContent: .start,
            alignItems: .center,
            children: [leftVStack, rightVStack])
        
        let contentVStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 10,
            justifyContent: .center,
            alignItems: .start,
            children: [dateNode, callLogHStack])
        
        return ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 10, left: 14, bottom: 12, right: 14),
            child: contentVStack)
    }
}
