//
//  AttributedDemoView.swift
//  Wubi
//
//  Created by yongyou on 2024/3/12.
//

import SwiftUI

struct Greeting: View {
        @ViewBuilder var hello: some View {
            Image(systemName: "hand.wave")
            Text("Hello")
        }
        @ViewBuilder var bye: some View {
            Text("And Goodbye!")
            Image(systemName: "hand.wave")
        }
        var body: some View { HStack(spacing: 20) {
            hello
                .border(.blue)
            Spacer()
            bye
        }
    }
}


struct AttributedDemoView: View {
    var message: AttributedString {
        let amount = Measurement(value: 200, unit: UnitLength.kilometers)
        var result = amount.formatted(.measurement(width: .wide).attributed)

        let distanceStyling = AttributeContainer.font(.title)
        let distance = AttributeContainer.measurement(.value)
        result.replaceAttributes(distance, with: distanceStyling)

        return result
    }


    var body: some View {

        /*
        VStack {
            Text(message)
            Button("登录/注册1") {

            }
            .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
            .cornerRadius(15)
            Button("登录/注册2") {

            }
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 38, leading: 15, bottom: 38, trailing: 15))
            .background(Color.gray)
            .clipShape(Circle())

            Button("登录/注册3") {

            }
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 38, leading: 15, bottom: 38, trailing: 15))
            .background(Color.gray)
            .clipShape(Circle())

            Button("登录/注册4") {

            }
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 38, leading: 15, bottom: 38, trailing: 15))
            .background(Color.gray)
            .clipShape(Circle())

            Button("登录/注册5") {

            }
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(.orange, lineWidth: 2)

            )
            Button("登录/注册6") {

            }
            .overlay(Circle().stroke(.orange, lineWidth: 2))
        }*/
        VStack {
            Text("Hello")
                .padding()
                .background(Color.blue)
            
            Text("Hello")
                .background(Color.blue)
                .padding()
        }
        
//            .backgroundStyle(.blue)
    }
         
}

struct RegistrationView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""

    var body: some View {
        Form {
            Text("Create a New Account")
                .font(.title2)

            TextField("Username", text: $username)
            SecureField("Password", text: $password)
            SecureField("Confirm Password", text: $confirmPassword)

            HStack {
                Button("Cancel", role: .cancel) {
                }

                Button("Register") {
                    // Perform registration logic
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.top)
        }
        .frame(maxWidth: 400)
        .formStyle(.grouped)
    }
}

struct Note {
    var title: String
    var content: String
}

struct NoteDetailView: View {
    @State private var note =  Note(title: "Meeting Notes", content: "- Discuss project timeline\n- Assign tasks to team members\n- Set next meeting date")
    @State private var fontSize: CGFloat = 15
    @State private var isPresentedInspector = false
    var sidebarIcon: String {
#if os(iOS)
        "slider.horizontal.3"
#else
        "sidebar.trailing"
#endif
    }
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text(note.title)
                    .font(.headline)
                TextEditor(text: $note.content)
                    .font(.system(size: fontSize))
            }
            .padding()
            .toolbar(content: {
                Button(action: {
                    isPresentedInspector.toggle()
                }, label: {
                    Label("Show Note Settings", systemImage: sidebarIcon)
                })
            })
            .navigationTitle("My Note")
            .inspector(isPresented: $isPresentedInspector) {
                FormExampleView(fontSize: $fontSize)
            }
        }
    }
}

struct FormExampleView: View {
    @Binding var fontSize: CGFloat
    @State private var showLineNumbers = false
    @State private var showPreview = true
    var body: some View {
        Form {
            Section("Notes Font Size \(Int(fontSize))") {
                Slider(value: $fontSize, in: 10...40, step: 1) {
                    Text("Point Size \(Int(fontSize))")
                }
            }
            Section("Display") {
                Toggle(isOn: $showLineNumbers, label: {
                    Text("Show Line Numbers")
                })
                Toggle(isOn: $showPreview, label: {
                    Text("Show Preview")
                })
            }
        }
    }
}

struct Person {
    var fullName: String
    var title: String
    var profileColor: Color
    var initials: String

}

struct LabelDemo: View {

    @State var person:Person = Person(fullName: "Duke", title: "iOSer", profileColor: .red, initials: "D")
    var body: some View {
        Label {
            Text(person.fullName)
                .font(.body)
                .foregroundColor(.primary)
            Text(person.title)
                .font(.subheadline)
                .foregroundColor(.secondary)
        } icon: {
            Circle()
                .fill(person.profileColor)
                .frame(width: 44, height: 44, alignment: .center)
                .overlay(Text(person.initials))
        }
    }
}

struct LabelContentDemeo: View {
    @State var value: String
    @State var selection: Int
    var body: some View {
        Form {
            LabeledContent("Custom Value") {
//                MyCustomView(value: $value)
                Text(value)
            }
            Picker("Selected Value", selection: $selection) {
                Text("Option 1").tag(1)
                Text("Option 2").tag(2)
            }
        }
    }
}


#Preview {
//    AttributedDemoView()
//    RegistrationView()
//    NoteDetailView()
//    Greeting()
//        .frame(width: 300,height: 300)
//    LabelDemo()
    LabelContentDemeo(value: "value", selection: 1)
}
