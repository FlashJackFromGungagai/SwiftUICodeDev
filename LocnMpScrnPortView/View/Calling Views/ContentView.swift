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
    //@ObservedObject var addressGeocode = addressGeoDecoding()
    /// this is creating a new Observed object instance of the class "addressGeocodeLatLng()"
    ///
    @ObservedObject var addressGeocoded = AddressDecodeLatLng()
    
    ///initialise the variables representing the latitude and longitude
    //@State var latitud:  Double = 0.00
    var latitud:  Double
    
    // @State var longitud: Double = 0.00
    var longitud: Double
    
    let addressUncoded: String = "25 grange road, kew, victoria"
    /// this represents the adress string that is to be passed in and the map presentation to be returned..
    
    ///Set the flag to show the map.
    @State var navToMapIsActive: Bool = false
    
    //———————————————————————————————————————————————————————
    // Property representing the
    var body: some View
    {
        VStack
        {
            Text ("The un-coded address: \(addressUncoded)")
            Text("The corresponding latitude and longitude is")
             
            if  latitud == addressGeocoded.retrieveLatitude()
             {
                Text("No value for latitude retrieved")
             }
            else
            {
                
                Text ("Latitude:\( latitud )")
                
            }
            
            if longitud == addressGeocoded.retrievelongitude()
            {
                Text("No value for logitude retrieved")
            }
            else
            {
                
                Text ("longitude:\( longitud  )")
            }

            Button("Show Map")
                {
                    navToMapIsActive.toggle()
                }
                .sheet(isPresented: $navToMapIsActive )
                {
                    ViewMap(latitud:latitud, longitud:longitud )
                    // this calls the coresponding map
                    
                }// close ".sheet(isPresented: $navToMapIsActive )
             
        }// close VStack
        .onAppear
        {

            /// This calls the method that fetches the latitude and longitude for the street address being passed in. 
            addressGeocoded.fetchGecondingLatLngData(addressUncoded: addressUncoded)

        }// close ".onAppear"
        
    }// close var body: some View
    
} // close struct ContentView: View

//==================================================================================

struct ContentView_Previews: PreviewProvider
{
    // @State  static var latitud: Double = 0.0
   static var latitud: Double = 0.0
    
    // @State  static var longitud: Double = 0.0
    static var longitud: Double = 0.0
    
    static var previews: some View
    {
        //ContentView()
        ContentView(latitud:latitud, longitud:longitud)
        //ViewMap(latitud:latitud, longitud:longitud)
    }
}

// ===================================================================================
