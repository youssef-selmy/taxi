import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/features/home/presentation/components/footer.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../components/blocks_card.dart';
import '../components/blocks_header.dart';
import '../entities/blocks_component.dart';
part 'blocks_screen.desktop.dart';
part 'blocks_screen.mobile.dart';

@RoutePage()
class BlocksScreen extends StatefulWidget {
  const BlocksScreen({super.key});

  @override
  State<BlocksScreen> createState() => _BlocksScreenState();
}

class _BlocksScreenState extends State<BlocksScreen> {
  String _searchQuery = '';

  List<BlocksComponent> get _filteredBlocks =>
      _searchQuery.isEmpty
          ? blocks
          : blocks
              .where(
                (block) => block.componentName.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ),
              )
              .toList();

  void _onSearchChanged(String query) {
    setState(() => _searchQuery = query);
  }

  @override
  Widget build(BuildContext context) {
    return context.responsive(
      BlocksScreenMobile(
        filteredBlocks: _filteredBlocks,
        onSearchChanged: _onSearchChanged,
      ),
      xl: BlocksScreenDesktop(
        filteredBlocks: _filteredBlocks,
        onSearchChanged: _onSearchChanged,
      ),
    );
  }
}
