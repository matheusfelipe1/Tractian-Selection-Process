import 'package:design_system/design_system.dart';

class TractianAssetsTreeMock {
  static TractianAssetsTree get() => TractianAssetsTree(
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
      );
}
