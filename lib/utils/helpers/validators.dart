String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Name is required';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }

  //   add more complex email validation logic
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  //  add more password validation logic
  return null;
}

String? validateConfirmPassword(String? value, String password) {
  if (value == null || value.isEmpty) {
    return 'Confirm Password is required';
  }
  if (value != password) {
    return 'Passwords do not match';
  }
  return null;
}

String? validateCarYear(String? value) {
  if (value == null ||
      value.isEmpty ||
      int.tryParse(value)! > DateTime.now().year) {
    return 'valid Year is required';
  }

  //   add more complex email validation logic
  return null;
}

String? validateRegisterNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Number is required';
  }

  //   add more complex email validation logic
  return null;
}
