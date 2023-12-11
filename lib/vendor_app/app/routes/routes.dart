import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:vendor_app/vendor_app/auth/presentation/views/auth_signup_page.dart';
import 'package:vendor_app/vendor_app/home/views/home_layout.dart';

import '../../../core/services/shared_values.dart';
import '../../auth/data/model/user_model.dart';
import '../../auth/presentation/views/auth_signin_page.dart';

class RoutesConfig {
  static GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) async {
          if (FirebaseAuth.instance.currentUser != null) {
            final data = await FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .get();
            if (data.exists) {
              final user = UserModel.fromMap(data.data()!);
              userData.setIfChanged(user.toMap());
              userData.save();

              if (user.active) {
                return '/home';
              } else {
                return null;
              }
            }
            
          }
          return null;
        },
        builder: (context, state) => const AuthSignInPage(),
        routes: [
          GoRoute(
            path: 'signup',
            builder: (context, state) => const AuthSignUpPage(),
          ),
        ],
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeLayout(),
      ),
    ],
  );
}
