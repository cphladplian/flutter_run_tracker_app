import 'package:flutter/material.dart';
import 'package:flutter_run_tracker_app/model/run.dart';
import 'package:flutter_run_tracker_app/services/supabase_service.dart';
import 'package:intl/intl.dart';

class AddRunUi extends StatefulWidget {
  const AddRunUi({super.key});

  @override
  State<AddRunUi> createState() => _AddRunUiState();
}

class _AddRunUiState extends State<AddRunUi> {
  TextEditingController runWhereController = TextEditingController();
  TextEditingController runDistanceController = TextEditingController();
  TextEditingController runPersonController = TextEditingController();

  String? runWhere;
  double? runDistance;
  int? runPerson;

  void insertRun() async {
    if (runWhereController.text.isEmpty ||
        runDistanceController.text.isEmpty ||
        runPersonController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('กรุณากรอกข้อมูลให้ครบถ้วน'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    Run run = Run(
      where: runWhereController.text,
      distance: double.parse(runDistanceController.text),
      person: int.parse(runPersonController.text),
    );

    final service = SupabaseService();
    await service.insertRun(run);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('เพิ่มข้อมูลเรียบร้อยแล้ว'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF090359),
        title: Text(
          'Run Tracker (เพิ่ม)',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/smartwatch.png',
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: runWhereController,
                  decoration: InputDecoration(
                    labelText: 'สถานที่',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: runDistanceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'ระยะทาง (กิโลเมตร)',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: runPersonController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'จำนวนคนที่วิ่งด้วย',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: insertRun,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('เพิ่มข้อมูล',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    runWhereController.clear();
                    runDistanceController.clear();
                    runPersonController.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('ล้างข้อมูล',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ))),
      ),
    );
  }
}
