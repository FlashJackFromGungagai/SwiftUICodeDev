//
//  AddressDecodeLatLng.swift
//  LocnMpScrnPortView
//
//  Created by mlittle-macmini-20200921 on 25/10/2023.
//

import Foundation
import SwiftUI
import Combine

// ===================================================================================
class AddressDecodeLatLng:ObservableObject
{
    //—————————————————————————————————————————————————————————
    //—————————————————————————————————————————————————————————
    // Properties
    
    // DEPRACATED...
    //@ObservedObject var geocodedaddress = addressGeoDecoding()
    /// this is creating a new Observed object instance of the class "addressGeocodeLatLng()"
    
    // DEPRACATED...
    //var gcdedResultsData: geocodeResultsData? = nil
    
    ///initialise the variables representing the latitude and longitude
    @State var latitud:  Double? = 0.00
    @State var longitud: Double? = 0.00
    
    //—————————————————————————————————————————————————————————
    //  properties originally from "class addressGeoDecoding: ObservableObject"
    
    
    
        //@Published var gcodedResultsData: geocodeResultsData? = nil
    /// This property "gcodedResultsData" is published and when data is changed
    /// this change is announced and with SwiftUI it will re-invoke the body property
    /// of any view that relies on the data. This means that whenever "gcodedResultsData"
    /// all views using that object will be reloaded to reflect those changes.
    ///
    //@Published var gcodedResultsData: geocodeResultsData? = nil
    @Published var gcodedResultsData: geocodeResultsData?

    private var cancellables = Set<AnyCancellable>()
    /// this means that when an object that implements "Cancellable" has a cancel
    /// message dad utan be called to stop any in progress work, and any allocated resource
    /// to be freed up
    

    private var apiKey: String
    {
      get
      {
        ////get the location of the plist
        guard let filePath = Bundle.main.path(forResource: "information", ofType: "plist") else {
          fatalError("Couldn't find file 'information.plist'.")
        }
        // retrieve the apikey
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
          fatalError("Couldn't find key 'API_KEY' in 'information.plist'.")
        }
        return value
      }
    }
    
   
    
    
    //—————————————————————————————————————————————————————————
    //—————————————————————————————————————————————————————————
    // Methods
    
    
    //—————————————————————————————————————————————————————————------------------------
    // DEPRACTATED!
    //func retrieveGecondingLatLngData(addressUncoded : String )
    //{
        //geocodedaddress.fetchGecondingLatLngData(addressUncoded: addressUncoded)
        
    //}// close func retrieveGecondingLatLngData(addressUncoded : addressUncoded )
    //—————————————————————————————————————————————————————————------------------------
    
    
    
    //———————————————————————————————————————————————————————---------------------
    //  fetchGecondingLatLngData
    /// this method takes in the uncoded adress such as "36 lusher Road, Croydon, Vic",
    /// encoded the address suitable for Google Geocoding
    /// and with the apiKey and retrieves the latitude and longitude of the uncoded Address.
    ///
    func fetchGecondingLatLngData(addressUncoded : String)
    {
        //var uncdedAddress: String = addressUncoded
        //print (addressUncoded)
        let encodedAddress: String = encodeAddress( addrssUncoded:addressUncoded  )
        
        let url = URL(string:  "https://maps.googleapis.com/maps/api/geocode/json?address=\(encodedAddress)&key=\(apiKey)" )!
        /// this string concatenate the encoded address and the API key so too call Google geocode and return JSON formatted
        /// Remember ""url" can be optional!
        //print (url)

        /// URLSession.shared.dataTaskPublisher(for: url):
        /// URLSession.shared.dataTaskPublisher():  The publisher publishes data when the task completes, or terminates if the task fails with an error.
        ///  url: The URL for which to create a data task.
        ///
        ///  map(): Returns an array containing the results of mapping the given closure over the sequence’s elements.
        ///
        ///  sink(receiveCompletion:receiveValue:):
        ///     A cancellable instance, which you use when you end assignment of the received value.
        ///     Deallocation of the result will tear down the subscription stream.
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
                                                        
                                                        // this is a diagnostic
                                                        print("data:\(data)" )
                                                        //print("self.gcodedResultsData: \(self.gcodedResultsData)")
                                                        
                
                                                }//close ",receiveValue:"
                )//close ".sink"
            .store(in: &cancellables)
        
        
    }// close func fetchLatLng(addressUncoded : String, apiKey: String)
    //———————————————————————————————————————————————————————---------------------
    
    
    
    //———————————————————————————————————————————————————————---------------------
    // encode address
    /// Google Geocode requires that address must have the form of "36+Lusher+Road,+Croydon,+Vic"
    /// This method replaces " " characters with "+" charactors.
    
    func encodeAddress(addrssUncoded: String)->String
    {
        var codedAddress: String
        
        codedAddress = addrssUncoded.replacingOccurrences(of: " ", with: "+")
        
        return codedAddress
        
    }// close func encodeAddress(addressUncoded: String)->String
    //———————————————————————————————————————————————————————---------------------
    
    
    //—————————————————————————————————————————————————————————------------------------
    /// This method decodes the latitude information for from the JSON data returned from Google address geocoded data
    func retrieveLatitude ( ) -> Double?
    {
        //if let locationResultsArray = geocodedaddress.gcodedResultsData?.results[0]
        if let locationResultsArray = gcodedResultsData?.results[0]
        {
            let locationGeometry = locationResultsArray.geometry
            let locationElement = locationGeometry.location
            //latitud = locationElement.lat
            
            print (locationElement.lat)
            return locationElement.lat

        }// close "if let locationResultsArray = gcodedResultsData?.results[0]"
        else
        {
            print("Geocode latitude data not available")
            return nil
            
        }// close else
        
        
    }// close retrieveLatitude ( )
    //—————————————————————————————————————————————————————————------------------------
    
    //—————————————————————————————————————————————————————————------------------------
    /// This method decodes the longitude information for from the JSON data returned from Google address geocoded data
    func retrievelongitude ( ) -> Double?
    {
        //if let locationResultsArray = geocodedaddress.gcodedResultsData?.results[0]
        if let locationResultsArray = gcodedResultsData?.results[0]
        {
            let locationGeometry = locationResultsArray.geometry
            let locationElement = locationGeometry.location
            //latitud = locationElement.lat
            
            print (locationElement.lng)
            return locationElement.lng

        }// close "if let locationResultsArray = gcodedResultsData?.results[0]"
        else
        {
            print("Geocode longitude data not available")
            return nil
            
        }// close else
        
        
    }// close retrieveLatitude ( )
    //—————————————————————————————————————————————————————————------------------------
    
}// close class AddressDecodeLatLng:ObservableObject



// ===================================================================================


// ===================================================================================
