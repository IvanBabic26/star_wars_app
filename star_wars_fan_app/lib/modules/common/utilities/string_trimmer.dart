class StringTrimmer {
  trimmer(String? string) {
    if (string != null) {
      final lastTwoString = string.substring(string.length - 2);
      final indexNumberString = lastTwoString.substring(0, 1);
      final indexNumber = int.parse(indexNumberString);
      // print(indexNumber);
      return indexNumber;
    } else {
      return null;
    }
  }
}
