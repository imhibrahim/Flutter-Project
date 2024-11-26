class UnboardingContent{
  String image;
  String title;
  String descritpion;
  UnboardingContent({required this.descritpion,required this.image,required this.title});

}

List<UnboardingContent> contents = [
  UnboardingContent(descritpion: 'Pick Your food from our menu\n        More than 35 times',
   image: "assest/images/screen1.png",
    title: "Select from Our\n      Best Menu"),
    UnboardingContent(descritpion: "you can pay cash on delivery and\n     card payment is available",
     image: "assest/images/screen2.png", title: "Easy and Online Payment"),
      UnboardingContent(descritpion: "Dilver Your food at your \n       Doorstep",
     image: "assest/images/screen3.png", title: "Quick Delivery at Your Doorstep"),

];