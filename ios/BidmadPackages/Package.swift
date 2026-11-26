// swift-tools-version:5.9
import PackageDescription

let bidmad: [(repository: String, version: Version, products: [String])] = [
    ("BidmadGoogleAdMobAdapter-SPM",      "7.2.0+13.11.0",         ["BidmadGoogleAdMobAdapter"]),
    ("BidmadGoogleAdManagerAdapter-SPM",  "7.2.0+13.11.0",         ["BidmadGoogleAdManagerAdapter"]),
    ("BidmadAppLovinAdapter-SPM",         "7.2.0+13.7.0",          ["BidmadAppLovinAdapter"]),
    ("BidmadUnityAdsAdapter-SPM",         "7.2.0+4.21.0",          ["BidmadUnityAdsAdapter"]),
    ("BidmadPangleAdapter-SPM",           "7.2.0+8.4.0-release.7", ["BidmadPangleAdapter"]),
    ("BidmadFyberAdapter-SPM",            "7.2.0+8.5.1",           ["BidmadFyberAdapter"]),
    ("BidmadVungleAdapter-SPM",           "7.2.0+7.7.8",           ["BidmadVungleAdapter"]),
    ("BidmadTeadsAdapter-SPM",            "7.2.0+6.1.0",           ["BidmadTeadsAdapter"]),
    ("BidmadAdFitAdapter-SPM",            "7.2.0+3.18.3",          ["BidmadAdFitAdapter"]),
    ("BidmadAdpieAdapter-SPM",            "7.2.0+1.6.16",          ["BidmadAdpieAdapter"]),
    ("BidmadTaboolaAdapter-SPM",          "7.2.0+3.9.12",          ["BidmadTaboolaAdapter"]),
    ("BidmadPremiumAdsGoogleAdapter-SPM", "7.2.0+1.0.6",           ["BidmadPremiumAdsGoogleAdapter"]),
    ("BidmadMobwithAdapter-SPM",          "7.2.0",                 ["BidmadMobwithAdapter"]),
    ("BidmadORTBAdapter-SPM",             "7.2.0",                 ["BidmadORTBAdapter"]),
    ("BidmadPartnersAdMobBidding-SPM",    "7.2.0",                 ["BidmadPartnersAdMobBidding", "BidmadPartnersAdMobBiddingDynamicSDKs"]),
]

let package = Package(
    name: "BidmadPackages",
    platforms: [.iOS(.v15)],
    products: [.library(name: "BidmadPackages", targets: ["BidmadPackages"])],
    dependencies: bidmad.map { .package(url: "https://github.com/bidmad/\($0.repository).git", exact: $0.version) },
    targets: [
        .target(
            name: "BidmadPackages",
            dependencies: bidmad.flatMap { entry in entry.products.map { .product(name: $0, package: entry.repository) } }
        )
    ]
)
