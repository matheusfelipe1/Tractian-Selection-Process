import 'package:design_system/design_system.dart';

abstract class AssetsState {}

class AssetsInitial extends AssetsState {}

class AssetsError extends AssetsState {}
class AssetsLoaded extends AssetsState {
  final List<TractianAssetsTree> assets;
  AssetsLoaded({required this.assets});
}


class AssetsLoading extends AssetsState {
  final List<TractianAssetsTree> assets = [
    TractianAssetsTree(
      name: "PRODUCTION AREA - ROW MATERIAL",
      type: TractianAssetType.location,
      children: [
        TractianAssetsTree(
          name: "CHARCOAL STORAGE SECTOR",
          type: TractianAssetType.subLocation,
          children: [
            TractianAssetsTree(
              name: "CONVENYOR BELT ASSEMBLY",
              type: TractianAssetType.asset,
              children: [
                TractianAssetsTree(
                  name: "MOTOR TC01",
                  type: TractianAssetType.subasset,
                  children: [
                    TractianAssetsTree(
                      name: "Tractian",
                      type: TractianAssetType.component,
                      children: [],
                    ),
                    TractianAssetsTree(
                      name: "Tractian",
                      type: TractianAssetType.component,
                      children: [],
                    ),
                    TractianAssetsTree(
                      name: "Tractian",
                      type: TractianAssetType.component,
                      children: [],
                    ),
                    TractianAssetsTree(
                      name: "Tractian",
                      type: TractianAssetType.component,
                      children: [],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        TractianAssetsTree(
          name: "CHARCOAL STORAGE SECTOR",
          type: TractianAssetType.subLocation,
          children: [
            TractianAssetsTree(
              name: "CONVENYOR BELT ASSEMBLY",
              type: TractianAssetType.asset,
              children: [
                TractianAssetsTree(
                  name: "MOTOR TC01",
                  type: TractianAssetType.subasset,
                  children: [
                    TractianAssetsTree(
                      name: "Tractian",
                      type: TractianAssetType.component,
                      children: [],
                    ),
                    TractianAssetsTree(
                      name: "Tractian",
                      type: TractianAssetType.component,
                      children: [],
                    ),
                    TractianAssetsTree(
                      name: "Tractian",
                      type: TractianAssetType.component,
                      children: [],
                    ),
                    TractianAssetsTree(
                      name: "Tractian",
                      type: TractianAssetType.component,
                      children: [],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    TractianAssetsTree(
      name: "PRODUCTION AREA - ROW MATERIAL",
      type: TractianAssetType.location,
      children: [
        TractianAssetsTree(
          name: "CHARCOAL STORAGE SECTOR",
          type: TractianAssetType.subLocation,
          children: [
            TractianAssetsTree(
              name: "CONVENYOR BELT ASSEMBLY",
              type: TractianAssetType.asset,
              children: [
                TractianAssetsTree(
                  name: "MOTOR TC01",
                  type: TractianAssetType.subasset,
                  children: [
                    TractianAssetsTree(
                      name: "Tractian",
                      type: TractianAssetType.component,
                      children: [],
                    ),
                    TractianAssetsTree(
                      name: "Tractian",
                      type: TractianAssetType.component,
                      children: [],
                    ),
                    TractianAssetsTree(
                      name: "Tractian",
                      type: TractianAssetType.component,
                      children: [],
                    ),
                    TractianAssetsTree(
                      name: "Tractian",
                      type: TractianAssetType.component,
                      children: [],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        TractianAssetsTree(
          name: "CHARCOAL STORAGE SECTOR",
          type: TractianAssetType.subLocation,
          children: [
            TractianAssetsTree(
              name: "CONVENYOR BELT ASSEMBLY",
              type: TractianAssetType.asset,
              children: [
                TractianAssetsTree(
                  name: "MOTOR TC01",
                  type: TractianAssetType.subasset,
                  children: [
                    TractianAssetsTree(
                      name: "Tractian",
                      type: TractianAssetType.component,
                      children: [],
                    ),
                    TractianAssetsTree(
                      name: "Tractian",
                      type: TractianAssetType.component,
                      children: [],
                    ),
                    TractianAssetsTree(
                      name: "Tractian",
                      type: TractianAssetType.component,
                      children: [],
                    ),
                    TractianAssetsTree(
                      name: "Tractian",
                      type: TractianAssetType.component,
                      children: [],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ];
}
