//
//  LocationsView.swift
//  MapSitesApp
//
//  Created by Marshall  on 6/16/22.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    let maxWidthForiPad: CGFloat = 700
   
    var body: some View {
        ZStack {
            mapLayer
            VStack(spacing: 0){
                header
                .padding()
                .frame(maxWidth: maxWidthForiPad)
                Spacer()
                
                locationsStack
            }
        }
        .sheet(item: $vm.sheetLocation, onDismiss: nil) { location in
            LocationsLearnMoreSheet(location: location)
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}


extension LocationsView {
    
    private var header: some View {
        
            VStack {
                Button {
                    vm.toggleLocationsList()
                } label: {
                    //Title Text
                    Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName )
                        .font(.title2)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .animation(.none, value: vm.mapLocation)
                        .overlay(alignment: .leading) {
                            //Title Arrow
                            Image(systemName: "arrow.down")
                                .font(.headline)
                                .foregroundColor(.primary)
                                .padding()
                                .rotationEffect(Angle(degrees: vm.showLocationsList ? -180 : 0))
                        }
                }
                
                if vm.showLocationsList {
                    LocationsListView()
                }
                
            }
            .background(.thickMaterial)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
        
    }
    
    private var mapLayer: some View {
        Map(coordinateRegion: $vm.mapRegion, annotationItems: vm.locations) { location in
            //MapMarker(coordinate: location.coordinates, tint: .blue)
            MapAnnotation(coordinate: location.coordinates) {
                MapAnnotationView()
                    .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        vm.showNextLocation(location: location)
                    }
            }
        }
        .ignoresSafeArea()
    }
    
    private var locationsStack: some View {
        ZStack{
            ForEach(vm.locations) { location in
                if vm.mapLocation == location {
                LocationPreviewView(location: location)
                    .shadow(color: Color.black.opacity(0.3), radius: 20)
                    .padding()
                    .frame(maxWidth: maxWidthForiPad)
                    .frame(maxWidth: .infinity)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
            }
        }
    }
}
