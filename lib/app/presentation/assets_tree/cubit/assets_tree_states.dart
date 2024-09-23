import 'package:design_system/design_system.dart';
import 'package:traction_selection_proccess/app/domain/assets_tree/entities/tree_assets.dart';

abstract class AssetsTreeState {
  final bool energy;
  final bool critical;
  final AssetsTree assetsTree;

  AssetsTreeState({
    this.energy = false,
    this.critical = false,
    this.assetsTree = const AssetsTree(branches: []),
  });

  AssetsTreeState copyWith({
    bool? energy,
    bool? critical,
    AssetsTree? assetsTree,
  });
}

class AssetsTreeInitial extends AssetsTreeState {
  AssetsTreeInitial({
    super.energy,
    super.critical,
  });

  @override
  AssetsTreeInitial copyWith({
    bool? energy,
    bool? critical,
    AssetsTree? assetsTree,
  }) {
    return AssetsTreeInitial(
      energy: energy ?? this.energy,
      critical: critical ?? this.critical,
    );
  }
}

class AssetsTreeError extends AssetsTreeState {
  AssetsTreeError({
    super.energy,
    super.critical,
  });

  @override
  AssetsTreeError copyWith({
    bool? energy,
    bool? critical,
    AssetsTree? assetsTree,
  }) {
    return AssetsTreeError(
      energy: energy ?? this.energy,
      critical: critical ?? this.critical,
    );
  }
}

class AssetsTreeLoaded extends AssetsTreeState {
  AssetsTreeLoaded({
    super.energy,
    super.critical,
    required super.assetsTree,
  });

  @override
  AssetsTreeLoaded copyWith({
    bool? energy,
    bool? critical,
    AssetsTree? assetsTree,
  }) {
    return AssetsTreeLoaded(
      energy: energy ?? this.energy,
      critical: critical ?? this.critical,
      assetsTree: assetsTree ?? this.assetsTree,
    );
  }
}

class AssetsTreeLoading extends AssetsTreeState {
  final List<TractianAssetsTree> assets = List.generate(
    3,
    (index) => TractianAssetsTree(
      children: [],
      type: TractianAssetType.location,
      name: "Tractian Tecnologia e Inovação",
    ),
  );

  AssetsTreeLoading({
    super.energy,
    super.critical,
  });

  @override
  AssetsTreeLoading copyWith({
    bool? energy,
    bool? critical,
    AssetsTree? assetsTree,
  }) {
    return AssetsTreeLoading(
      energy: energy ?? this.energy,
      critical: critical ?? this.critical,
    );
  }
}
