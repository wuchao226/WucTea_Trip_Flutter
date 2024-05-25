///搜索模型
class SearchModel {
  ///搜索关键字，非接口返回
  String? keyword;
  int? code;
  List<SearchItem>? data;

  SearchModel({code, data});

  SearchModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <SearchItem>[];
      json['data'].forEach((v) {
        data!.add(SearchItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchItem {
  String? code;
  String? word;
  String? type;
  String? price;
  String? zonename;
  String? star;
  String? districtname;
  String? url;

  SearchItem({code, word, type, price, zonename, star, districtname, url});

  SearchItem.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    word = json['word'];
    type = json['type'];
    price = json['price'];
    zonename = json['zonename'];
    star = json['star'];
    districtname = json['districtname'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['word'] = word;
    data['type'] = type;
    data['price'] = price;
    data['zonename'] = zonename;
    data['star'] = star;
    data['districtname'] = districtname;
    data['url'] = url;
    return data;
  }
}
