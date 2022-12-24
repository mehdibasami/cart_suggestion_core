import 'package:cart_suggestion_core/core/values/Routing/RoutingBase.dart';

class RoutingUserGroup extends RoutingBase {
  static const BaseName = 'UserGroup';
  static const GET_GetUserGroups = '${RoutingBase.ApiUrl}/$BaseName';
  static const PUT_DisableUserGroups =
      '${RoutingBase.ApiUrl}/$BaseName/DisableUserGroup';
  static const PUT_RemoveUserGroupItem =
      '${RoutingBase.ApiUrl}/$BaseName/RemoveUserGroupItem';
  static const POST_AddUserGroupItem =
      '${RoutingBase.ApiUrl}/$BaseName/AddUserGroupItem';
}
