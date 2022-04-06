//
//  NetworkManager.swift
//  AirportFinder
//
//  Created by Amin on 1/17/1401 AP.
//

import Foundation

protocol AmadeusNetworkManagerProtocol {
    func getListOfAirportsFor(lat: Double, long: Double, radius:Int,completion:@escaping(_ airports:[Airport]) -> ())
}
class AmadeusNetworkManager:AmadeusNetworkManagerProtocol {
    func getListOfAirportsFor(lat: Double, long: Double, radius: Int, completion: @escaping ([Airport]) -> ()) {
        completion([])
    }
    
}