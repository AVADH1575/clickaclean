import 'package:flutter/material.dart';

class APPURLS_USER {

  static const String BASE_URL =
      //"http://sharpwebstudio.us/clickaclean/api/user/";
      "https://www.getpostman.com/collections/a91b4d1e0a1979725a1e";

  static const String GET_USER_COUNTRY_LIST_URL = BASE_URL + "countries";

  static const String GET_USER_DOMESTIC_SIZE_URL = BASE_URL + "houseSize";

  static const String GET_USER_DOMESTIC_ROOMS_LIST_URL = BASE_URL + "NoRooms";

  static const String GET_USER_DOMESTIC_HOUSES_URL = BASE_URL + "houses";

  static const String GET_USER_CAR_TYPE_URL = BASE_URL + "CarType";

  static const String GET_USER_CAR_VELTER_SERVICE_URL = BASE_URL + "ValeterType";

  static const String POST_USER_SINGUP_URL = BASE_URL + "UserSignupEmail";

  static const String POST_USER_PHONE_SINGUP_URL = BASE_URL + "UserSignupPhone";

  static const String POST_USER_PHONE_RESET_URL = BASE_URL + "userPasswordReset";

  static const String POST_USER_PHONE_NUMBER_CHECK_URL = BASE_URL + "userPhoneCheck";

  static const String POST_USER_LOGIN_URL = BASE_URL + "loginEmail";

  static const String POST_USER_PHONE_LOGIN_URL = BASE_URL + "loginPhone";

  static const String POST_USER_SERVICE_CHOOSE = BASE_URL + "ServiceNeed";

  static const String GET_USER_CHECK_SERVICE_NAME = BASE_URL + "ServiceName";

  static const String GET_USER_JOB_ID_BOOKING = BASE_URL + "lastJobByUserId";

  static const String GET_USER_DATE_GET = BASE_URL + "dateGet";

  static const String GET_USER_HOUR_GET = BASE_URL + "hourGet";

  static const String GET_USER_TIME_GET = BASE_URL + "timeGet";

  static const String POST_USER_BOOKING_DETAIL = BASE_URL + "userServiceDetails";

  static const String POST_USER_NOTIFICATION_DELETE_URL = BASE_URL + "notificationDelete";

  static const String POST_USER_BookingConfirm_URL = BASE_URL + "bookingConfirm";

  static const String POST_USER_ADD_CAR_POST_URL = BASE_URL + "CarValeterServices";

  static const String POST_USER_ADD_CAR_DATE_TIME_POST_URL = BASE_URL + "UserTimeDateSolt";

  static const String POST_USER_ADD_DOMESTIC_POST_URL = BASE_URL + "DomesticAllData";

  static const String GET_USER_ADDRESS_URL = BASE_URL + "addressGet";

  static const String POST_USER_ADD_ADDRESS_URL = BASE_URL + "userAddress";

  static const String POST_USER_DELETE_ADDRESS_URL = BASE_URL + "AddressDeleteByUserId";

  static const String GET_USER_PROFILE_URL = BASE_URL + "getdata";

  static const String GET_USER_PROFILE_UPDATE_URL = BASE_URL + "userDataUpdate";

  static const String POST_USER_PROFILE_PIC_UPDATE_URL = BASE_URL + "userProfileDataUpdate";

  static const String GET_USER_LOGOUT_API = BASE_URL + "userLogout";

  static const String POST_USER_CAR_VELTER_BOOKING_API = BASE_URL + "CarPriceGetByUserId";

  static const String POST_USER_DOMESTIC_BOOKING_API = BASE_URL + "DomesticPriceGetByUserId";

  static const String GET_USER_NOTIFICATION_LIST_API = BASE_URL + "notificationGet";

  static const String GET_USER_ACTIVE_BOOKING_LIST_API = BASE_URL + "bookingongoing";

  static const String GET_USER_PAST_BOOKING_LIST_API = BASE_URL + "bookincancelComplete";

  static const String GET_USER_ACTIVE_CANCEL_BOOKING = BASE_URL + "bookincancel";

  static const String POST_USER_RESCHEDULE_URL = BASE_URL + "userReschedule";

  static const String POST_USER_TRACK_BOOKING_URL = BASE_URL + "trackorderDetails";

  static const String GET_USER_ALL_PROVIDER = BASE_URL + "providerDataByUserId";

}

class STORE_PREFS {

  static const String USER_API_KEY = "USER_API_KEY";
  static const String FCM_TOKEN_GLOBAL = "FCM_TOKEN_GLOBAL";
  static const String USER_ID_GLOBAL = "USER_ID_GLOBAL";
  static const String USER_ID_PHONE_NUMBER_GLOBAL = "USER_ID_PHONE_NUMBER_GLOBAL";

  static const String USER_COUNTRY_CODE = "USER_COUNTRY_CODE";
  static const String USER_CAR_TYPE_ID = "USER_CAR_TYPE_ID";
  static const String USER_CAR_VALET_ID = "USER_CAR_VALET_ID";
  static const String USER_CAR_VALET_PRICE = "USER_CAR_VALET_PRICE";

  static const String USER_BOOKING_DATE = "USER_BOOKING_DATE";
  static const String USER_BOOKING_TIME = "USER_BOOKING_TIME";
  static const String USER_ACTIVE_BOOKING_ID = "USER_ACTIVE_BOOKING_ID";

  static const String USER_BOOKING_HOUR = "USER_BOOKING_HOUR";
  static const String USER_BOOKING_ADDRESS = "USER_BOOKING_ADDRESS";
  static const String USER_BOOKING_FLAT = "USER_BOOKING_FLAT";
  static const String USER_BOOKING_ADDRESS_NAME = "USER_BOOKING_ADDRESS_NAME";
  static const String USER_BOOKING_PHONE = "USER_BOOKING_PHONE";
  static const String USER_BOOKING_INSTRUCTION_CODE = "USER_BOOKING_INSTRUCTION_CODE";
  static const String USER_BOOKING_KEYFILE_NAME = "USER_BOOKING_KEYFILE_NAME";
  static const String USER_BOOKING_SAVED_ADDRESS_TYPE = "USER_BOOKING_SAVED_ADDRESS_TYPE";
  static const String USER_BOOKING_LAT = "USER_BOOKING_LAT";
  static const String USER_BOOKING_LOG = "USER_BOOKING_LOG";

  static const String USER_SERVICE_TYPE = "USER_SERVICE_TYPE";

  static const String USER_DOMESTIC_BUILDING_TYPES_ID = "USER_DOMESTIC_BUILDING_TYPES_ID";
  static const String USER_DOMESTIC_BUILDING_SIZE = "USER_DOMESTIC_BUILDING_SIZE";
  static const String USER_DOMESTIC_BUILDING_NO_ROOMS = "USER_DOMESTIC_BUILDING_NO_ROOMS";
  static const String USER_DOMESTIC_LOVE_PET_ID = "USER_DOMESTIC_LOVE_PET_ID";

  static const String USER_ADDRESS_TYPE_SELECTION = "USER_ADDRESS_TYPE_SELECTION";


}

class APPURLS_PROVIDER {

  static const String BASE_URL =
      "http://35.178.249.246/app/api/user/";

  static const String POST_PROVIDER_LOGIN_URL = BASE_URL + "providerloginEmail";

  static const String POST_PROVIDER_SINGUP_URL = BASE_URL + "ProviderSignupEmail";

  static const String POST_PROVIDER_PHONE_SINGUP_URL = BASE_URL + "ProviderSignupPhone";

  static const String POST_PROVIDER_PHONE_LOGIN_URL = BASE_URL + "providerloginPhone";

  static const String POST_PROVIDER_PHONE_CHECK_URL = BASE_URL + "providerPhoneCheck";

  static const String GET_PROVIDER_COUNTRY_LIST_URL = BASE_URL + "countries";

  static const String POST_PROVIDER_SERVICE_CHOOSE = BASE_URL + "serviceProviderType";

  static const String POST_PROVIDER_PHONE_RESET_URL = BASE_URL + "providerPasswordReset";

  static const String POST_PROVIDER_PERSONAL_INFORMATION_URL = BASE_URL + "ServiceProviderDataUpdate";

  static const String GET_PROVIDER_PERSONAL_INFORMATION_STATUS_CHECK = BASE_URL + "providerPersonalDetailsStatus";

  static const String GET_PROVIDER_BANK_DETAILS_STATUS_CHECK = BASE_URL + "providerPersonalBankDetailsStatus";

  static const String POST_PROVIDER_BANK_DETAIL_URL = BASE_URL + "ServiceProviderbankDetails";

  static const String GET_PROVIDER_VERIFY_DOCUMENT_STATUS_CHECK = BASE_URL + "providerVerifiedDocumentStatus";

  static const String GET_PROVIDER_PROFILE_DATA = BASE_URL + "providerData";

  static const String POST_PROVIDER_PROFILE_PHOTO_URL = BASE_URL + "ProviderProfileDataUpdate";

  static const String POST_PROVIDER_BANK_DETAILS_UPDATE = BASE_URL + "ServiceProviderbankDetailsUpdate";

  static const String GET_PROVIDER_BANK_DETAILS = BASE_URL + "ProviderbankDetails";

  static const String GET_PROVIDER_LOGOUT_API = BASE_URL + "providerLogout";

  static const String POST_PROVIDER_DOCUMENT_TYPE = BASE_URL + "documentsType";

  static const String GET_PROVIDER_DOCUMENT_LIST = BASE_URL + "getDocumentsByUserId";

  static const String GET_PROVIDER_WORK_IMAGES = BASE_URL + "getWorkImages";

  static const String POST_PROVIDER_ADD_WORK_IMAGES = BASE_URL + "AddWorkImages";

  static const String POST_PROVIDER_ADD_ServiceProviderLatLog = BASE_URL + "ServiceProviderLatLog";

  static const String POST_PROVIDER_ServiceProviderLatLogUpdate = BASE_URL + "ServiceProviderLatLogUpdate";

  static const String GET_PROVIDER_NOTIFICATION_LIST_URL = BASE_URL + "ProviderNotificationGet";

  static const String POST_PROVIDER_NOTIFICATION_DELETE_URL = BASE_URL + "ProviderNotificationDelete";

  static const String POST_PROVIDER_ACCEPT_DECLINE_URL = BASE_URL + "providerJobListUpdateStatus";

  static const String POST_PROVIDER_JOB_POST_API = BASE_URL + "providerJobWorkingStatus";

  static const String GET_NEW_LEADS_HISTORY_URL = BASE_URL + "providerJobList/";

  static const String GET_ONGOING_LEADS_HISTORY_URL = BASE_URL + "providerjobhistoryActive/";

  static const String GET_PAST_LEADS_HISTORY_URL = BASE_URL + "providerjobhistoryPast/";

  static const String GET_BOOKING_DETAIL_URL = BASE_URL + "getuserJobDetails/";

  static const String GET_PROVIDER_CHECK_JOB_ACCEPTED = BASE_URL + "checkuserJobAccepted";

  static const String GET_PROVIDER_CHECK_JOB_STATUS = BASE_URL + "checkProviderJobWorkStatus/";


}


class STORE_PREFS_PROVIDER {

  static const String PROVIDER_API_KEY = "PROVIDER_API_KEY";
  static const String PROVIDER_ID_GLOBAL = "PROVIDER_ID_GLOBAL";
  static const String PROVIDER_CHECK_PHONE_GLOBAL = "PROVIDER_CHECK_PHONE_GLOBAL";
  static const String PROVIDER_PHONE_NUMBER_GLOBAL = "PROVIDER_PHONE_NUMBER_GLOBAL";

  static const String PROVIDER_EMAIL_GLOBAL = "PROVIDER_EMAIL_GLOBAL";
  static const String PROVIDER_PROVIDER_NAME_GLOBAL = "PROVIDER_PROVIDER_NAME_GLOBAL";
  static const String PROVIDER_CHECK_ACCOUNT_SETUP_STRING = "PROVIDER_CHECK_ACCOUNT_SETUP_STRING";


  static const String PROVIDER_SERVICE_TYPE = "PROVIDER_SERVICE_TYPE";
  static const String PROVIDER_COUNTRY_CODE = "PROVIDER_COUNTRY_CODE";

  static const String PROVIDER_ONGOING_BOOKING_DETAIL = "PROVIDER_ONGOING_BOOKING_DETAIL";

  //PERSONAL INFORMATION SCREENS STRINGS
  static const String COMPLETE_PERSONAL_INFORMATION_STATUS = "COMPLETE_PERSONAL_INFORMATION_STATUS";

  //PERSONAL FIRST SCREEN STRINGS
  static const String PERSONAL_INFORMATION_First_FIRST_NAME = "PERSONAL_INFORMATION_First_FIRST_NAME";
  static const String PERSONAL_INFORMATION_First_LAST_NAME = "PERSONAL_INFORMATION_First_LAST_NAME";
  static const String PERSONAL_INFORMATION_First_MIDDLE_NAME = "PERSONAL_INFORMATION_First_MIDDLE_NAME";

  //PERSONAL SECOND SCREEN STRINGS
  static const String PERSONAL_INFORMATION_Second_PHONE = "PERSONAL_INFORMATION_Second_PHONE";

  //PERSONAL THIRD SCREEN STRINGS
  static const String PERSONAL_INFORMATION_Third_DOB = "PERSONAL_INFORMATION_Third_DOB";

  //PERSONAL FOUR SCREEN STRINGS
  static const String PERSONAL_INFORMATION_Four_HOME_COUNTRY = "PERSONAL_INFORMATION_Four_HOME_COUNTRY";

  //PERSONAL FIFTH SCREEN STRINGS
  static const String PERSONAL_INFORMATION_Fifth_ADDRESS = "PERSONAL_INFORMATION_Fifth_ADDRESS";
  static const String PERSONAL_INFORMATION_Fifth_TOWN = "PERSONAL_INFORMATION_Fifth_TOWN";
  static const String PERSONAL_INFORMATION_Fifth_STATE = "PERSONAL_INFORMATION_Fifth_STATE";
  static const String PERSONAL_INFORMATION_Fifth_PINCODE = "PERSONAL_INFORMATION_Fifth_PINCODE";
  static const String PERSONAL_INFORMATION_Fifth_COUNTRY = "PERSONAL_INFORMATION_Fifth_COUNTRY";

}
final String HOME_SCREEN="/HOME_SCREEN";
final String CAMERA_SCREEN="/CAMERA_SCREEN";
final String VIDEO_RECORDER_SCREEN="/VIDEO_RECORDER_SCREEN";

class USERS_MESSAGES {
  static const String INTERNET_ERROR = "No Internet Connection";

  static const String INTERNET_ERROR_RETRY =
      "No Internet Connection.\nPlease Retry";

}

