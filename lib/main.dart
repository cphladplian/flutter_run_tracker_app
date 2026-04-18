import 'package:flutter/material.dart';
import 'package:flutter_run_tracker_app/views/splash_screen_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main()
//----------------Setting Config Supabase----------------
async{
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: 'https://oqeumqkkvzkdparkhclq.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9xZXVtcWtrdnprZHBhcmtoY2xxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzY1MTc4MDIsImV4cCI6MjA5MjA5MzgwMn0.nk_PaR2kuAc4dPBDxG1dx85VfEuwRwErqRr5hjMH5QQ',
  );
//-------------------------------------------------------
  runApp(
    FlutterRunTrackerApp()
  );
}
 
class FlutterRunTrackerApp extends StatefulWidget {
  const FlutterRunTrackerApp({super.key});
 
  @override
  State<FlutterRunTrackerApp> createState() => _FlutterRunTrackerAppState();
}
 
class _FlutterRunTrackerAppState extends State<FlutterRunTrackerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenUi(),
      theme: ThemeData(
        textTheme: GoogleFonts.promptTextTheme(
          Theme.of(context).textTheme
        )
      ),
    );
  }
}