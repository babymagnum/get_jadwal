class Day {
  String? day;
  String? code;

  Day(this.day, this.code);

  Day.empty();

  bool get isEmpty {
    return day == null && code == null;
  }
}