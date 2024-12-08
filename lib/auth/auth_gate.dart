// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class AuthGate extends StatelessWidget {
//   const AuthGate({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           // Show loading indicator while checking auth state
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           // If user is logged in, redirect to home
//           if (snapshot.hasData) {
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               context.go("/home");
//             });
//             // Return a placeholder widget while redirecting
//             return const Center(child: CircularProgressIndicator());
//           }

//           // If user is not logged in, redirect to splash
//           if (!snapshot.hasData) {
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               context.go("/");
//             });
//             // Return a placeholder widget while redirecting
//             return const Center(child: CircularProgressIndicator());
//           }

//           return const Center(child: CircularProgressIndicator());
//         },
//       ),
//     );
//   }
// }
