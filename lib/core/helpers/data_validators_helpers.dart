String? valueIsNotEmpty(String? input, {String errorMessage = ""}) {
  if (input == null || input.isEmpty) return errorMessage;

  return null;
}

String? notContains(String? input, String pattern, {String errorMessage = ""}) {
  if (input != null && input.contains(pattern)) return errorMessage;

  return null;
}

