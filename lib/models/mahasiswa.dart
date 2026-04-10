class Mahasiswa {
  int? id;
  String nama;
  String nrp;

  Mahasiswa({this.id, required this.nama, required this.nrp});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'nrp': nrp,
    };
  }

  factory Mahasiswa.fromMap(Map<String, dynamic> map) {
    return Mahasiswa(
      id: map['id'],
      nama: map['nama'],
      nrp: map['nrp'],
    );
  }
}