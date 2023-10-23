//
//  ContentView.swift
//  TestMap
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

struct TestMapView: View
{   //melbourne, victoria
    //@State var lat: Double = -37.8136
    //@State var lng: Double = 144.9631
    
    // perth, Western Australia
    @State var lat: Double = -31.9523
    @State var lng: Double = 115.8613
    
    
    
    @State var navToMapIsActive: Bool = false
    
    
 
    var body: some View
    {
        NavigationView
        {
            VStack
            {
                Text("Show the map for the following location:")
                Text("latitude:\(lat) and longitude: \(lng)")
                Button("Show Map")
                {
                    navToMapIsActive.toggle()
                }
                .sheet(isPresented: $navToMapIsActive )
                {
                    ViewMap(lat:$lat,lng:$lng )
                    
                }// close ".sheet(isPresented: $navToMapIsActive )
            }// closeVStack
        
        
        }// close NavigationView

        

        
     }//close var body: some View
}

struct TestMapView_Previews: PreviewProvider
{
    static var previews: some View
    {
        TestMapView()
    }
}
