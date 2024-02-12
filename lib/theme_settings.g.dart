// theme_settings.g.dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ThemeSettingsAdapter extends TypeAdapter<ThemeSettings> {
  @override
  final int typeId = 0;

  @override
  ThemeSettings read(BinaryReader reader) {
    return ThemeSettings(
      isDarkMode: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, ThemeSettings obj) {
    writer.writeBool(obj.isDarkMode);
  }
}
