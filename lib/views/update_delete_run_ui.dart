import 'package:flutter/material.dart';
import 'package:flutter_run_tracker_app/model/run.dart';
import 'package:flutter_run_tracker_app/services/supabase_service.dart';
import 'package:intl/intl.dart';

class UpdateDeleteRunUi extends StatefulWidget {
  Run? run;

  UpdateDeleteRunUi({super.key, this.run});
  @override
  State<UpdateDeleteRunUi> createState() => _UpdateDeleteRunUiState();
}

class _UpdateDeleteRunUiState extends State<UpdateDeleteRunUi> {
  TextEditingController runWhereController = TextEditingController();
  TextEditingController runDistanceController = TextEditingController();
  TextEditingController runPersonController = TextEditingController();

  String? runWhere;
  double? runDistance;
  int? runPerson;

  @override
  void initState() {
    super.initState();
    runWhereController.text = widget.run?.where ?? '';
    runDistanceController.text = widget.run?.distance.toString() ?? '';
    runPersonController.text = widget.run?.person.toString() ?? '';
  }

  void updateRun() async {
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
      id: widget.run!.id,
      where: runWhereController.text,
      distance: double.parse(runDistanceController.text),
      person: int.parse(runPersonController.text),
    );

    final service = SupabaseService();
    await service.updateRun(widget.run!.id!, run);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('อัปเดตข้อมูลเรียบร้อยแล้ว'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    Navigator.pop(context, true);
  }

  Future<void> deleteRun() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text('ยืนยันการลบข้อมูล'),
          content: Text('คุณต้องการลบข้อมูลนี้หรือไม่?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text(
                'ยกเลิก',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final service = SupabaseService();
                await service.deleteRun(widget.run!.id!);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('ลบข้อมูลเรียบร้อยแล้ว'),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                  ),
                );

                // ปิด dialog ก่อน
                Navigator.of(context).pop();

                // แล้วค่อยกลับหน้าหลัก พร้อมส่งค่า true
                Navigator.of(context).pop(true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: Text(
                'ยืนยันลบข้อมูล',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF090359),
        title: Text(
          'Run Tracker (แก้ไข/ลบ)',
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
                  onPressed: updateRun,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text(
                    'อัปเดตข้อมูล',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: deleteRun,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text(
                    'ลบข้อมูล',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
