import '../Client/ui/screens/main_page.dart';
import '../Client/ui/screens/settings_page.dart';
import '../Client/ui/screens/larder_page.dart';
import '../Client/ui/screens/store_page.dart';
import '../Client/ui/screens/help_page.dart';

typedef T Constructor<T>();

final Map<String, Constructor<Object>> _constructors = <String, Constructor<Object>>{};

void register<T>(Constructor<T> constructor) {
  _constructors[T.toString()] = constructor;
}

class ClassBuilder {
  static void registerClasses() {
    register<MainPage>(() => MainPage());
    register<SettingsPage>(() => SettingsPage());
    register<LarderPage>(() => LarderPage());
    register<StorePage>(() => StorePage());
    register<HelpPage>(() => HelpPage());
  }

  static dynamic fromString(String type) {
    return _constructors[type]();
  }
}
