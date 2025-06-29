import Foundation
//import UIKit

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
