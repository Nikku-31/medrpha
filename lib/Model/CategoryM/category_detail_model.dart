class CategoryDetailResponseModel {
  final bool success;
  final String message;
  final List<CategoryDetailProductModel> data;

  CategoryDetailResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CategoryDetailResponseModel.fromJson(Map<String, dynamic> json) {
    return CategoryDetailResponseModel(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      data: (json["data"] as List<dynamic>?)
          ?.map((e) => CategoryDetailProductModel.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
      "data": data.map((e) => e.toJson()).toList(),
    };
  }
}

class CategoryDetailProductModel {
  final int? pid;
  final String? productName;
  final int? status;
  final String? productImg;
  final DateTime? currentDatetime;
  final int? userid;
  final int? compid;
  final String? companyName;
  final int? productTypeid;
  final String? hsnValue;
  final num? comPriceR;
  final num? comPriceD;
  final num? retailerPercent;
  final num? distributerPercent;
  final int? unittypeid;
  final int? categorySelectId;
  final String? categoryName;
  final String? description;
  final int? adminId;
  final int? saleqtyid;
  final String? ddlhsnvalue;
  final int? hdndlyesno;
  final num? quantitymin;
  final int? adminIdn;

  CategoryDetailProductModel({
    this.pid,
    this.productName,
    this.status,
    this.productImg,
    this.currentDatetime,
    this.userid,
    this.compid,
    this.companyName,
    this.productTypeid,
    this.hsnValue,
    this.comPriceR,
    this.comPriceD,
    this.retailerPercent,
    this.distributerPercent,
    this.unittypeid,
    this.categorySelectId,
    this.categoryName,
    this.description,
    this.adminId,
    this.saleqtyid,
    this.ddlhsnvalue,
    this.hdndlyesno,
    this.quantitymin,
    this.adminIdn,
  });

  factory CategoryDetailProductModel.fromJson(Map<String, dynamic> json) {
    return CategoryDetailProductModel(
      pid: json["pid"],
      productName: json["product_name"],
      status: json["status"],
      productImg: json["product_img"],
      currentDatetime: json["current_datetime"] == null
          ? null
          : DateTime.tryParse(json["current_datetime"]),
      userid: json["userid"],
      compid: json["compid"],
      companyName: json["compnay_name"],
      productTypeid: json["product_typeid"],
      hsnValue: json["hsn_value"],
      comPriceR: json["com_price_R"],
      comPriceD: json["com_price_D"],
      retailerPercent: json["hdnretailerpercentrs"],
      distributerPercent: json["hdndistributerpercentrs"],
      unittypeid: json["unittypeid"],
      categorySelectId: json["hdncategoryselect"],
      categoryName: json["category_name"],
      description: json["description"],
      adminId: json["adminId"],
      saleqtyid: json["saleqtyid"],
      ddlhsnvalue: json["ddlhsnvalue"],
      hdndlyesno: json["hdndlyesno"],
      quantitymin: json["quantitymin"],
      adminIdn: json["adminIdn"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "pid": pid,
      "product_name": productName,
      "status": status,
      "product_img": productImg,
      "current_datetime": currentDatetime?.toIso8601String(),
      "userid": userid,
      "compid": compid,
      "compnay_name": companyName,
      "product_typeid": productTypeid,
      "hsn_value": hsnValue,
      "com_price_R": comPriceR,
      "com_price_D": comPriceD,
      "hdnretailerpercentrs": retailerPercent,
      "hdndistributerpercentrs": distributerPercent,
      "unittypeid": unittypeid,
      "hdncategoryselect": categorySelectId,
      "category_name": categoryName,
      "description": description,
      "adminId": adminId,
      "saleqtyid": saleqtyid,
      "ddlhsnvalue": ddlhsnvalue,
      "hdndlyesno": hdndlyesno,
      "quantitymin": quantitymin,
      "adminIdn": adminIdn,
    };
  }

  CategoryDetailProductModel copyWith({
    int? pid,
    String? productName,
    int? status,
    String? productImg,
    DateTime? currentDatetime,
    int? userid,
    int? compid,
    String? companyName,
    int? productTypeid,
    String? hsnValue,
    num? comPriceR,
    num? comPriceD,
    num? retailerPercent,
    num? distributerPercent,
    int? unittypeid,
    int? categorySelectId,
    String? categoryName,
    String? description,
    int? adminId,
    int? saleqtyid,
    String? ddlhsnvalue,
    int? hdndlyesno,
    num? quantitymin,
    int? adminIdn,
  }) {
    return CategoryDetailProductModel(
      pid: pid ?? this.pid,
      productName: productName ?? this.productName,
      status: status ?? this.status,
      productImg: productImg ?? this.productImg,
      currentDatetime: currentDatetime ?? this.currentDatetime,
      userid: userid ?? this.userid,
      compid: compid ?? this.compid,
      companyName: companyName ?? this.companyName,
      productTypeid: productTypeid ?? this.productTypeid,
      hsnValue: hsnValue ?? this.hsnValue,
      comPriceR: comPriceR ?? this.comPriceR,
      comPriceD: comPriceD ?? this.comPriceD,
      retailerPercent: retailerPercent ?? this.retailerPercent,
      distributerPercent: distributerPercent ?? this.distributerPercent,
      unittypeid: unittypeid ?? this.unittypeid,
      categorySelectId: categorySelectId ?? this.categorySelectId,
      categoryName: categoryName ?? this.categoryName,
      description: description ?? this.description,
      adminId: adminId ?? this.adminId,
      saleqtyid: saleqtyid ?? this.saleqtyid,
      ddlhsnvalue: ddlhsnvalue ?? this.ddlhsnvalue,
      hdndlyesno: hdndlyesno ?? this.hdndlyesno,
      quantitymin: quantitymin ?? this.quantitymin,
      adminIdn: adminIdn ?? this.adminIdn,
    );
  }
}
