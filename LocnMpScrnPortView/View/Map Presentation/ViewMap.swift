//
//  ViewMap.swift
//  LocnMpScrnPortView
//
//  Created by mlittle-macmini-20200921 on 21/10/2023.
//

/*

About:
——————————————

 
 

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


import SwiftUI
import MapKit
//=============================================================================
struct ViewMap: View
{
    //———————————————————————————————————————————————————————
    //———————————————————————————————————————————————————————
    // Properties
    //@Binding var latitud: Double
    @State var latitud: Double
    
    //@Binding var longitud: Double
    @State var longitud: Double
    
    /// this initialises the map region to London, UK
    @State private var region =
            MKCoordinateRegion (
                                center: CLLocationCoordinate2D(latitude: 0.00, longitude: 0.00),
                                span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
         
                                )// close MKCoordinateRegion
    
    //mapRegionforLatLng(latitude:latitud,longitude:longitud )
    
    var body: some View
    {
        Text("Here are the parameters passed:")
        Text("latitude:\(latitud) and longitude: \(longitud)")
        
        
        Map(coordinateRegion: $region  )
            .onAppear()
            {
                region = mapRegionforLatLng(Latitude:latitud,Longitude:longitud)
            }
        
    }// close var body: some View
    
    
    //———————————————————————————————————————————————————————
    //———————————————————————————————————————————————————————
    // Methods
    
    
    //-------------------------------------------------------
    // MARK - 
    /// This method passes in the latitude and longitude and returns the MKCoordinateRegion centred on the  latitude and longitude
    func mapRegionforLatLng(Latitude: Double,Longitude: Double)-> MKCoordinateRegion
    {
        return MKCoordinateRegion  (
                                        center: CLLocationCoordinate2D(latitude: latitud, longitude: longitud),
                                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)

                                    )//close MKCoordinateRegion
    }//close

}// closestruct ViewMap: View

//=============================================================================
struct ViewMap_Previews: PreviewProvider
{
    // @State  static var latitud: Double = 0.0
   static var latitud: Double = 0.0
    
    // @State  static var longitud: Double = 0.0
    static var longitud: Double = 0.0
    
    static var previews: some View
    {
        ViewMap(latitud:latitud, longitud:longitud)
    }
}

