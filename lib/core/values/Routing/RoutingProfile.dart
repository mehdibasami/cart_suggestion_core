import 'RoutingBase.dart';

class RoutingProfile extends RoutingBase {
  static const BaseName = "Profile";
  
  static const GET_GetAddresses = "${RoutingBase.ApiUrlV2}/$BaseName/GetAddresses";
  // static const GET_GetInfoProfile = "${RoutingBase.ApiUrl}/$BaseName/GetInfoProfile";
  // static const GET_GetMainPageData = "${RoutingBase.ApiUrl}/$BaseName/GetMainPageData";
  // static const GET_GetProductMostBuy = "${RoutingBase.ApiUrl}/$BaseName/GetProductMostBuy";
  // static const GET_GetFavoriteProducts = "${RoutingBase.ApiUrl}/$BaseName/GetFavoriteProducts";
  static const GET_GetPersonalInformation = "${RoutingBase.ApiUrl}/$BaseName/GetPersonalInformation";
  
  static const POST_SetAddresses = "${RoutingBase.ApiUrl}/$BaseName/SetAddresses";
  static const POST_EditPersonalInformation = "${RoutingBase.ApiUrl}/$BaseName/EditPersonalInformation";
  static const POST_SetBankCardNumber = "${RoutingBase.ApiUrl}/$BaseName/SetBankCardNumber";
  static const POST_SetSecondPassword = "${RoutingBase.ApiUrl}/$BaseName/SetSecondPassword";
  static const POST_ChangeSecondPassword = "${RoutingBase.ApiUrl}/$BaseName/ChangeSecondPassword";
  static const POST_CheckSecondPassword = "${RoutingBase.ApiUrl}/$BaseName/CheckSecondPassword";
  static const POST_UploadScreenShot = "${RoutingBase.ApiUrl}/$BaseName/UploadScreenshot";
  static const POST_UploadAvatar = "${RoutingBase.ApiUrl}/$BaseName/EditPersonalAvatar";


  static const DELETE_Delete = "${RoutingBase.ApiUrl}/$BaseName/Delete";
}
