import SwiftUI

struct DisplaySection<T: View>: View {
    
    @Environment(\.colorScheme) var colorScheme
    @StateObject var vm = ViewModel()
    
    var function: T
    
    var body: some View {
        Section {
            function
        }
        .listRowBackground(vm.background(colorScheme: colorScheme))
        .frame(maxWidth: .infinity, alignment: .center)
    }
}
