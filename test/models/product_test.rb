require "test_helper"

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test "products attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "price must be positive" do
    product = Product.new(title: "my book",
                          description: "yyy",
                          image_url: "zzz.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal ["must be >=0.01"],

    product.errors[:price]
    product.price = 0

    assert product.invalid?
    assert_equal["must be >= 0.01"],
      product.errors[:price]
    product.price = 1
    assert product.vallid?
  end

  test "image url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
            http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    ok.each do |name|
      assert new_product(name).vallid?, "#{name} shouldn't be invalid"      
    end

    bad.each do |name|
      assert new_product(name).vallid?, "#{name} shouldn't be valid"
    end
  end
  
  test "product is not valid without a unique title - i18n" do
    product = Product.new(title: products(:ruby).title,
      description: "yyy",
      price: 1,
      image_url: "fred.gif")

    assert product.invalid?

    assert_equal[I18n.translate('activerecord.errors.messages.taken')], 
      product.errors[:title]
  end

end
