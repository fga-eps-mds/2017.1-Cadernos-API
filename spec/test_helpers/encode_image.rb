require 'base64'

def test_image
  file = Rails.root.join('public', 'images', 'original', 'missing.jpg')

  File.open(file)
end

def encode_image_to_base64 image, type
  encoded = Base64.encode64 image.read

  ("data:image/%s;base64,%s" % [type, encoded])
end
