import 'package:cart_suggestion_core/cart_suggestion_core.dart';
import 'package:cart_suggestion_core/core/model/Api.dart';
import 'package:cart_suggestion_core/core/model/enum.dart';
import 'package:cart_suggestion_core/core/model/query_model.dart';
import 'package:cart_suggestion_core/core/model/response_model.dart';
import 'package:cart_suggestion_core/core/values/Routing/RoutingProduct.dart';

class CartSuggestionBrandService extends Api {
  //
  //*----- get brands
  Future<ResponseModel> getBrands(
    String? filterName,
    int? page,
    int? pageSize,
  ) async {
    List<QueryModel> queries = [];
    if (filterName != null) {
      queries.add(QueryModel(name: 'filterNmae', value: filterName));
    }
    if (page != null) {
      queries.add(QueryModel(name: 'page', value: page.toString()));
    }
    if (pageSize != null) {
      queries.add(QueryModel(name: 'pageSize', value: pageSize.toString()));
    }

    ResponseModel response = await HTTPGET(
      RoutingProduct.Get_CartSuggestionBrand,
      queries,
      null,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (response.isSuccess) {
      response.data = CartSuggestionBrandPagingModel.fromJson(response.data);
    }

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }
}
