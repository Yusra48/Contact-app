import 'package:flutter_application_1/ui/Screens/AddToContacts.dart';
import 'package:flutter_application_1/ui/home/HomeView.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView, initial: true),
    MaterialRoute(page: AddToContacts),
  ],
  dependencies: [
    Singleton(classType: NavigationService),
  ],
)
class App {}
