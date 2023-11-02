//
//  LocnMpScrnPortViewApp.swift
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

@main
struct LocnMpScrnPortViewApp: App
{
    // @State  static var latitud: Double = 0.0
   var latitud: Double = 0.0
    
    // @State  static var longitud: Double = 0.0
    var longitud: Double = 0.0
    
    var body: some Scene
    {
        WindowGroup
        {
            ContentView(latitud:latitud, longitud:longitud)
            //TestMapView()
        }
    }
}
