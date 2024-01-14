split(input, String pattern, {int position = 0}) {
  final parsedInput = input.toString();
  if (position == -1) return parsedInput.split(pattern);
  return parsedInput.split(pattern)[position];
}

bool valueNotEmpty(input) {
  return input.toString().isNotEmpty;
}
