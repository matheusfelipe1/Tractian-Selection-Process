final class Endpoints {
  static String params = "";
  static const String getCompanies = "/companies";
  static String getAssets(String params) => "$getCompanies/$params/assets";
  static String getLocations(String params) => "$getCompanies/$params/locations";
}