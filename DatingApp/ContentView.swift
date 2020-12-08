//
//  ContentView.swift
//  DatingApp
//
//  Created by Mohammed on 11/20/20.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @AppStorage("log_Status") var status = false
    @StateObject var model = ModelData()
    
    var body: some View {
        
        ZStack{
            
            if status{
                
                VStack(spacing: 25){
                    
                    Text("Logged In As \(Auth.auth().currentUser?.email ?? "")")
                    
                    Button(action: model.logOut, label: {
                        Text("LogOut")
                            .fontWeight(.bold)
                    })
                }
            }
            else{
                
                LoginView(model: model)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}


struct LoginView : View {
    
    @ObservedObject var model : ModelData
    
    var body: some View{
        
        ZStack{
            
            VStack{
                
                Spacer(minLength: 0)
                
                ZStack{
                    
                    if UIScreen.main.bounds.height < 750{
                        
                        Image("logo")
                            .resizable()
                            .frame(width: 130, height: 130)
                    }
                    else{
                        Image("logo")
                    }
                }
                .padding(.horizontal)
                .padding(.vertical,20)
                .background(Color.white.opacity(0.2))
                .cornerRadius(30)
                .padding(.top)
                
                VStack(spacing: 4){
                    
                    HStack(alignment: .center, spacing: 0){
                        Text("Login")
                            .font(.system(size: 35, weight: .heavy))
                            .foregroundColor(.white)
                        
                        Text("App")
                            .font(.system(size: 35, weight: .heavy))
                            .foregroundColor(Color("txt"))
                        
                    }
                    
                    Text("Lets choose your match")
                        .foregroundColor(Color.black.opacity(0.3))
                        .fontWeight(.heavy)
                    
                }
                .padding(.top)
                
                VStack(spacing:      20){
                    
                    CustomTextField(image: "person", palceHolder: "Email", txt: $model.email)
                    
                    CustomTextField(image: "lock", palceHolder: "Password", txt: $model.password)
                }
                .padding(.top)
                
                Button(action: {model.login()}) {
                    
                    Text("LOGIN")
                        .fontWeight(.bold)
                        .foregroundColor(Color("bottom"))
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(Color.black.opacity(0.8))
                        .clipShape(Capsule())
                }
                .padding(.top,22)
                
                HStack(spacing: 12){
                    
                    Text("Don't have an account?")
                        .foregroundColor(Color.black.opacity(0.7))
                    
                    Button(action: {model.isSignUp.toggle()}) {
                        
                        Text("Sign Up Now")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                }
                .padding(.top,25)
                
                Spacer(minLength: 0)
                
                Button(action: {model.resetPassword()}) {
                    
                    Text("Forget Password?")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
                .padding(.vertical,22)
                
            }
            
            if model.isLoading{
                
                LoadingView()
            }
            
        }
        .background(LinearGradient(gradient: .init(colors: [Color("top"), Color("bottom")]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all, edges: .all))
        .fullScreenCover(isPresented: $model.isSignUp) {
            
            SignUpView(model: model)
        }
        // Alerts...
        .alert(isPresented: $model.alert) {
            
            Alert(title: Text("Message"), message: Text(model.alertMsg), dismissButton: .destructive(Text("Ok")))
        }
        
        
        
    }
    
}

struct CustomTextField: View {
    
    var image: String
    var palceHolder: String
    
    @Binding var txt: String
    
    var body: some View{
        
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
            
            Image(systemName: image)
                .font(.system(size: 24))
                .foregroundColor(Color("bottom"))
                .frame(width: 60, height: 60)
                .background(Color.black)
                .clipShape(Circle())
            
            ZStack{
                
                if palceHolder == "Password" || palceHolder == "Re-Enter"{
                    SecureField(palceHolder, text: $txt)
                }
                else{
                    TextField(palceHolder, text: $txt)
                }
            }
            .padding(.horizontal)
            .padding(.leading,65)
            .frame(height: 60)
            .background(Color.white.opacity(0.2))
            .clipShape(Capsule())
            
        }
        .padding(.horizontal)
        
    }
    
}

struct SignUpView: View {
    
    @ObservedObject var model : ModelData
    
    var body: some View{
        
        
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
            
            VStack{
                
                Spacer(minLength: 0)
                
                ZStack{
                    
                    if UIScreen.main.bounds.height < 750{
                        
                        Image("logo")
                            .resizable()
                            .frame(width: 130, height: 130)
                    }
                    else{
                        Image("logo")
                    }
                }
                .padding(.horizontal)
                .padding(.vertical,20)
                .background(Color.white.opacity(0.2))
                .cornerRadius(30)
                .padding(.top)
                
                VStack(spacing: 4){
                    
                    HStack(alignment: .center, spacing: 0){
                        Text("New")
                            .font(.system(size: 35, weight: .heavy))
                            .foregroundColor(.white)
                        
                        Text("Profile")
                            .font(.system(size: 35, weight: .heavy))
                            .foregroundColor(Color("txt"))
                        
                    }
                    
                    Text("Create your profile !")
                        .foregroundColor(Color.black.opacity(0.3))
                        .fontWeight(.heavy)
                    
                }
                .padding(.top)
                
                VStack(spacing: 20){
                    
                    CustomTextField(image: "person", palceHolder: "Email", txt: $model.emailSignUp)
                    
                    CustomTextField(image: "lock", palceHolder: "Password", txt: $model.passwordSignUp)
                    
                    CustomTextField(image: "lock", palceHolder: "Re-Enter", txt: $model.reEnterPasswordSignUp)
                }
                .padding(.top)
                
                Button(action: model.signUp) {
                    
                    Text("SIGNUP")
                        .fontWeight(.bold)
                        .foregroundColor(Color("bottom"))
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(Color.black)
                        .clipShape(Capsule())
                }
                .padding(.vertical,22)
                
                Spacer(minLength: 0)
            }
            
            Button(action: {model.isSignUp.toggle()}) {
                
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.6))
                    .clipShape(Circle())
            }
            .padding(.trailing)
            .padding(.top,10)
            
            if model.isLoading{
                
                LoadingView()
            }
            
        })
        .background(LinearGradient(gradient: .init(colors: [Color("top"),Color("bototom")]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all, edges: .all))
        .alert(isPresented: $model.alert, content: {
            
            Alert(title: Text("Message"), message: Text(model.alertMsg), dismissButton: .destructive(Text("Ok"), action: {
                
                // if email link sent means closing the signupView....
                if model.alertMsg == "Email Verification Has Been Sent !!! Verify Your Email ID !!!"{
                    
                    model.isSignUp.toggle()
                    model.emailSignUp = ""
                    model.passwordSignUp = ""
                    model.reEnterPasswordSignUp = ""
                }
                
            }))
        })
        
    }
}

// MVVM Model.....

class ModelData : ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var isSignUp = false
    @Published var emailSignUp = ""
    @Published var passwordSignUp = ""
    @Published var reEnterPasswordSignUp = ""
    @Published var resetEmail = ""
    @Published var isLinkSend = false
    
    // Error Alerts...
    
    @Published var alert = false
    @Published var alertMsg = ""
    
    // Loading ...
    
    @Published var isLoading = false
    
    // User Status....
    
    @AppStorage("log_Status") var status = false
    
    // resetPassword...
    func resetPassword(){
        
        let alert = UIAlertController(title: "Reset Password", message: "Enter Your E-Mail ID To Reset Your Password", preferredStyle: .alert)
        
        alert.addTextField { (password) in
            password.placeholder = "Email"
        }
        
        let proceed = UIAlertAction(title: "Reset", style: .default) { (_) in
            
            self.resetEmail = alert.textFields![0].text!
            
            self.isLinkSend.toggle()
            
            // Sending Password Link...
            
            if alert.textFields![0].text! != ""{
                
                withAnimation{
                    
                    self.isLoading.toggle()
                }
                
                Auth.auth().sendPasswordReset(withEmail: alert.textFields![0].text!) { (err) in
                    
                    withAnimation{
                        
                        self.isLoading.toggle()
                    }
                    
                    if err != nil{
                        self.alertMsg = err!.localizedDescription
                        self.alert.toggle()
                        return
                    }
                    
                    // ALerting User...
                    self.alertMsg = "Password Reset Link Has Been Sent !!!"
                    self.alert.toggle()
                }
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(proceed)
        
        // Presenting...
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
    }
    
    // Login...
    func login(){
        
        
        // checking all fields are inputted correctly...
        
        if email == "" || password == ""{
            print("Login")
            self.alertMsg = "Fill the contents properly !!!"
            self.alert.toggle()
            return
        }
        
        withAnimation{
            
            self.isLoading.toggle()
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
            
            withAnimation{
                
                self.isLoading.toggle()
            }
            
            if err != nil{
                
                self.alertMsg = err!.localizedDescription
                self.alert.toggle()
                return
            }
            
            // checking if user is verifed or not...
            // if not verified means lgging out...
            
            let user = Auth.auth().currentUser
            
            if !user!.isEmailVerified{
                
                self.alertMsg = "Please Verify Email Address!!!"
                self.alert.toggle()
                // logging out...
                try! Auth.auth().signOut()
                
                return
            }
            
            // setting user status as true....
            
            withAnimation{
                
                self.status = true
            }
        }
    }
    
    // SignUp..
    func signUp(){
        
        // checking....
        
        if emailSignUp == "" || passwordSignUp == "" || reEnterPasswordSignUp == ""{
            
            self.alertMsg = "Fill contents proprely!!!"
            self.alert.toggle()
            return
        }
        
        if passwordSignUp != reEnterPasswordSignUp{
            
            self.alertMsg = "Password Mismatch !!!"
            self.alert.toggle()
            return
        }
        
        withAnimation{
            
            self.isLoading.toggle()
        }
        
        Auth.auth().createUser(withEmail: emailSignUp, password: passwordSignUp) { (result, err) in
            
            withAnimation{
                
                self.isLoading.toggle()
            }
            
            if err != nil{
                self.alertMsg = err!.localizedDescription
                self.alert.toggle()
                return
            }
            
            // sending Verifcation Link....
            
            result?.user.sendEmailVerification(completion: { (err) in
                
                if err != nil{
                    self.alertMsg = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                
                // Alerting User To Verify Email...
                
                self.alertMsg = "Email Verification Has Been Sent !!! Verify Your Email ID !!!"
                self.alert.toggle()
            })
        }
    }
    
    // log Out...
    func logOut(){
        
        try! Auth.auth().signOut()
        
        withAnimation{
            
            self.status = false
        }
        
        // clearing all data...
        
        email = ""
        password = ""
        emailSignUp = ""
        passwordSignUp = ""
        reEnterPasswordSignUp = ""
    }
    
}




// Loading View...

struct LoadingView : View {
    
    @State var animation = false
    
    var body: some View{
        
        VStack{
            
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(Color("bottom"),lineWidth: 8)
                .frame(width: 75, height: 75)
                .rotationEffect(.init(degrees: animation ? 360 : 0))
                .padding(50)
        }
        .background(Color.white)
        .cornerRadius(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.4).ignoresSafeArea(.all, edges: .all))
        .onAppear(perform: {
            
            withAnimation(Animation.linear(duration: 1)){
                
                animation.toggle()
            }
        })
    }
}
