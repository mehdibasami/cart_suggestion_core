import 'RoutingBase.dart';

class RoutingBalance extends RoutingBase {
  static const BaseName = "Balance";

  // static const GET_Home = "${RoutingBase.ApiUrl}/$BaseName/Home";
  static const POST_BalanceDataSearch =
      "${RoutingBase.ApiUrlV2}/$BaseName/GetBalanceDataSearch";
  // static const POST_GetBalanceQuickSearchV2 =
  //     "${RoutingBase.ApiUrlV2}/$BaseName/GetBalanceQuickSearchv2";
  static const POST_SearchParts = "${RoutingBase.ApiUrl}/Product/SearchParts";
  // static const GET_QuickSearch = "${RoutingBase.ApiUrl}/$BaseName/QuickSearch";
  // static const GET_ShowCategory =
  //     "${RoutingBase.ApiUrl}/$BaseName/ShowCategory";
  // static const GET_ShowAllParents =
  //     "${RoutingBase.ApiUrl}/$BaseName/ShowAllParents";
  // static const POST_SearchByPartNumbers =
  //     "${RoutingBase.ApiUrl}/$BaseName/SearchByPartNumbers";
  static const POST_SearchByEPCPartNumbers =
      "${RoutingBase.ApiUrlV2}/$BaseName/SearchByEPCPartNumbers";
  static const Post_GetBalanceData =
      "${RoutingBase.ApiUrlV2}/$BaseName/GetBalanceDataV2";
  static const GET_GetBalanceFilterBox =
      "${RoutingBase.ApiUrlV2}/$BaseName/GetBalanceFilterBox";
  static const Post_GetSelectedBalanceData =
      "${RoutingBase.ApiUrlV2}/$BaseName/GetSelectedBalanceDataByOrder";
  static const Post_GetPartsWithDetails =
      "${RoutingBase.ApiUrlV2}/$BaseName/GetPartsWithDetails";
  // static const Post_GetDataCategory =
  //     "${RoutingBase.ApiUrlV2}/$BaseName/GetDataCategory";
  static const GET_ShowAllParentsV2 =
      "${RoutingBase.ApiUrlV2}/$BaseName/ShowAllParentsV2";
  // static const GET_GetKeywords =
  //     "${RoutingBase.ApiUrlV2}/$BaseName/GetKeywords";

  static const GET_ShowSubCategory =
      "${RoutingBase.ApiUrlV2}/$BaseName/ShowSubCategoryV2";
}
