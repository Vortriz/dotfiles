import numpy as np
from PIL import Image, ImageChops

save_path = "/tmp/img.png"

# Open the image and convert to RGBA
im = Image.open(save_path).convert("RGBA")

# Invert colors while preserving transparency
white_background = Image.new("RGBA", im.size, (255, 255, 255))
inverted = ImageChops.invert(
    Image.alpha_composite(white_background, im).convert("RGB")
).convert("RGBA")

# Convert black pixels to transparent
inverted_data = np.array(inverted)
inverted_data[(inverted_data == (0, 0, 0, 255)).all(axis=-1)] = (0, 0, 0, 0)

processed = Image.fromarray(inverted_data, mode="RGBA")
processed.save(save_path)
