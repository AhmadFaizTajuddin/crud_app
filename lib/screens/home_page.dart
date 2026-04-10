import 'package:flutter/material.dart';
import '../helpers/db_helper.dart';
import '../models/mahasiswa.dart';
import 'form_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DBHelper dbHelper = DBHelper();
  List<Mahasiswa> list = [];

  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh() async {
    var data = await dbHelper.getAll();
    setState(() {
      list = data;
    });
  }

  void delete(int id) async {
    await dbHelper.delete(id);
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Data Mahasiswa")),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_, i) {
          return ListTile(
            title: Text(list[i].nama),
            subtitle: Text(list[i].nrp),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FormPage(mahasiswa: list[i]),
                      ),
                    );
                    refresh();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => delete(list[i].id!),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => FormPage()),
          );
          refresh();
        },
      ),
    );
  }
}