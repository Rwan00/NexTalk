import 'package:get_it/get_it.dart';
import 'package:nextalk/services/media_service.dart';
import 'package:nextalk/services/navigation_service.dart';

void registerServices() {
  GetIt.instance.registerSingleton<NavigationService>(NavigationService());
  GetIt.instance.registerSingleton<MediaService>(MediaService());
}
