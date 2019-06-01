var monthsNames = [
  "一月",
  "二月",
  "三月",
  "四月",
  "五月",
  "六月",
  "七月",
  "八月",
  "九月",
  "十月",
  "十一月",
  "十二月"
];

String getFormattedDate(int dueDate) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(dueDate);
  return "${monthsNames[date.month - 1]}  ${date.day}日";
}
