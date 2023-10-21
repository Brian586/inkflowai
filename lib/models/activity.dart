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

final List<Activity> activities = [
  Activity(
    activityID: "mosaic",
    title: "Mosaic",
    image: "mosaic",
    model: "assets/models/best.tflite",
    labels: "",
    rgbColor: [241, 89, 42],
    cardImage: "mosaic_art.jpg",
    description:
        "Monitor mosaic coloring progress, segment completion percentage, and color tracking.",
  ),
  Activity(
    activityID: "stroke",
    title: "Stroke",
    image: "polyline",
    model: "https://khaledkhlyan.github.io/ShapesDetection/",
    // "https://demo.roboflow.com/shapes-recognition/4?publishable_key=rf_TV1AXOV0jBYt02DPg0stwRyqeY13",
    labels: "assets/models/labels.txt",
    cardImage: "stroke.jpg",
    rgbColor: [146, 39, 143],
    description:
        "Draw freehand strokes following a precise path and without going outside the limits.",
  ),
  Activity(
    activityID: "difference",
    title: "Spot Difference",
    image: "difference",
    model: "",
    labels: "",
    cardImage: "difference.jpg",
    rgbColor: [0, 167, 157],
    description: "Spot the difference between two identical photos.",
  ),
  Activity(
    activityID: "paint",
    title: "Colour Images",
    image: "paint",
    model: "https://khaledkhlyan.github.io/ShapesDetection/",
    // "https://demo.roboflow.com/shapes-recognition/4?publishable_key=rf_TV1AXOV0jBYt02DPg0stwRyqeY13",
    labels: "",
    cardImage: "color.png",
    rgbColor: [0, 166, 81],
    description:
        "Colour images as the app detects the type of colour used in real time and percentage completion.",
  ),
  Activity(
    activityID: "pick",
    title: "Pick Object",
    image: "pick",
    model: "my model",
    labels: "",
    cardImage: "pick.jpg",
    rgbColor: [218, 28, 92],
    description:
        "Pick an object among many and let the app recognize the chosen object in real time.",
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
    model: "",
    labels: "",
    cardImage: "characters.png",
    rgbColor: [96, 57, 19],
    description: "Identify numbers and handwritten characters in real time!",
  ),
];
