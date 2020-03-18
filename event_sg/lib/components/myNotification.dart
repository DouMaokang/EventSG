class MyNotification {
  String title;
  String content;
  String image;
  bool read;

  MyNotification(this.title, this.content, this.image, this.read) {
    this.title = title;
    this.content = content;
    this.image = image;
    this.read = read;
  }
}

// image constructor
// Widget build(BuildContext context) {
//  return Image(image: AssetImage('graphics/background.png'));
//}