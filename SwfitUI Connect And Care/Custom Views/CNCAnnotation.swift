//
//  CNCAnnotation.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation

class CustomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var image: UIImage?

    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, image: UIImage?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }
}

// Create the custom view
struct CustomAnnotationView: View {
    var annotation: CustomAnnotation

    var body: some View {
        ZStack {
            Image(uiImage: annotation.image!)
            Text(annotation.title!)
                .font(.headline)
            Text(annotation.subtitle!)
                .font(.subheadline)
        }
    }
}
