DateTime decreaseMonth(DateTime date) {
  return date.month == 1
      ? DateTime(date.year - 1, 12, 1)
      : DateTime(date.year, date.month - 1, 1);
}

DateTime increaseMonth(DateTime date) {
  return date.month == 12
      ? DateTime(date.year + 1, 1, 1)
      : DateTime(date.year, date.month + 1, 1);
}
