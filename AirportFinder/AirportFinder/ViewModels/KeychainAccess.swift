
import Security
import Foundation

class KeyChain {
    
class func save(key: String, data: Data) -> OSStatus {
    let query = [
        kSecClass as String       : kSecClassGenericPassword as String,
        kSecAttrAccount as String : key,
        kSecValueData as String   : data ] as [String : Any]

    SecItemDelete(query as CFDictionary)

    return SecItemAdd(query as CFDictionary, nil)
}
    private class func delete(key: String) -> OSStatus {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key] as [String : Any]
        
       return SecItemDelete(query as CFDictionary)
        
    }
class func load(key: String) -> Data? {
    let query = [
        kSecClass as String       : kSecClassGenericPassword,
        kSecAttrAccount as String : key,
        kSecReturnData as String  : kCFBooleanTrue!,
        kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]

    var dataTypeRef: AnyObject? = nil

    let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

    if status == noErr {
        return dataTypeRef as! Data?
    } else {
        return nil
    }
}

class func createUniqueID() -> String {
    let uuid: CFUUID = CFUUIDCreate(nil)
    let cfStr: CFString = CFUUIDCreateString(nil, uuid)

    let swiftString: String = cfStr as String
    return swiftString
}
}

extension Data {

    init<T>(from value: T) {
        var value = value
        var myData = Data()
        withUnsafePointer(to:&value, { (ptr: UnsafePointer<T>) -> Void in
            myData = Data( buffer: UnsafeBufferPointer(start: ptr, count: 1))
        })
        self.init(myData)
    }

func to<T>(type: T.Type) -> T {
    return self.withUnsafeBytes { $0.load(as: T.self) }
}
}

//// Example usage:
//
//let int: Int = 555
//let data = Data(from: int)
//let status = KeyChain.save(key: "MyNumber", data: data)
//print("status: ", status)
//
//if let receivedData = KeyChain.load(key: "MyNumber") {
//let result = receivedData.to(type: Int.self)
//print("result: ", result)
//}