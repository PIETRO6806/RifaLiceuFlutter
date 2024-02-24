class ApiEndPoints {
  static final String baseUrl = 'https://rifa-liceu.glitch.me';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerEmail = '/api/users/add';
  final String loginEmail = '/api/users/getByEmail/:email';
}