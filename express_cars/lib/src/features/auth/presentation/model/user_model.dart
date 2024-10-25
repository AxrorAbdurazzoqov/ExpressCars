class UserInfoModel {
    final String name;
    final String imageUrl;
    final int followersCount;
    final int followingCount;
    final List<PublicPlaylist> publicPlaylists;

    UserInfoModel({
        required this.name,
        required this.imageUrl,
        required this.followersCount,
        required this.followingCount,
        required this.publicPlaylists,
    });

    factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
        name: json["name"],
        imageUrl: json["image_url"],
        followersCount: json["followers_count"],
        followingCount: json["following_count"],
        publicPlaylists: List<PublicPlaylist>.from(json["public_playlists"].map((x) => PublicPlaylist.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "image_url": imageUrl,
        "followers_count": followersCount,
        "following_count": followingCount,
        "public_playlists": List<dynamic>.from(publicPlaylists.map((x) => x.toJson())),
    };
}

class PublicPlaylist {
    final String uri;
    final String name;
    final String imageUrl;
    final int followersCount;

    PublicPlaylist({
        required this.uri,
        required this.name,
        required this.imageUrl,
        required this.followersCount,
    });

    factory PublicPlaylist.fromJson(Map<String, dynamic> json) => PublicPlaylist(
        uri: json["uri"],
        name: json["name"],
        imageUrl: json["image_url"],
        followersCount: json["followers_count"],
    );

    Map<String, dynamic> toJson() => {
        "uri": uri,
        "name": name,
        "image_url": imageUrl,
        "followers_count": followersCount,
    };
}
