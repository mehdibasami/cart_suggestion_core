import 'package:cart_suggestion_core/core/values/Routing/RoutingBase.dart';

class RoutingCartSuggestion extends RoutingBase {
  static const BaseName = 'CartSuggestion';
  static const ALL_CartSuggestion = '${RoutingBase.ApiUrl}/$BaseName';
  static const PUT_DisableCartSuggestion =
      '${RoutingBase.ApiUrl}/$BaseName/DisableCartSuggestion';
  static const PUT_EnableCartSuggestion =
      '${RoutingBase.ApiUrl}/$BaseName/EnableCartSuggestion';
  static const Post_SendCartSuggestion =
      '${RoutingBase.ApiUrl}/$BaseName/SendCartSuggestionSmsToUserGroup';
  static const Post_SendCartSuggestionToUserGroupByTelegram =
      '${RoutingBase.ApiUrl}/$BaseName/SendCartSuggestionToUserGroupByTelegram';
  static const GET_UserGroupsRecivedSuggestion =
      '${RoutingBase.ApiUrl}/$BaseName/GetUserGroupsRecivedSuggestion';
  static const GET_UserGroupsNotSendedSuggestion =
      '${RoutingBase.ApiUrl}/$BaseName/GetUserGroupsUnSendedSuggestion';
  static const PUT_UpdateCartSuggestion =
      '${RoutingBase.ApiUrl}/$BaseName/UpdateCartSuggestion';
  static const GET_SuggestionSendedUserGroups =
      '${RoutingBase.ApiUrl}/$BaseName/GetSuggestionsSendedUserGroup';
  static const updateCartSuggestionBaseUrl =
      '${RoutingBase.ApiUrl}/$BaseName/UpdateCartSuggestion';
  static const getCartSuggestionImages =
      '${RoutingBase.ApiUrl}/$BaseName/GetCartSuggestionImages';
  static const uploadCartSuggestionImage =
      '${RoutingBase.ApiUrl}/$BaseName/UploadCartSuggestionImage';
  static const setImageToCartSuggestion =
      '${RoutingBase.ApiUrl}/$BaseName/SetImageToCartSuggestion';
  static const deleteCartSuggestionImage =
      '${RoutingBase.ApiUrl}/$BaseName/DeleteCartSuggestionImage';
  static const forceDeleteCartSuggestionImage =
      '${RoutingBase.ApiUrl}/$BaseName/ForceDeleteCartSuggestionImage';
  static const getCategoryUrl =
      '${RoutingBase.ApiUrl}/Category';
}

