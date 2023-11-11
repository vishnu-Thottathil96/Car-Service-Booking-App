enum AuthenticationPage {
  login,
  signUp,
}

enum AuthExceptions {
  initial,
  weekPassword,
  wrongPassword,
  userNotFound,
  emailAlreadyExist,
  loginSuccess,
  signUpSuccess,
  somethingWentWrong,
  verified,
}

enum ServiceStatus {
  rejected,
  pending,
  booked,
  inProgress,
  finished,
}
