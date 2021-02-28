import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/enums/leaps_state_enums.dart';
import 'core/themes/leaps_theme.dart';
import 'features/authentication/data/models/user.dart';
import 'features/authentication/data/services/auth_service.dart';
import 'features/authentication/data/services/regions_service.dart';
import 'features/authentication/data/services/user_services.dart';
import 'features/authentication/presentation/helpers/auth_notifier.dart';
import 'features/notes/data/services/note_service.dart';
import 'features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'features/profile/data/services/firebase_storage_service.dart';
import 'features/profile/data/services/image_picker_service.dart';
import 'features/search/data/services/connectivity_service.dart';
import 'features/search/data/services/resource_service.dart';
import 'src/app_host.dart';

class App extends StatelessWidget {
  final bool onBoardingStatus;
  App(this.onBoardingStatus);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /*Provider<AuthService>(
            builder: (_) => FirebaseAuthService(),
            dispose: (_, AuthService authService) => authService.dispose,
          ),*/
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        Provider<ResourceService>(
          create: (_) => ResourceService(),
        ),
        Provider<UserService>(
          create: (_) => UserService(),
        ),
        Provider<NoteService>(
          create: (_) => NoteService(),
        ),
        Provider<RegionService>(
          create: (_) => RegionService(),
        ),
        Provider<ImagePickerService>(
          create: (_) => ImagePickerService(),
        ),
        Provider<FirebaseStorageService>(
          create: (_) => FirebaseStorageService(),
        ),
        Provider<User>(
          create: (_) => User(),
        ),
        /*Provider<ConnectivityService>(
          create: (_) => ConnectivityService(),
          dispose: (context, value) => value.dispose(),
        ),*/
        StreamProvider<ConnectionStatus>(
          create: (_) => ConnectivityService().connectivityController.stream,
          builder: (context) => ConnectivityService().dispose(),
        ),
        ChangeNotifierProvider<AuthNotifier>.value(
          value: AuthNotifier(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Leaps',
        theme: leapsTheme,
        /*initialRoute: RoutePaths.MyApp,*/
        /*onGenerateRoute: Router.generateRoute,*/
        home:onBoardingStatus ? MyApp() :  OnBoardingScreen(),
      ),
    );
  }
}