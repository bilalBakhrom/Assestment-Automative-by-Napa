//
//  CallsTableDataSource.swift
//  Telegram
//
//  Created by Bilal M. on 26/10/2022.
//

import Foundation
import AsyncDisplayKit
import TelegramNetwork

final class CallsTableDataSource: NSObject, ASTableDataSource {
    var editing: Bool = false
    var reload: (() -> Void)?
    private var selectedSegment: CallSegment = .all
    private var allCalls: [Call] = []
    private var filteredCalls: [Call] = []
    private var interaction: CallsNodeInteraction
    private let service = CallService()
    
    init(interaction: CallsNodeInteraction) {
        self.interaction = interaction
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        filteredCalls.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let node = CallCellNode { [weak self] item in
            self?.interaction.openInfo(item)
        } onDelete: { [weak self] item in
            guard let index = self?.delete(item: item) else {
                return
            }
            
            let indexPath = IndexPath(row: index, section: 0)
            tableNode.deleteRows(at: [indexPath], with: .top)
        }

        node.configure(with: filteredCalls[indexPath.row], editing: editing)
        
        return node
    }
    
    func fetchCalls() {
        service.fetchCallList { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                self.allCalls = data
                self.filteredCalls = data
                self.reload?()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func filter(by segment: CallSegment) {
        switch segment {
        case .all:
            filteredCalls = allCalls
        case .missed:
            filteredCalls = allCalls.filter { $0.hasMissed }
        }
    }
    
    private func delete(item: Call) -> Int? {
        if let index = allCalls.firstIndex(where: { $0 == item }) {
            allCalls.remove(at: index)
        }
        
        if let index = filteredCalls.firstIndex(where: { $0 == item }) {
            filteredCalls.remove(at: index)
            return index
        }
        
        return nil
    }
}
