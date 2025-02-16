import SwiftUI
import AppKit

struct MouseEventView: NSViewRepresentable {
    class MouseEventNSView: NSView {
        override init(frame frameRect: NSRect) {
            super.init(frame: frameRect)
            trackingArea = NSTrackingArea(rect: frameRect,
                                        options: [.mouseEnteredAndExited, .mouseMoved, .activeInKeyWindow],
                                        owner: self)
            addTrackingArea(trackingArea)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private var trackingArea: NSTrackingArea!
        
        override func mouseMoved(with event: NSEvent) {
            NSSound.beep()
        }
        
        override func updateTrackingAreas() {
            super.updateTrackingAreas()
            removeTrackingArea(trackingArea)
            trackingArea = NSTrackingArea(rect: bounds,
                                        options: [.mouseEnteredAndExited, .mouseMoved, .activeInKeyWindow],
                                        owner: self)
            addTrackingArea(trackingArea)
        }
    }
    
    func makeNSView(context: Context) -> NSView {
        return MouseEventNSView(frame: .zero)
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {}
}

struct ContentView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
            
            MouseEventView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
} 
