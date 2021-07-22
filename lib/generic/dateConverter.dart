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

///Converted directly from the JS code courtesy Iyare Diagboya
String requestTS() {
  DateTime d = DateTime.now();
  var dd = d.day.toString();
  var mm = d.month.toString();
  var yyyy = d.year.toString();
  if (int.parse(dd) < 10) {
    dd = '0' + dd.toString();
  }
  if (int.parse(mm) < 10) {
    mm = '0' + mm;
  }

  var hours = d.hour.toString();
  var minutes = d.minute.toString();
  var seconds = d.second.toString();
  var timeStamp = yyyy +
      '-' +
      mm +
      '-' +
      dd +
      'T' +
      hours +
      ':' +
      minutes +
      ':' +
      seconds +
      '+000000';

  return timeStamp;
}
