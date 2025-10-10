import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'home_screen.dart';
import 'signin_screen.dart';

/// Authentication gate that determines which screen to show based on UserProvider state
class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        // Show loading screen while initializing or loading data
        if (userProvider.isLoading) {
          return const Scaffold(
            backgroundColor: Color(0xFF2C3E50),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Color(0xFFA3EBB1),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Veriler yükleniyor...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Show error if there's an error
        if (userProvider.error != null) {
          return Scaffold(
            backgroundColor: const Color(0xFF2C3E50),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 64,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Hata: ${userProvider.error}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => userProvider.clearError(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('İptal'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () => userProvider.retryLoadUserData(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFA3EBB1),
                          foregroundColor: const Color(0xFF2C3E50),
                        ),
                        child: const Text('Tekrar Dene'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }

        // Check if user is authenticated
        if (userProvider.isAuthenticated) {
          // User is authenticated, go to home screen
          return const HomeScreen();
        }

        // User is not authenticated, show sign in screen
        return const SignInScreen();
      },
    );
  }
}
