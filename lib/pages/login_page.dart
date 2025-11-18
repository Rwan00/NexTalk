Future<void> loginWithEmailAndPassword(String email, String password) async {
  try {
    isLoading = true;
    notifyListeners();
    
    await _auth.signInWithEmailAndPassword(email: email, password: password);

  } on FirebaseAuthException catch (e) {
    log(e.toString());
  } catch (e) {
    log(e.toString());
  } finally {
    isLoading = false;
    notifyListeners();
  }
}
