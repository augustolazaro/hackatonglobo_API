user = User.create(name: "José da Silva", email: "jose@globo.com", rating: 5.0)
News.create(
  content: "Polícia europeia diz que é preciso uma investigação internacional.",
  title: "Vírus",
  image: "",
  latitude: "-14.125",
  longitude: "-52.125",
  category: "Informática",
  tags: "{'informática', 'virus', 'mundo'}",
  rating: 3.0,
  denied: false,
  user: user
)
