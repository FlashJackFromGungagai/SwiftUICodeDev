//
//  addressGeocodeLatLng.swift
//  LocnMpScrnPortView
//
//  Created by mlittle-macmini-20200921 on 21/10/2023.
//

/*

About:
——————————————
 This code is based on "WeatherAppDemoApp.swift" by
  by Shekhar Kalra on 3/9/2023 and extended to this requirement. 
 

Change History:
——————————————


Version :
——————————————


Contact:
——————————————
Mike Little
Mob:    +613 476 136 482
Email:  "s9905648@student.rmit.edu"

*/



import Foundation
import Foundation
import SwiftUI
import Combine

// ===================================================================================
class addressGeocodeLatLng: ObservableObject
{
    //—————————————————————————————————————————————————————————
    //—————————————————————————————————————————————————————————
    // Properties
    
    @Published var gcodedResultsData: geocodeResultsData? = nil
    /// This property "gcodedResultsData" is published and when data is changed
    /// this change is announced and with SwiftUI it will re-invoke the body property
    /// of any view that relies on the data. This means that whenever "gcodedResultsData"
    /// all views using that object will be reloaded to reflect those changes.

    private var cancellables = Set<AnyCancellable>()
    /// this means that when an object that implements "Cancellable" has a cancel
    /// message dad utan be called to stop any in progress work, and any allocated resource
    /// to be freed up
    
    
    
    
    //—————————————————————————————————————————————————————————
    //—————————————————————————————————————————————————————————
    // Methods
    
    //———————————————————————————————————————————————————————
    //  fetchLatLng
    /// this method takes in the uncoded adress such as "36 lusher Road, Croydon, Vic",
    /// encoded the address suitable for Google Geocoding
    /// and with the apiKey and retrieves the latitude and longitude of the uncoded Address.
    ///
    func fetchLatLng(addressUncoded : String, apiKey: String)
    {
        //var uncdedAddress: String = addressUncoded
        let encodedAddress: String = encodeAddress( addrssUncoded:addressUncoded  )
        
        let url = URL(string:  "https://maps.googleapis.com/maps/api/geocode/json?address=\(encodedAddress)&key=\(apiKey)" )!
        /// this string concatenate the encoded address and the API key so too call Google geocode and return JSON formatted
        /// Remember ""url" can be optional!
        ///
        URLSession.shared.dataTaskPublisher(for: url)
            .map (\.data)
            .decode(type:geocodeResultsData.self, decoder: JSONDecoder() )
            .receive(on: DispatchQueue.main)
            .sink( receiveCompletion:
                                    {
                                        completion in
                                                if case .failure (let error) = completion
                                                {
                                                    print ("Fetching geocoding data error: \(error)")
                                                } // close if case .failure (let error) = completion
                
                                    }// closes receiveCompletion
                                    ,receiveValue:
                                                {
                                                    data in
                                                        self.gcodedResultsData = data
                
                                                }//close ",receiveValue:"
                )//close ".sink"
            .store(in: &cancellables)
        
    }// close func fetchLatLng(addressUncoded : String, apiKey: String)
    
    
    //———————————————————————————————————————————————————————
    // encode address
    /// Google Geocode requires that address must have the form of "36+Lusher+Road,+Croydon,+Vic"
    /// This method replaces " " characters with "+" charactors.
    
    func encodeAddress(addrssUncoded: String)->String
    {
        var codedAddress: String
        
        codedAddress = addrssUncoded.replacingOccurrences(of: " ", with: "+")
        
        return codedAddress
        
    }// close func encodeAddress(addressUncoded: String)->String
    
    
    
}
// ===================================================================================
