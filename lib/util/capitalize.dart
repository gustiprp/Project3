String capitalize(String value) {

  if (value == null) return '';

  return '${value[0].toUpperCase()}${value.substring(1)}';
}