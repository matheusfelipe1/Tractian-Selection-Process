import 'package:traction_selection_process/app/domain/locations/entities/location_entity.dart';
import 'package:traction_selection_process/app/domain/assets_tree/entities/assets_tree_entity.dart';

abstract class AssetsState {
  final bool energy;
  final bool critical;
  final bool isProcessing;
  final AssetsTreeEntity assetsTree;

  AssetsState({
    this.energy = false,
    this.critical = false,
    this.isProcessing = false,
    this.assetsTree = const AssetsTreeEntity(branches: []),
  });

  AssetsState copyWith({
    bool? energy,
    bool? critical,
    bool? isProcessing,
    AssetsTreeEntity? assetsTree,
  });
}

class AssetsInitial extends AssetsState {
  AssetsInitial({
    super.energy,
    super.critical,
  });

  @override
  AssetsInitial copyWith({
    bool? energy,
    bool? critical,
    bool? isProcessing,
    AssetsTreeEntity? assetsTree,
  }) {
    return AssetsInitial(
      energy: energy ?? this.energy,
      critical: critical ?? this.critical,
    );
  }
}

class AssetsError extends AssetsState {
  AssetsError({
    super.energy,
    super.critical,
  });

  @override
  AssetsError copyWith({
    bool? energy,
    bool? critical,
    bool? isProcessing,
    AssetsTreeEntity? assetsTree,
  }) {
    return AssetsError(
      energy: energy ?? this.energy,
      critical: critical ?? this.critical,
    );
  }
}

class AssetsLoaded extends AssetsState {
  AssetsLoaded({
    super.energy,
    super.critical,
    required super.assetsTree,
    super.isProcessing = false,
  });

  @override
  AssetsLoaded copyWith({
    bool? energy,
    bool? critical,
    bool? isProcessing,
    AssetsTreeEntity? assetsTree,
  }) {
    return AssetsLoaded(
      energy: energy ?? this.energy,
      critical: critical ?? this.critical,
      assetsTree: assetsTree ?? this.assetsTree,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }
}

class AssetsLoading extends AssetsState {
  AssetsLoading({
    super.energy,
    super.critical,
    super.isProcessing,
  }) : super(
          assetsTree: AssetsTreeEntity(
            branches: List<TreeBranches>.generate(
              10,
              (index) => LocationEntity(
                id: "",
                children: [],
                isOpen: false,
                name: "Tractian Location ${index + 1}",
              ),
            ),
          ),
        );

  @override
  AssetsLoading copyWith({
    bool? energy,
    bool? critical,
    bool? isProcessing,
    AssetsTreeEntity? assetsTree,
  }) {
    return AssetsLoading(
      energy: energy ?? this.energy,
      critical: critical ?? this.critical,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }
}
