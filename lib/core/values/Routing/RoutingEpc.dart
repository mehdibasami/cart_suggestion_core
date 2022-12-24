import 'RoutingBase.dart';

class RoutingEpc {
  static const Get_GetModelSeries =
      '${RoutingBase.EpcApiUrl}ModelSeries/GetModelSeries';
  static const Get_GetGroups = '${RoutingBase.EpcApiUrl}Group/GetGroups';
  static const Get_GetSubGroups = '${RoutingBase.EpcApiUrl}Group/GetSubGroups';
  static const Get_GetPartGroups = '${RoutingBase.EpcApiUrl}Part/GetPartGroups';
  static const Get_GetIranCars =
      '${RoutingBase.EpcApiUrl}ModelSeries/GetIranCars';
}
