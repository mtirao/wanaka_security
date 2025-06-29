//
//  MockRepository.swift
//  Wanaka Security
//
//  Created by Marcos Tirao on 22/06/2025.
//

import Foundation

final class MockRepository {
    
    func loadJson(fileName: String) -> Data? {
       guard
            let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url)
       else {
            return nil
       }

       return data
    }
    
}
