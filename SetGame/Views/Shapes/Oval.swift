//
//  Oval.swift
//  SetGame
//
//  Created by Dmitry Reshetnik on 15.03.2021.
//

import SwiftUI

struct Oval: Shape {
    func path(in rect: CGRect) -> Path {
        let oval: Path = Capsule().path(in: rect)
        
        return oval
    }
}

struct OvalShape_Previews: PreviewProvider {
    static var previews: some View {
        Oval()
            .padding()
    }
}
