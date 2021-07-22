DateTime convertDate(String parsedDate) {
  return DateTime(
    int.parse(parsedDate.substring(6)),
    int.parse(parsedDate.substring(3, 5)),
    int.parse(parsedDate.substring(0, 2)),
  );
}
