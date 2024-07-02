class Location {
  late dynamic status,
      country,
      countryCode,
      region,
      regionName,
      city,
      zip,
      timezone,
      isp,
      org,
      as,
      query;
  late double lat, lon;

  Location.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    country = json['country'];
    countryCode = json['countryCode'];
    region = json['region'];
    regionName = json['regionName'];
    city = json['city'];
    zip = json['zip'];
    lat = json['lat'];
    lon = json['lon'];
    timezone = json['timezone'];
    isp = json['isp'];
    org = json['org'];
    as = json['as'];
    query = json['query'];
  }
}
