import SwiftUI
import ARKit
import RealityKit

struct ARNavigationView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @State private var arView = ARView()
    @State private var isARReady = false
    
    var body: some View {
        ZStack {
            // AR View
            ARViewContainer(arView: $arView, isReady: $isARReady)
                .edgesIgnoringSafeArea(.all)
            
            // Overlay controls
            VStack {
                if !isARReady {
                    ProgressView("Initializing AR...")
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(10)
                }
                
                Spacer()
                
                // Navigation instructions
                if let currentInstruction = navigationViewModel.currentInstruction {
                    VStack {
                        Text(currentInstruction.description)
                            .font(.headline)
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        
                        Text("\(Int(currentInstruction.distance)) feet")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            setupAR()
        }
    }
    
    private func setupAR() {
        // Configure AR session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        
        arView.session.run(config)
        
        // Add navigation arrows
        addNavigationArrows()
    }
    
    private func addNavigationArrows() {
        // Create arrow entity
        let arrowMesh = MeshResource.generateBox(size: 0.1)
        let arrowMaterial = SimpleMaterial(color: .blue, isMetallic: false)
        let arrowEntity = ModelEntity(mesh: arrowMesh, materials: [arrowMaterial])
        
        // Position arrow based on next instruction
        if let nextInstruction = navigationViewModel.currentInstruction {
            let position = calculateArrowPosition(for: nextInstruction)
            arrowEntity.position = position
            
            // Add to AR scene
            let anchor = AnchorEntity(plane: .horizontal)
            anchor.addChild(arrowEntity)
            arView.scene.addAnchor(anchor)
        }
    }
    
    private func calculateArrowPosition(for instruction: NavigationInstruction) -> SIMD3<Float> {
        // This would calculate the actual position based on the instruction
        // For now, return a mock position
        return SIMD3<Float>(x: 0, y: 0, z: -1)
    }
}

struct ARViewContainer: UIViewRepresentable {
    @Binding var arView: ARView
    @Binding var isReady: Bool
    
    func makeUIView(context: Context) -> ARView {
        arView.session.delegate = context.coordinator
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, ARSessionDelegate {
        var parent: ARViewContainer
        
        init(_ parent: ARViewContainer) {
            self.parent = parent
        }
        
        func session(_ session: ARSession, didUpdate frame: ARFrame) {
            parent.isReady = true
        }
    }
} 