String humanizeCategory(String category) {
  List<String> listSubStrings = category.split('.');
  return listSubStrings[1];
}
