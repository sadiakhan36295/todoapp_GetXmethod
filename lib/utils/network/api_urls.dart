class ApiUrl {
  static const String baseUrl = "http://172.252.13.83:2000/api/v1";

  // static String imageUrl({String? url}) {
  //   return "http://192.168.10.5:5005/$url";
  // }

  static String signUp = "$baseUrl/auth/signup";
   static String signIn = "$baseUrl/auth/login";

}