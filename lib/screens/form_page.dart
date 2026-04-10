import 'package:flutter/material.dart';
import '../helpers/db_helper.dart';
import '../models/mahasiswa.dart';

class FormPage extends StatefulWidget {
  final Mahasiswa? mahasiswa;

  FormPage({this.mahasiswa});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  DBHelper dbHelper = DBHelper();

  TextEditingController nama = TextEditingController();
  TextEditingController nrp = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.mahasiswa != null) {
      nama.text = widget.mahasiswa!.nama;
      nrp.text = widget.mahasiswa!.nrp;
    }
  }

  void save() async {
    if (widget.mahasiswa == null) {
      await dbHelper.insert(
        Mahasiswa(nama: nama.text, nrp: nrp.text),
      );
    } else {
      await dbHelper.update(
        Mahasiswa(
          id: widget.mahasiswa!.id,
          nama: nama.text,
          nrp: nrp.text,
        ),
      );
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Form Mahasiswa")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nama, decoration: InputDecoration(labelText: "Nama")),
            TextField(controller: nrp, decoration: InputDecoration(labelText: "NRP")),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: save,
              child: Text("Simpan"),
            )
          ],
        ),
      ),
    );
  }
}