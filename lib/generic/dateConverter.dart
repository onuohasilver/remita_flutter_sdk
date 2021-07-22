DateTime convertDate(String parsedDate) {
  if (parsedDate.length <= 10) {
    return DateTime(
      int.parse(parsedDate.substring(6)),
      int.parse(parsedDate.substring(3, 5)),
      int.parse(parsedDate.substring(0, 2)),
    );
  } else {
    return DateTime(
      int.parse(parsedDate.substring(0, 4)),
      int.parse(parsedDate.substring(5, 7)),
      int.parse(parsedDate.substring(8, 10)),
      int.parse(parsedDate.substring(11, 13)),
      int.parse(parsedDate.substring(14, 16)),
      int.parse(parsedDate.substring(17, 19)),
    );
  }
}
