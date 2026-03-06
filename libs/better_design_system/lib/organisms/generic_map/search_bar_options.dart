import 'package:api_response/api_response.dart';
import 'package:better_design_system/organisms/generic_map/generic_map.dart';
import 'package:generic_map/interfaces/place.dart';
export 'generic_map.dart';

class SearchBarOptions {
  final Function(Place) onPlaceSelected;
  final Future<ApiResponse<List<Place>>> Function(String query) onSearch;
  final SearchBarAlignment alignment;
  final bool isExpanded;

  const SearchBarOptions({
    required this.onPlaceSelected,
    required this.onSearch,
    this.alignment = SearchBarAlignment.topLeft,
    this.isExpanded = false,
  });
}
