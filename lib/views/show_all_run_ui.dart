import 'package:flutter/material.dart';
import 'package:flutter_run_tracker_app/model/run.dart';
import 'package:flutter_run_tracker_app/services/supabase_service.dart';
import 'package:flutter_run_tracker_app/views/add_run_ui.dart';
import 'package:flutter_run_tracker_app/views/update_delete_run_ui.dart';

class ShowAllRunUi extends StatefulWidget {
  const ShowAllRunUi({super.key});

  @override
  State<ShowAllRunUi> createState() => _ShowAllRunUiState();
}

class _ShowAllRunUiState extends State<ShowAllRunUi> {
  List<Run> runs = [];
  final service = SupabaseService();
  void getAllRun() async {
    final data = await service.getAllRuns();
    setState(() {
      runs = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getAllRun();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF090359),
        title: Text(
          'Run Tracker',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Image.asset(
              'assets/images/fitness.png',
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: runs.length,
                itemBuilder: (context, index) {
                  final run = runs[index];
                  return Padding(
                    padding:
                        EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
                    child: ListTile(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateDeleteRunUi(run: run),
                          ),
                        );

                        if (result == true) {
                          getAllRun();
                        }
                      },
                      leading: Image.asset('assets/images/smartwatch.png'),
                      title: Text(
                        'สถานที่: ${runs[index].where}',
                      ),
                      subtitle: Text(
                        'ระยะทาง: ${runs[index].distance.toStringAsFixed(1)} km',
                      ),
                      trailing: Icon(
                        Icons.info,
                        color: Colors.red,
                      ),
                      tileColor:
                          index % 2 == 0 ? Colors.blue[50] : Colors.blue[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddRunUi()),
          );

          if (result == true) {
            getAllRun();
          }
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color(0xFF090359),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
