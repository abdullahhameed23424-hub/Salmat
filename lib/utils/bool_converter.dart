bool boolConverter(dynamic value) {
  return value == 1 ||
          value == '1' ||
          value == 'yes' ||
          value == 'Yes' ||
          value == 'YES' ||
          value == 'ok' ||
          value == 'Ok' ||
          value == 'OK' ||
          value == 'true' ||
          value == true
      ? true
      : false;
}

String stringOrZero(dynamic str) {
  // take number and return it as string or '0'
  if (str == null) return "0";
  return str.toString();
}

String stringOrEmpty(dynamic str) {
  // take number and return it as string or ''
  if (str == null) return "";
  return str.toString();
}
