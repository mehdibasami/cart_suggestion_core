import 'RoutingBase.dart';

class RoutingUser extends RoutingBase {
  static const BaseName = "Users";

  // static const GET = "${RoutingBase.ApiUrl}/$BaseName/";
  static const GET_SendValidCodeAgain =
      "${RoutingBase.ApiUrl}/$BaseName/AgainSendValidCode";

  // static const POST = "${RoutingBase.ApiUrl}/$BaseName/";
  static const POST_Token = "${RoutingBase.ApiUrl}/$BaseName/Token";
  // static const POST_ValidPhone = "${RoutingBase.ApiUrl}/$BaseName/ValidPhone";
  // static const POST_GoogleToken = "${RoutingBase.ApiUrl}/$BaseName/GoogleToken";
  static const POST_SuspendedUser =
      "${RoutingBase.ApiUrl}/$BaseName/SuspendedUser";
  static const POST_SuspendedUserVerify =
      "${RoutingBase.ApiUrl}/$BaseName/SuspendedUserVerify";
  static const POST_CreateWithValidation =
      "${RoutingBase.ApiUrl}/$BaseName/CreateWithValidation";
  static const POST_SuspendedUserVerifyResert =
      "${RoutingBase.ApiUrl}/$BaseName/SuspendedUserVerifyResert";
  // static const POST_SuspendedUserResetPassword =
  //     "${RoutingBase.ApiUrl}/$BaseName/SuspendedUserResetPassword";
  static const POST_AgainSendValidCodeForSuspendedUser =
      "${RoutingBase.ApiUrl}/$BaseName/AgainSendValidCodeForSuspendedUser";
  // static const POST_AgainSendValidCodeForSuspendedUserResetPassword =
  //     "${RoutingBase.ApiUrl}/$BaseName/AgainSendValidCodeForSuspendedUserResetPassword";
  // static const POST_ResetPasswordByValidation =
  //     "${RoutingBase.ApiUrl}/$BaseName/ResetPasswordByValidation";
  static const Post_GoogleToken = "${RoutingBase.ApiUrl}/Users/GoogleToken";

  static const Get_CheckAppVersion =
      "${RoutingBase.ApiUrl}/AppVersion/CheckAppVersion";
  static const PUT_ResetPassword =
      "${RoutingBase.ApiUrl}/$BaseName/ResetPassword";

  static const Post_VerifyCode =
      "${RoutingBase.ApiUrl}/Users/VerifyToFactorRestPassword";

  // static const PUT = "${RoutingBase.ApiUrl}/$BaseName/";
  // static const PUT_Username = "${RoutingBase.ApiUrl}/$BaseName/";

  static const POST_TokenWithUserId =
      "${RoutingBase.ApiUrlV2}/$BaseName/TokenWithUserIdV2";

  static const DELETE_ResetPassword =
      "${RoutingBase.ApiUrl}/$BaseName/GetResetPasswordCode";
  // static const DELETE_ChangeThePassword =
  //     "${RoutingBase.ApiUrl}/$BaseName/ChangeThePassword";

  static const GET_GetUserFullName =
      "${RoutingBase.ApiUrl}/$BaseName/GetUserFullname";
}
