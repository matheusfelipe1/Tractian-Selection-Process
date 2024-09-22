extension MapExtensions on Map {
  T getOrDefaultValue<T>({
    required String key,
    required T defaultValue,
  }) {
    if (containsKey(key)) {
      final value = this[key];
      if (value == null) return defaultValue;
      return value as T;
    } else {
      return defaultValue;
    }
  }

  T getValue<T>({required String key}) {
    return this[key] as T;
  }
}
