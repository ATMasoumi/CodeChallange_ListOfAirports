//
//  AirportFinderViewModel.swift
//  AirportFinder
//
//  Created by Amin on 1/16/1401 AP.
//

import Foundation

class AirportFinderViewModel:ObservableObject {
    
    let networkManger:AmadeusNetworkManagerProtocol
    let radius = 500
    let userDefaults:UserDefaults
    
    @Published var airportsData: AirportsData? = nil
    @Published var lat:String = ""
    @Published var long:String = ""
    
    var tokenContent:TokenContent? {
        set {
            guard let newValue = newValue else { return }
            let tokenData = try? JSONEncoder().encode(newValue)
            userDefaults.set(tokenData, forKey: "token")
            userDefaults.set(Date().timeIntervalSince1970+Double(newValue.expiresIn),forKey: "tokenDate")
        }
        get {
            if let data = userDefaults.value(forKey:"token") as? Data {
                let tokenContent = try? JSONDecoder().decode(TokenContent.self, from: data)
                let date = Date(timeIntervalSince1970: userDefaults.double(forKey: "tokenDate"))
                if date > Date() {
                    return tokenContent
                }else{
                    return nil
                }
            }else{
                return nil
            }
           
        }
    }
    var airports:[Airport] {
        if let airportsData = airportsData {
            return airportsData.data
        }else {
            return []
        }
    }
    let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 10
        return numberFormatter
    }()
    
    init(networkManger:AmadeusNetworkManagerProtocol,userDefaults:UserDefaults){
        self.networkManger = networkManger
        self.userDefaults = userDefaults
    }
    
    
    func getListOfAirports(completion:@escaping() -> ()) {
        guard let lat = Double(lat) else {
            return
        }
        guard let long = Double(long) else {
            return
        }

        if let tokenContent = tokenContent {
            networkManger.getListOfAirportsFor(lat: lat, long: long, radius: radius,pageLimit: 20, pageOffset: 0, sort: .relevance, tokenContent: tokenContent) { airportsData in
                guard let airportsData = airportsData else {
                    return
                }
                self.airportsData = airportsData
                completion()
            }
        } else {
            getToken { [unowned self] in
                networkManger.getListOfAirportsFor(lat: lat, long: long, radius: radius,pageLimit: 20, pageOffset: 0, sort: .relevance, tokenContent: tokenContent!) { airportsData in
                    guard let airportsData = airportsData else {
                        return
                    }
                    self.airportsData = airportsData
                    completion()
                }
            }
        } 
    }
    
    func getToken(completion:@escaping() -> ()) {
        networkManger.getToken { [weak self] tokenContent in
            self?.tokenContent = tokenContent
            completion()
        }
    }
    
}


