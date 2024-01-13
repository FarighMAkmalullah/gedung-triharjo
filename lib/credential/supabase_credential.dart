import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCredentials {
  static const String ApiKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind2c3J6ZnJubnVjcnpjbGtlb2xiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDM0MTc2MTcsImV4cCI6MjAxODk5MzYxN30.uEoVEFDVIFz1_pByiNOJPGNePH0c2M-5GvdBSF8NQ18";
  static const String ApiUrl = "https://wvsrzfrnnucrzclkeolb.supabase.co";
  static SupabaseClient supabaseClient = SupabaseClient(ApiUrl, ApiKey);
}
