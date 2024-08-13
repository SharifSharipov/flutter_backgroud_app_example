class LocationModel {
  LocationModel({this.response});

  LocationModel.fromJson(Map<String, dynamic> json) {
    response = json["response"] != null
        ? new Response.fromJson(json["response"])
        : null;
  }

  Response? response;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (response != null) {
      data["response"] = response!.toJson();
    }
    return data;
  }
}

class Response {
  Response({this.geoObjectCollection});

  Response.fromJson(Map<String, dynamic> json) {
    geoObjectCollection = json["GeoObjectCollection"] != null
        ? new GeoObjectCollection.fromJson(json["GeoObjectCollection"])
        : null;
  }

  GeoObjectCollection? geoObjectCollection;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (geoObjectCollection != null) {
      data["GeoObjectCollection"] = geoObjectCollection!.toJson();
    }
    return data;
  }
}

class GeoObjectCollection {
  GeoObjectCollection({this.metaDataProperty, this.featureMember});

  GeoObjectCollection.fromJson(Map<String, dynamic> json) {
    metaDataProperty = json["metaDataProperty"] != null
        ? new MetaDataPropertyGeoObject.fromJson(json["metaDataProperty"])
        : null;
    if (json["featureMember"] != null) {
      featureMember = <FeatureMember>[];
      json["featureMember"].forEach((v) {
        featureMember!.add(new FeatureMember.fromJson(v));
      });
    }
  }

  MetaDataPropertyGeoObject? metaDataProperty;
  List<FeatureMember>? featureMember;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (metaDataProperty != null) {
      data["metaDataProperty"] = metaDataProperty!.toJson();
    }
    if (featureMember != null) {
      data["featureMember"] =
          featureMember!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MetaDataPropertyGeoObject {
  MetaDataPropertyGeoObject({this.geocoderMetaData});

  MetaDataPropertyGeoObject.fromJson(Map<String, dynamic> json) {
    geocoderMetaData = json["GeocoderMetaData"] != null
        ? new GeocoderMetaData.fromJson(json["GeocoderMetaData"])
        : null;
  }

  GeocoderMetaData? geocoderMetaData;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (geocoderMetaData != null) {
      data["GeocoderMetaData"] = geocoderMetaData!.toJson();
    }
    return data;
  }
}

class MetaDataProperty {
  MetaDataProperty({this.geocoderResponseMetaData});

  MetaDataProperty.fromJson(Map<String, dynamic> json) {
    geocoderResponseMetaData = json["GeocoderResponseMetaData"] != null
        ? new GeocoderResponseMetaData.fromJson(json["GeocoderResponseMetaData"])
        : null;
  }

  GeocoderResponseMetaData? geocoderResponseMetaData;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (geocoderResponseMetaData != null) {
      data["GeocoderResponseMetaData"] = geocoderResponseMetaData!.toJson();
    }
    return data;
  }
}

class GeocoderResponseMetaData {
  GeocoderResponseMetaData(
      {this.point, this.request, this.results, this.found});

  GeocoderResponseMetaData.fromJson(Map<String, dynamic> json) {
    point = json["Point"] != null ? new Point.fromJson(json["Point"]) : null;
    request = json["request"];
    results = json["results"];
    found = json["found"];
  }

  Point? point;
  String? request;
  String? results;
  String? found;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (point != null) {
      data["Point"] = point!.toJson();
    }
    data["request"] = request;
    data["results"] = results;
    data["found"] = found;
    return data;
  }
}

class Point {
  Point({this.pos});

  Point.fromJson(Map<String, dynamic> json) {
    pos = json["pos"];
  }

  String? pos;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["pos"] = pos;
    return data;
  }
}

class FeatureMember {
  FeatureMember({this.geoObject});

  FeatureMember.fromJson(Map<String, dynamic> json) {
    geoObject = json["GeoObject"] != null
        ? new GeoObject.fromJson(json["GeoObject"])
        : null;
  }

  GeoObject? geoObject;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (geoObject != null) {
      data["GeoObject"] = geoObject!.toJson();
    }
    return data;
  }
}

class GeoObject {
  GeoObject(
      {this.metaDataProperty,
        this.name,
        this.description,
        this.boundedBy,
        this.uri,
        this.point});

  GeoObject.fromJson(Map<String, dynamic> json) {
    metaDataProperty = json["metaDataProperty"] != null
        ? new MetaDataProperty.fromJson(json["metaDataProperty"])
        : null;
    name = json["name"];
    description = json["description"];
    boundedBy = json["boundedBy"] != null
        ? new BoundedBy.fromJson(json["boundedBy"])
        : null;
    uri = json["uri"];
    point = json["Point"] != null ? new Point.fromJson(json["Point"]) : null;
  }

  MetaDataProperty? metaDataProperty;
  String? name;
  String? description;
  BoundedBy? boundedBy;
  String? uri;
  Point? point;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (metaDataProperty != null) {
      data["metaDataProperty"] = metaDataProperty!.toJson();
    }
    data["name"] = name;
    data["description"] = description;
    if (boundedBy != null) {
      data["boundedBy"] = boundedBy!.toJson();
    }
    data["uri"] = uri;
    if (point != null) {
      data["Point"] = point!.toJson();
    }
    return data;
  }
}

class GeocoderMetaData {
  GeocoderMetaData(
      {this.precision,
        this.text,
        this.kind,
        this.address,
        this.addressDetails});

  GeocoderMetaData.fromJson(Map<String, dynamic> json) {
    precision = json["precision"];
    text = json["text"];
    kind = json["kind"];
    address =
    json["Address"] != null ? new Address.fromJson(json["Address"]) : null;
    addressDetails = json["AddressDetails"] != null
        ? new AddressDetails.fromJson(json["AddressDetails"])
        : null;
  }

  String? precision;
  String? text;
  String? kind;
  Address? address;
  AddressDetails? addressDetails;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["precision"] = precision;
    data["text"] = text;
    data["kind"] = kind;
    if (address != null) {
      data["Address"] = address!.toJson();
    }
    if (addressDetails != null) {
      data["AddressDetails"] = addressDetails!.toJson();
    }
    return data;
  }
}

class Address {
  Address({this.countryCode, this.formatted, this.components});

  Address.fromJson(Map<String, dynamic> json) {
    countryCode = json["country_code"];
    formatted = json["formatted"];
    if (json["Components"] != null) {
      components = <Components>[];
      json["Components"].forEach((v) {
        components!.add(new Components.fromJson(v));
      });
    }
  }

  String? countryCode;
  String? formatted;
  List<Components>? components;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["country_code"] = countryCode;
    data["formatted"] = formatted;
    if (components != null) {
      data["Components"] = components!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Components {
  Components({this.kind, this.name});

  Components.fromJson(Map<String, dynamic> json) {
    kind = json["kind"];
    name = json["name"];
  }

  String? kind;
  String? name;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["kind"] = kind;
    data["name"] = name;
    return data;
  }
}

class AddressDetails {
  AddressDetails({this.country, this.address});

  AddressDetails.fromJson(Map<String, dynamic> json) {
    country =
    json["Country"] != null ? new Country.fromJson(json["Country"]) : null;
    address = json["Address"];
  }

  Country? country;
  String? address;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (country != null) {
      data["Country"] = country!.toJson();
    }
    data["Address"] = address;
    return data;
  }
}

class Country {
  Country(
      {this.addressLine,
        this.countryNameCode,
        this.countryName,
        this.administrativeArea});

  Country.fromJson(Map<String, dynamic> json) {
    addressLine = json["AddressLine"];
    countryNameCode = json["CountryNameCode"];
    countryName = json["CountryName"];
    administrativeArea = json["AdministrativeArea"] != null
        ? new AdministrativeArea.fromJson(json["AdministrativeArea"])
        : null;
  }

  String? addressLine;
  String? countryNameCode;
  String? countryName;
  AdministrativeArea? administrativeArea;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["AddressLine"] = addressLine;
    data["CountryNameCode"] = countryNameCode;
    data["CountryName"] = countryName;
    if (administrativeArea != null) {
      data["AdministrativeArea"] = administrativeArea!.toJson();
    }
    return data;
  }
}

class AdministrativeArea {
  AdministrativeArea({this.administrativeAreaName, this.subAdministrativeArea});

  AdministrativeArea.fromJson(Map<String, dynamic> json) {
    administrativeAreaName = json["AdministrativeAreaName"];
    subAdministrativeArea = json["SubAdministrativeArea"] != null
        ? new SubAdministrativeArea.fromJson(json["SubAdministrativeArea"])
        : null;
  }

  String? administrativeAreaName;
  SubAdministrativeArea? subAdministrativeArea;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["AdministrativeAreaName"] = administrativeAreaName;
    if (subAdministrativeArea != null) {
      data["SubAdministrativeArea"] = subAdministrativeArea!.toJson();
    }
    return data;
  }
}

class SubAdministrativeArea {
  SubAdministrativeArea({this.subAdministrativeAreaName});

  SubAdministrativeArea.fromJson(Map<String, dynamic> json) {
    subAdministrativeAreaName = json["SubAdministrativeAreaName"];
  }

  String? subAdministrativeAreaName;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["SubAdministrativeAreaName"] = subAdministrativeAreaName;
    return data;
  }
}

class BoundedBy {
  BoundedBy({this.envelope});

  BoundedBy.fromJson(Map<String, dynamic> json) {
    envelope = json["Envelope"] != null
        ? new Envelope.fromJson(json["Envelope"])
        : null;
  }

  Envelope? envelope;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (envelope != null) {
      data["Envelope"] = envelope!.toJson();
    }
    return data;
  }
}

class Envelope {
  Envelope({this.lowerCorner, this.upperCorner});

  Envelope.fromJson(Map<String, dynamic> json) {
    lowerCorner = json["lowerCorner"];
    upperCorner = json["upperCorner"];
  }

  String? lowerCorner;
  String? upperCorner;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["lowerCorner"] = lowerCorner;
    data["upperCorner"] = upperCorner;
    return data;
  }
}
