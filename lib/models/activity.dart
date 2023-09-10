class Activity {
  final String? activityID;
  final String? title;
  final String? image;
  final String? description;
  final String? model;
  final String? labels;
  final List<int>? rgbColor;
  final String? cardImage;

  Activity(
      {this.activityID,
      this.title,
      this.image,
      this.description,
      this.model,
      this.rgbColor,
      this.cardImage,
      this.labels});
}

String lipsumDesc =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s";

final List<Activity> activities = [
  Activity(
    activityID: "mosaic",
    title: "Mosaic",
    image: "mosaic",
    model: "assets/models/yolov2_tiny.tflite",
    labels: "assets/models/yolov2_tiny.txt",
    rgbColor: [241, 89, 42],
    cardImage: "mosaic_art.jpg",
    description:
        "Monitor mosaic coloring progress, segment completion percentage, and color tracking.",
  ),
  Activity(
    activityID: "stroke",
    title: "Stroke",
    image: "polyline",
    model: "",
    labels: "",
    cardImage: "stroke.jpg",
    rgbColor: [146, 39, 143],
    description: lipsumDesc,
  ),
  Activity(
    activityID: "difference",
    title: "Spot Difference",
    image: "difference",
    model: "",
    labels: "",
    cardImage: "difference.jpg",
    rgbColor: [0, 167, 157],
    description: lipsumDesc,
  ),
  Activity(
    activityID: "paint",
    title: "Colour Images",
    image: "paint",
    model: "",
    labels: "",
    cardImage: "color.png",
    rgbColor: [0, 166, 81],
    description: lipsumDesc,
  ),
  Activity(
    activityID: "pick",
    title: "Pick Object",
    image: "pick",
    model: "",
    labels: "",
    cardImage: "pick.jpg",
    rgbColor: [218, 28, 92],
    description: lipsumDesc,
  ),
  Activity(
    activityID: "match",
    title: "Match",
    image: "match",
    model: "",
    labels: "",
    cardImage: "match.jpg",
    rgbColor: [190, 30, 45],
    description:
        "Match objects names with corresponding objects images on the right in real-time.",
  ),
  Activity(
    activityID: "find",
    title: "Find",
    image: "find",
    model: "",
    labels: "",
    cardImage: "find.jpg",
    rgbColor: [247, 148, 29],
    description: "Find a specific object within a crowded scene in real time!",
  ),
  Activity(
    activityID: "characters",
    title: "Characters",
    image: "characters",
    model: "assets/models/text_recognition.tflite",
    labels: "",
    cardImage: "characters.png",
    rgbColor: [96, 57, 19],
    description: "Identify numbers and handwritten characters in real time!",
  ),
];
