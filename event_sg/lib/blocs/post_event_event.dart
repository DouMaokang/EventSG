abstract class PostEventEvent {}

class PostEventNext extends PostEventEvent {
  final String organizer;
  final String organization;
  final String description;
  final String contact;
  final String email;
  PostEventNext(this.organizer,this.organization,this.description,this.contact,this.email);
}