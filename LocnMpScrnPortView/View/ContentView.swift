//
//  ContentView.swift
//  LocnMpScrnPortView
//
//  Created by mlittle-macmini-20200921 on 17/10/2023.
//

/*

About:
——————————————
This code is based on "WeatherAppDemoApp.swift" by
 by Shekhar Kalra on 3/9/2023
 
 

Change History:
——————————————


Version :
——————————————


Contact:
——————————————
Developed by:
Mike Little
Student ID: s9905648
Mob:    +613 476 136 482
Email:  "s9905648@student.rmit.edu"

*/


import SwiftUI
import Combine

// ===================================================================================
struct ContentView: View
{
    //———————————————————————————————————————————————————————
    //———————————————————————————————————————————————————————
    // Properties
    @ObservedObject var addressGeocode = addressGeocodeLatLng()
    /// this is creating a new Observed object instance of the class "addressGeocodeLatLng()"
    let addressUncoded: String = "25 grange road, kew, victoria"
    let apiKey = "AIzaSyA5qIzGasLtxrzm2vY2CxZ-OcTLy5VDTmA"
    
    
    var body: some View
    {
        VStack
        {
            
            Text ("Un coded address: \(addressUncoded)")
            Text("The corresponding latitude and longitude is")
            
            let locationResultsArray = addressGeocode.gcodedResultsData?.results[0]
            let locationGeometry = locationResultsArray?.geometry
            let locationLocation = locationGeometry?.location
            //let locationLat = locationLocation?.lat
            //let locationlng = locationLocation?.lng
            
            if let locationLocation = locationGeometry?.location
            {
                        Text ("Latitude:\(locationLocation.lat)")
                        Text ("Latitude:\(locationLocation.lng)")

            }// close if let locationLocation = locationGeometry?.location
            
            else
            {
                Text("Geocoding data not available")

            }// close if let locationLocation = locationGeometry?.location
             // close if let locationLatLng = addressGeocode.gcodedResultsData?.results.geometry
            
            
        }// close VStack
        .onAppear
        {
            addressGeocode.fetchLatLng(addressUncoded : addressUncoded, apiKey: apiKey)

        }// close ".onAppear"
        
    }// close var body: some View
    

    
    
} // close struct ContentView: View

//==================================================================================

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView()
    }
}

// ===================================================================================
