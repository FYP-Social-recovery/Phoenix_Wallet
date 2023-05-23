import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:pheonix_wallet_app/src/controllers/app_binding.dart';
import 'package:pheonix_wallet_app/src/screens/distribution_screens/add_shareholders_screen.dart';
import 'package:pheonix_wallet_app/src/screens/distribution_screens/distribute_shares_screen_1.dart';
import 'package:pheonix_wallet_app/src/screens/distribution_screens/distribute_shares_screen_2.dart';
import 'package:pheonix_wallet_app/src/screens/distribution_screens/distribute_shares_screen_3.dart';
import 'package:pheonix_wallet_app/src/screens/distribution_screens/shareholder_status_screen.dart';
import 'package:pheonix_wallet_app/src/screens/home_screen.dart';
import 'package:pheonix_wallet_app/src/screens/navigation_screen.dart';
import 'package:pheonix_wallet_app/src/screens/mnemonic_phrase_screen.dart';
import 'package:pheonix_wallet_app/src/screens/import_wallet_screen.dart';
import 'package:pheonix_wallet_app/src/screens/registration_screen.dart';
import 'package:pheonix_wallet_app/src/screens/splash_screen.dart';
import 'package:pheonix_wallet_app/src/screens/distribution_screens/shareholder_requests_screen.dart';

import 'controllers/settings_controller.dart';
import 'screens/settings_screens/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          // Remove debug
          debugShowCheckedModeBanner: false,

          initialBinding: AppBinding(),

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
            // Locale('si', ''), // Sinhala, no country code
          ],

          // locale: const Locale('si', ''),

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case SplashScreen.routeName:
                    return SplashScreen();
                  case MnemonicPhraseScreen.routeName:
                    return MnemonicPhraseScreen();
                  case ImportWalletScreen.routeName:
                    return ImportWalletScreen();
                  case NavigationScreen.routeName:
                    return NavigationScreen();
                  case RegistrationScreen.routeName:
                    return RegistrationScreen();
                  case AddShareholdersScreen.routeName:
                    return AddShareholdersScreen();
                  case ShareHolderRequestsScreen.routeName:
                    return ShareHolderRequestsScreen();
                  case ShareHolderStatusScreen.routeName:
                    return ShareHolderStatusScreen();
                  case DistributeSharesScreen1.routeName:
                    return DistributeSharesScreen1();
                  case DistributeSharesScreen2.routeName:
                    return DistributeSharesScreen2();
                  case DistributeSharesScreen3.routeName:
                    return DistributeSharesScreen3();
                  // case HomeScreen.routeName:
                  //   return HomeScreen();
                  default:
                    return SplashScreen();
                }
              },
            );
          },
        );
      },
    );
  }
}
