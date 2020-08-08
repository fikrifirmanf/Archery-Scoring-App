class PesertaModel {
  List<Peserta> peserta;

  PesertaModel({this.peserta});

  PesertaModel.fromJson(Map<String, dynamic> json) {
    if (json['peserta'] != null) {
      peserta = new List<Peserta>();
      json['peserta'].forEach((v) {
        peserta.add(new Peserta.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.peserta != null) {
      data['peserta'] = this.peserta.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Peserta {
  String uuid;
  String uuidPeserta;
  int seri1;
  int seri2;
  int seri3;
  int seri4;
  int seri5;
  int seri6;
  int total;
  int sesi;
  String uuidRules;
  String uuidPanitia;
  String createdAt;
  String updatedAt;
  String deletedAt;
  String noTarget;
  String namaPeserta;
  String jk;
  String kelas;
  String team;
  String kategori;
  String nama;
  int jmlSeri;
  int jmlPanah;
  String uuidRonde;
  int jarak;
  String uuidKelas;
  String uuidKategori;

  Peserta(
      {this.uuid,
      this.uuidPeserta,
      this.seri1,
      this.seri2,
      this.seri3,
      this.seri4,
      this.seri5,
      this.seri6,
      this.total,
      this.sesi,
      this.uuidRules,
      this.uuidPanitia,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.noTarget,
      this.namaPeserta,
      this.jk,
      this.kelas,
      this.team,
      this.kategori,
      this.nama,
      this.jmlSeri,
      this.jmlPanah,
      this.uuidRonde,
      this.jarak,
      this.uuidKelas,
      this.uuidKategori});

  Peserta.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    uuidPeserta = json['uuid_peserta'];
    seri1 = json['seri_1'];
    seri2 = json['seri_2'];
    seri3 = json['seri_3'];
    seri4 = json['seri_4'];
    seri5 = json['seri_5'];
    seri6 = json['seri_6'];
    total = json['total'];
    sesi = json['sesi'];
    uuidRules = json['uuid_rules'];
    uuidPanitia = json['uuid_panitia'];
    createdAt = json['created_at'] == null ? null : json['created_at'];
    updatedAt = json['updated_at'] == null ? null : json['updated_at'];
    deletedAt = json['deleted_at'] == null ? null : json['deleted_at'];
    noTarget = json['no_target'];
    namaPeserta = json['nama_peserta'];
    jk = json['jk'];
    kelas = json['kelas'];
    team = json['team'];
    kategori = json['kategori'];
    nama = json['nama'];
    jmlSeri = json['jml_seri'] == null ? null : json['jml_seri'];
    jmlPanah = json['jml_panah'] == null ? null : json['jml_panah'];
    uuidRonde = json['uuid_ronde'];
    jarak = json['jarak'];
    uuidKelas = json['uuid_kelas'];
    uuidKategori = json['uuid_kategori'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['uuid_peserta'] = this.uuidPeserta;
    data['seri_1'] = this.seri1;
    data['seri_2'] = this.seri2;
    data['seri_3'] = this.seri3;
    data['seri_4'] = this.seri4;
    data['seri_5'] = this.seri5;
    data['seri_6'] = this.seri6;
    data['total'] = this.total;
    data['sesi'] = this.sesi;
    data['uuid_rules'] = this.uuidRules;
    data['uuid_panitia'] = this.uuidPanitia;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['no_target'] = this.noTarget;
    data['nama_peserta'] = this.namaPeserta;
    data['jk'] = this.jk;
    data['kelas'] = this.kelas;
    data['team'] = this.team;
    data['kategori'] = this.kategori;
    data['nama'] = this.nama;
    data['jml_seri'] = this.jmlSeri;
    data['jml_panah'] = this.jmlPanah;
    data['uuid_ronde'] = this.uuidRonde;
    data['jarak'] = this.jarak;
    data['uuid_kelas'] = this.uuidKelas;
    data['uuid_kategori'] = this.uuidKategori;
    return data;
  }
}
