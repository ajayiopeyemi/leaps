import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'core/navigation/notifiers/leaps_navigation_state_notifier.dart';
import 'features/on_boarding/presentation/helpers/on_boarding_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) =>
      OnBoardingHelper.getOnBoardingStatus().then((value){
        print('Status is: $value');
        runApp(ChangeNotifierProvider<LeapsNavigationStateNotifier>(
          create: (BuildContext context) => LeapsNavigationStateNotifier(),
          child: App(value),
        ));
      })
  );
}
