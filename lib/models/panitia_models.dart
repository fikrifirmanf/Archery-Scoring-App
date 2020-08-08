class PanitiaModel {
  List<Panitia> panitia;

  PanitiaModel({this.panitia});

  PanitiaModel.fromJson(Map<String, dynamic> json) {
    if (json['panitia'] != null) {
      panitia = new List<Panitia>();
      json['panitia'].forEach((v) {
        panitia.add(new Panitia.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.panitia != null) {
      data['panitia'] = this.panitia.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Panitia {
  String id;
  String namaPanitia;
  String username;
  String createdAt;
  String updatedAt;
  String deletedAt;

  Panitia(
      {this.id,
      this.namaPanitia,
      this.username,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Panitia.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaPanitia = json['nama_panitia'];
    username = json['username'];
    createdAt = json['created_at'] == null ? null : json['created_at'];
    updatedAt = json['updated_at'] == null ? null : json['updated_at'];
    deletedAt = json['deleted_at'] == null ? null : json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_panitia'] = this.namaPanitia;
    data['username'] = this.username;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
