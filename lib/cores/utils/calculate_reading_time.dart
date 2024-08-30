int calculateReadingTime(String content) {
  // calculate the time based on the number of words present
  // to get the total number of words, use regex

  // speed = distance/time

  // calculate distance
  final wordCound = content.split(RegExp(r'\s+')).length;

  // let speed = 225 (avg reading speed per min)
  final readingTime = wordCound / 225;
  return readingTime.ceil();
}
