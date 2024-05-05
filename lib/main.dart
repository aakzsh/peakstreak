import 'package:flutter/material.dart';
import 'package:peakstreak/screens/welcome.dart';
import 'package:peakstreak/utils/theme_builder.dart';
import 'package:local_auth/local_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool authenticated = await _authenticateUser();
  runApp(App(authenticated: authenticated));
}

Future<bool> _authenticateUser() async {
  LocalAuthentication authService = LocalAuthentication();
  final bool canAuthenticateWithBiometrics =
      await authService.canCheckBiometrics;
  final bool canAuthenticate =
      canAuthenticateWithBiometrics && await authService.isDeviceSupported();

  if (canAuthenticate) {
    return await authService.authenticate(
        localizedReason: "Verify to use PeakStreak",);
  }
  return true;
}

class App extends StatelessWidget {
  const App({super.key, required this.authenticated});
  final bool authenticated;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "PeakStreak",
      home: const Welcome(),
      theme: buildTheme(Brightness.dark),
    );
  }
}
