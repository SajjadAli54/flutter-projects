class MyJwtToken {
  static const String token = "my_token";
}

class Api {
  static const String _url = "https://pspapi.eraconnect.net/api/",
      loginUrl = "https://pspapi.eraconnect.net/api/account/login/",
      getRegionsUrl = "$_url/region",
      getZonesUrl = '$_url/Zone/zones/', // Need Id
      postZonesUrl = "$_url/Zone/"; // Need Id
}
