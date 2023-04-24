//
//  ContentView.swift
//  Calories
//
//  Created by Zagham Arshad on 28/03/2023.
//

import SwiftUI

struct CalorieCounterView: View {
    @State private var totalCalories = 0
    @State private var breakfastCalories = 0
    @State private var lunchCalories = 0
    @State private var snackCalories = 0
    @State private var dinnerCalories = 0
    
    var body: some View {
        VStack(spacing: 0) {
            // Top section with username and notifications icon
            HStack {
                Text("Welcome, Username!")
                Spacer()
                Image(systemName: "bell")
            }
            .font(.headline)
            .padding()
            
            // Display of total calories consumed in a speedometer design
            SpeedometerView(totalCalories: $totalCalories)
                .padding()
            
            // Section with Breakfast, Lunch, Snack, and Dinner sub-sections
            VStack(spacing: 16) {
                SectionView(title: "Breakfast", calories: $breakfastCalories)
                SectionView(title: "Lunch", calories: $lunchCalories)
                SectionView(title: "Snack", calories: $snackCalories)
                SectionView(title: "Dinner", calories: $dinnerCalories)
            }
            .padding()
            .background(
                Image("food-background")
                    .resizable()
                    .scaledToFill()
                    .blur(radius: 10)
            )
            .cornerRadius(20)
            .padding()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

struct SectionView: View {
    let title: String
    @Binding var calories: Int
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            Spacer()
            
            Button(action: {
                calories += 100
            }) {
                Image(systemName: "plus.circle.fill")
                    .font(.title)
                    .foregroundColor(.white)
            }
        }
        .padding(.vertical, 8)
        .background(Color.green)
        .cornerRadius(10)
    }
}

struct SpeedometerView: View {
    @Binding var totalCalories: Int
    
    var body: some View {
        VStack {
            Text("Total Calories")
                .font(.headline)
                .foregroundColor(.gray)
            Spacer()
            ZStack {
                Circle()
                    .stroke(Color.gray, lineWidth: 20)
                Arc(startAngle: .degrees(-90), endAngle: .degrees(Double(totalCalories) / 2000 * 360 - 90))
                    .stroke(Color.green, lineWidth: 20)
                Text("\(totalCalories)")
                    .font(.largeTitle)
                    .bold()
            }
            Spacer()
            Text("2000 kcal")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

struct Arc: Shape {
    let startAngle: Angle
    let endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        return path
    }
}

struct CalorieCounterView_Previews: PreviewProvider {
    static var previews: some View {
        CalorieCounterView()
    }
}

