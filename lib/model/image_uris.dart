class ImageURIS {
  final String png;
  final String borderCrop;
  final String artCrop;
  final String large;
  final String normal;
  final String small;

  const ImageURIS(
      {required this.png,
      required this.borderCrop,
      required this.artCrop,
      required this.large,
      required this.normal,
      required this.small});

  factory ImageURIS.fromJson(Map<String, dynamic> json) {
    return ImageURIS(
        png: json['png'],
        borderCrop: json['border_crop'],
        artCrop: json['art_crop'],
        large: json['large'],
        normal: json['normal'],
        small: json['small']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data['png'] = png;
    data['border_crop'] = borderCrop;
    data['art_crop'] = artCrop;
    data['large'] = large;
    data['normal'] = normal;
    data['small'] = small;

    return data;
  }
}
