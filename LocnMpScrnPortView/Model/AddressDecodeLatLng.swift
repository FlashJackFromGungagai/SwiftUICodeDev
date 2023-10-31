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
    @ObservedObject var geocodedaddress = addressGeoDecoding()
    /// this is creating a new Observed object instance of the class "addressGeocodeLatLng()"
    
    var gcdedResultsData: geocodeResultsData? = nil
    
    ///initialise the variables representing the latitude and longitude
    @State var latitud:  Double? = 0.00
    @State var longitud: Double? = 0.00
    
    
    //—————————————————————————————————————————————————————————
    //—————————————————————————————————————————————————————————
    // Methods
    
    
    //—————————————————————————————————————————————————————————
    //
    func retrieveGecondingLatLngData(addressUncoded : String )
    {
        geocodedaddress.fetchGecondingLatLngData(addressUncoded: addressUncoded)
        
    }// close func retrieveGecondingLatLngData(addressUncoded : addressUncoded )
    
    //—————————————————————————————————————————————————————————
    /// This method decodes the latitude information for from the JSON data returned from Google address geocoded data
    func retrieveLatitude ( ) -> Double
    {
        let locationResultsArray = geocodedaddress.gcodedResultsData?.results[0]
        let locationGeometry = locationResultsArray?.geometry
        let locationElement = locationGeometry?.location
        if (locationElement != nil)
        {
                 latitud = locationElement?.lat
                 return latitud
                // get an error message Value of optional type 'Double?' must be unwrapped to a value of type 'Double'

         }// close if let locationLocation = locationGeometry?.location
                
        else
        {
            print("Geocoding data for Latitude not available")

         }// close if let locationLocation = locationGeometry?.location
        
    }// close retrieveLatitude ( )
    
    //—————————————————————————————————————————————————————————
    /// This method decodes the longitude information for from the JSON data returned from Google address geocoded data
    func retrievelongitude ( ) -> Double
    {
        
        let locationResultsArray = geocodedaddress.gcodedResultsData?.results[0]
        let locationGeometry = locationResultsArray?.geometry
        let locationElement = locationGeometry?.location
        if (locationElement != nil)
        {
            longitud = locationElement?.lng
            //print ("longitude:\(longitud)")
            return longitud
            
         }// close if let locationLocation = locationGeometry?.location
                
        else
        {
            print("Geocoding data for longitude not available")

         }// close if let locationLocation = locationGeometry?.location
        
    }// close retrieveLatitude ( )
    
}// close class AddressDecodeLatLng:ObservableObject

// ===================================================================================
