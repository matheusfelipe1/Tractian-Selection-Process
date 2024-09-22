import 'package:design_system/design_system.dart';

class TractianAssetsTreeMock {
  static TractianAssetsTreeDSEntity get() => TractianAssetsTreeDSEntity(
        name: "PRODUCTION AREA - ROW MATERIAL",
        type: TractianAssetType.location,
        children: [
          TractianAssetsTreeDSEntity(
            name: "CHARCOAL STORAGE SECTOR",
            type: TractianAssetType.subLocation,
            children: [
              TractianAssetsTreeDSEntity(
                name: "CONVENYOR BELT ASSEMBLY",
                type: TractianAssetType.asset,
                children: [
                  TractianAssetsTreeDSEntity(
                    name: "MOTOR TC01",
                    type: TractianAssetType.subasset,
                    children: [
                      TractianAssetsTreeDSEntity(
                        name: "Tractian",
                        type: TractianAssetType.component,
                        children: [],
                      ),
                      TractianAssetsTreeDSEntity(
                        name: "Tractian",
                        type: TractianAssetType.component,
                        children: [],
                      ),
                      TractianAssetsTreeDSEntity(
                        name: "Tractian",
                        type: TractianAssetType.component,
                        children: [],
                      ),
                      TractianAssetsTreeDSEntity(
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
          TractianAssetsTreeDSEntity(
            name: "CHARCOAL STORAGE SECTOR",
            type: TractianAssetType.subLocation,
            children: [
              TractianAssetsTreeDSEntity(
                name: "CONVENYOR BELT ASSEMBLY",
                type: TractianAssetType.asset,
                children: [
                  TractianAssetsTreeDSEntity(
                    name: "MOTOR TC01",
                    type: TractianAssetType.subasset,
                    children: [
                      TractianAssetsTreeDSEntity(
                        name: "Tractian",
                        type: TractianAssetType.component,
                        children: [],
                      ),
                      TractianAssetsTreeDSEntity(
                        name: "Tractian",
                        type: TractianAssetType.component,
                        children: [],
                      ),
                      TractianAssetsTreeDSEntity(
                        name: "Tractian",
                        type: TractianAssetType.component,
                        children: [],
                      ),
                      TractianAssetsTreeDSEntity(
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
