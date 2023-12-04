//import SwiftUI
//
//struct TransformableView: View {
//    @ObservedObject var viewModel: TransformViewModel
//
//    var body: some View {
//        ZStack {
//            Image(uiImage: viewModel.image)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//
//            Image(uiImage: viewModel.transformedOverlayImage)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .opacity(0.5) // Make sure the transformed overlay is semi-transparent
//
//                .overlay(
//                    GeometryReader { geometry in
//                        DraggablePointView(position: $viewModel.topLeft)
//                          .onChange(of: viewModel.topLeft) { _ in viewModel.updateTransformedOverlayImage() }
//                        DraggablePointView(position: $viewModel.topRight)
//                          .onChange(of: viewModel.topRight) { _ in viewModel.updateTransformedOverlayImage() }
//                        DraggablePointView(position: $viewModel.bottomLeft)
//                          .onChange(of: viewModel.bottomLeft) { _ in viewModel.updateTransformedOverlayImage() }
//                        DraggablePointView(position: $viewModel.bottomRight)
//                          .onChange(of: viewModel.bottomRight) { _ in viewModel.updateTransformedOverlayImage() }
//                    }
//                )
//        }
//    }
//}
