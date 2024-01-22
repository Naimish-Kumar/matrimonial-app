var this_year = DateTime.now().year.toString();

class AppConfig {
  static String copyright_text = "@ Vivah.com $this_year";
  static String app_name = "Vivah";

  // enter string purchase_code here
  static String purshase_code = "";

  // configure this
  static const bool HTTPS = true;

  static const DOMAIN_PATH = "domain.com"; //localhost

  // do not configure these below
  static const String API_ENDPATH = "api";
  static const String PROTOCOL = HTTPS ? "https://" : "http://";
  static const String RAW_BASE_URL = "${PROTOCOL}${DOMAIN_PATH}";
  static const String BASE_URL = "${RAW_BASE_URL}/${API_ENDPATH}";
}
