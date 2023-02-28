class Validators {
  String? isEmpty(value) {
    if (value.isEmpty) {
      return 'Empty field';
    } else {
      return null;
    }
  }
}
