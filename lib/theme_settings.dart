import 'package:hive/hive.dart';

part 'theme_settings.g.dart';

@HiveType(typeId: 0)
class ThemeSettings {
  @HiveField(0)
  bool isDarkMode;

  ThemeSettings({required this.isDarkMode});
}
