// ignore_for_file: prefer_interpolation_to_compose_strings, constant_identifier_names

class ApiEndpoints {
  // https://ksa.renterz.com/

  //Register
  // static const IMAGE_URL = "https://renterz.com/";
  // static const STAGING_URL = "https://renterz.com/api/";
  // static const STAGING_URL = "https://renterz.com/api/";
  static const PREFIX = "landloard/";

  // static String LOGIN_API = PREFIX + "login";
  static String Register_API = PREFIX + "register";
  static String LOGOUT_API = PREFIX + "logout";
  static String LOGIN_API = PREFIX + "login";
  // static String LOGIN_API = PREFIX + "login" + addTestData();
  // static String Register_API = PREFIX + "register" + addTestData();
  // static String LOGOUT_API = PREFIX + "logout" + addTestData();
  // static String VERIFICATION_API = PREFIX + "verification" + addTestData();
  // static String RESEND_VERIFICATION_API = PREFIX + "resend" + addTestData();
  static String VERIFICATION_API = PREFIX + "verification";
  static String RESEND_VERIFICATION_API = PREFIX + "resend";

  static const String GET_Filtered_PROPERTIES_API = "v2/property";
  static const String GET_PROPERTIES_API = "property";
  static const String FAVORITE_API = PREFIX + "favorite";

  static const String GET_TENANTED_PROPERTIES = "tenant";

  static const String GET_VisitedProperties_API = PREFIX + "job";
  static const String LOGOUT_REQUEST_API = PREFIX + "logout";
  static const String PROFILE_IMAGE_API = PREFIX + "document";
  static const String REPAIR_IMAGE_API = "landloard/repair/document/";
  static const String Add_IMAGE_To_Property_API = PREFIX + "property/document/";
  static const String REQUEST_PROPERTY_OFFER_API = "tenant/offer";
  static const String GET_USER_PROPERTIES_API = PREFIX + "property";
  static const String ESCALATE_REQUEST_API = PREFIX + "repair/escalate/";
  static const String ADD_JOB_API_Repair = PREFIX + "repair";
  static const String ADD_PROPERTY_API = PREFIX + "property";
  static const String GET_CHAT_USERS_API = PREFIX + "chat";
  static const String GET_CHAT_WITH_USER_API = PREFIX + "conversation";
  static const String SEND_MESSAGE_API = PREFIX + "message";
  static const String SEND_FCM_TOKEN_API = PREFIX + "fcm_token";
  static const String ADDRESSES_POSTCODE =
      "https://api.ideal-postcodes.co.uk/v1/postcodes/";

  static const String CATEGORY_LIST = "agent/categories";
  static const String AUTO_ASSIGN = "homeowner/auto_assign_quotation/";
  static const String ADD_JOB_API = PREFIX + "job";
  static const String ADD_JOB_DONE = "landloard/job/done";
  static const String LANDLOARD_MYJOB_VIEW = PREFIX + "my_propery_job_view";
  static const String LANDLOARD_MYJOB_DETAILS =
      PREFIX + "my_property_job_view_detail/";
  static const String LANDLOARD_ACCPECT_REJECT_JOB =
      PREFIX + "accept_reject_view_request";
  static const String LANDLOARD_CHANGE__JOB =
      PREFIX + "view_request_alternate_date";
  static const String GET_USER_NOTIFICATIONS_API = PREFIX + "notification";
  static const String DELETE_USER_ROLE = PREFIX + "delete";
  static const String MANAGE_PLAN = 'landloard/manage_plans';
  static const String MAKE_PAYMENT = 'landloard/payment';
  static const String TENANT_REPAIR_LIST = "tenant/repair-request-list";
  static const String LANDLORD_REPAIR_LIST = "landloard/repair-request-list";
  static const String UPDATE_REPAIR_REQUEST =
      "landloard/update-repair-request"; // 1=> Landloard will handle it, 2=>Escalate to us
  static const String GIVE_RATING = 'tenant/give-rating';

  //MARK: HOMEVIEWER
  static const String ADD_TASK = 'homeowner/create_task';
  static const String TASK_LIST = 'homeowner/task_list/';
  static const String TASK_DETAILS = 'homeowner/task_detail/';
  static const String TASK_DELETE = 'homeowner/delete_task';
  static const String REVIEW_LIST = 'homeowner/my_rating_list';
  static const String PROFILE_HOME = 'landloard/profile';
  static const String UPDATE_PROFILE = 'landloard/update-profile';
  static const String SOCIAL_LOGIN = 'landloard/social-login';
  static const String PAYMENT_HISTORY = 'homeowner/payment_history';
  static const String TRACK_CONTRACTOR = 'homeowner/contractor_location/';
  static const String CONTRACTOR_PROFILE = 'landloard/agent-details/';
  static const String SUBMIT_DISPUTE = 'homeowner/create_report';
  static const String DISPUTE_REQUEST_LIST = 'homeowner/report_list';
  static const String UPDATE_REPORT_STATUS = 'homeowner/update_report_status';

  static String addTestData() {
    return "?test=1";
  }
}
