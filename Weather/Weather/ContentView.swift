//
//  ContentView.swift
//  Weather
//
//  Created by iVan on 9/8/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            
            // Background gradient
            Background(topColor: .blue, bottomColor: Color("lightBlue"))
            
            VStack(spacing: 1) {
                Text("Yaoundé, Cameroon")
                    .font(.system(size: 25, weight: .regular, design: .default))
                    .foregroundColor(.white)
                    .padding()
                VStack {
                    Image(systemName: "cloud.sun.fill")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180, height: 150)
                    Text("30°").font(.system(size: 70, weight: .medium)).foregroundColor(.white)
                }
                .padding(.bottom, 50)
                HStack(spacing: 20) {

                    WeatherDayView(day: "SAT", imageName: "moon.stars.fill", temp: 18)

                    WeatherDayView(day: "SUN", imageName: "cloud.fill", temp: 25)

                    WeatherDayView(day: "MON", imageName: "cloud.sun.fill", temp: 30)

                    WeatherDayView(day: "TUE", imageName: "sun.haze.fill", temp: 19)

                    WeatherDayView(day: "WED", imageName: "sun.max.fill", temp: 35)

                    WeatherDayView(day: "THU", imageName: "cloud.rain.fill", temp: 28)

                }
                Spacer()

                Button {
                    print("tapped")
                } label: {
                    Text("Change Day Time").frame(width: 280, height: 50)
                        .background(Color.white)
                        .font(.system(size: 20, weight: .bold, design: .default)).cornerRadius(10)
                }

                Spacer()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WeatherDayView: View {
    var day: String
    var imageName: String
    var temp: Int
    
    var body: some View {
        VStack() {
            Text(day)
                .font(.system(size: 20, weight: .medium, design: .default))
                .foregroundColor(.white)
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text("\(temp)°").font(.system(size: 20, weight: .bold)).foregroundColor(.white)
            
        }
    }
}

struct Background: View {
    var topColor: Color
    var bottomColor: Color
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [topColor, bottomColor]),
                       startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}
