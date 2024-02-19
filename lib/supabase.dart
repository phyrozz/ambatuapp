import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuth {
  final supabaseClient = Supabase.instance.client;

  Future<Set<Object?>> signIn(
      {required String email, required String password}) async {
    final response = await supabaseClient.auth
        .signInWithPassword(email: email, password: password);

    final Session? session = response.session;
    final User? user = response.user;

    return {session, user};
  }

  Future<Set<Object?>> signUp(
      {required String email, required String password}) async {
    final response =
        await supabaseClient.auth.signUp(email: email, password: password);

    final Session? session = response.session;
    final User? user = response.user;

    return {session, user};
  }

  Future<void> signOut() async {
    await supabaseClient.auth.signOut();
  }
}
