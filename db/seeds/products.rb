[{
  name: "Earthen Bottle",
  price: 48.0,
  image: "earthen-bottle.jpg"
}, {
  name: "Nomad Tumbler",
  price: 35.0,
  image: "nomad-tumbler.jpg"
}, {
  name: "Focus Paper Refill",
  price: 89.0,
  image: "focus-paper-refill.jpg"
}, {
  name: "Machined Mechanical Pencil",
  price: 35.0,
  image: "machined-mechanical-pencil.jpg"
}].each do |product_attributes|
  Product.new(
    name: product_attributes[:name],
    price: product_attributes[:price]
  ).tap do |product|
    product.image.attach(
      io: File.open("db/seeds/products/#{product_attributes[:image]}"),
      filename: product_attributes[:image],
      content_type: "image/jpeg"
    )

    product.save!
  end
end
