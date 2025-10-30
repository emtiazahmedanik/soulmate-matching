/// Exception class for handling various errors.
class UExceptions implements Exception {
  /// The associated error message.
  final String message;

  /// Default constructor with a generic error message.
  const UExceptions([
    this.message = 'An unexpected error occurred. Please try again.',
  ]);

  /// Create an authentication exception from a Firebase authentication exception code.
  factory UExceptions.fromCode(String code) {
    switch (code) {
      case 'email-already-in-use':
        return const UExceptions(
          'The email address is already registered. Please use a different email.',
        );
      case 'invalid-email':
        return const UExceptions(
          'The email address provided is invalid. Please enter a valid email.',
        );
      case 'weak-password':
        return const UExceptions(
          'The password is too weak. Please choose a stronger password.',
        );
      case 'user-disabled':
        return const UExceptions(
          'This user account has been disabled. Please contact support for assistance.',
        );
      case 'user-not-found':
        return const UExceptions('Invalid login details. User not found.');
      case 'wrong-password':
        return const UExceptions(
          'Incorrect password. Please check your password and try again.',
        );
      case 'INVALID_LOGIN_CREDENTIALS':
        return const UExceptions(
          'Invalid login credentials. Please double-check your information.',
        );
      case 'too-many-requests':
        return const UExceptions('Too many requests. Please try again later.');
      case 'invalid-argument':
        return const UExceptions(
          'Invalid argument provided to the authentication method.',
        );
      case 'invalid-password':
        return const UExceptions('Incorrect password. Please try again.');
      case 'invalid-phone-number':
        return const UExceptions('The provided phone number is invalid.');
      case 'operation-not-allowed':
        return const UExceptions(
          'The sign-in provider is disabled for your Firebase project.',
        );
      case 'session-cookie-expired':
        return const UExceptions(
          'The Firebase session cookie has expired. Please sign in again.',
        );
      case 'uid-already-exists':
        return const UExceptions(
          'The provided user ID is already in use by another user.',
        );
      case 'sign_in_failed':
        return const UExceptions('Sign-in failed. Please try again.');
      case 'network-request-failed':
        return const UExceptions(
          'Network request failed. Please check your internet connection.',
        );
      case 'internal-error':
        return const UExceptions('Internal error. Please try again later.');
      case 'invalid-verification-code':
        return const UExceptions(
          'Invalid verification code. Please enter a valid code.',
        );
      case 'invalid-verification-id':
        return const UExceptions(
          'Invalid verification ID. Please request a new verification code.',
        );
      case 'quota-exceeded':
        return const UExceptions('Quota exceeded. Please try again later.');
      default:
        return const UExceptions();
    }
  }
}
