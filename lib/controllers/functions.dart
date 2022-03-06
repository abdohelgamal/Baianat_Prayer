///This function takes a date and returns a [DateTime] before the date given starting with day one
DateTime decreaseMonth(DateTime date) {
  return date.month == 1
      ? DateTime(date.year - 1, 12, 1)
      : DateTime(date.year, date.month - 1, 1);
}

///This function takes a date and returns a [DateTime] after the date given starting with day one
DateTime increaseMonth(DateTime date) {
  return date.month == 12
      ? DateTime(date.year + 1, 1, 1)
      : DateTime(date.year, date.month + 1, 1);
}
