abstract interface class AuthRemoteSource {

   Future<String> signupWithEmailAndPassword({
    required String username,
    required String email,
    required String password
   });

   Future<String> signinWithEmailAndPassword({
    
    required String email,
    required String password
   });
}