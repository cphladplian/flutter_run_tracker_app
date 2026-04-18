import 'package:flutter_run_tracker_app/model/run.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  Future<List<Run>> getAllRuns() async {
    final data = await supabase
        .from('run_tb')
        .select()
        .order('created_at', ascending: false);
    return data.map<Run>((e) => Run.fromJson(e)).toList();
  }

  Future insertRun(Run run) async {
    await supabase.from('run_tb').insert(run.toJson());
  }

  Future updateRun(String id, Run run) async {
    await supabase.from('run_tb').update(run.toJson()).eq('id', id);
  }

  Future deleteRun(String id) async {
    await supabase.from('run_tb').delete().eq('id', id);
  }
}