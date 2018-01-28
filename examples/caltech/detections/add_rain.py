from PIL import Image
from numpy import *
import os

file_dir = "/home/yunpeng/Documents/mscnn_mat/data/caltech/data/test/org_images/"
dest_dir = "/home/yunpeng/Documents/mscnn_mat/data/caltech/data/test/images/"
img_list = os.listdir(file_dir)

im1 = Image.open('/home/yunpeng/Documents/Streaks/enhance_masksv2/2-8.png')
resized = False
for img in img_list:
	im2 = Image.open(file_dir + img)
	if not resized:
		im1 = im1.resize(im2.size, resample=Image.BICUBIC)
		resized = True
	im1arr = asarray(im1)
	im2arr = asarray(im2)

	max_arr = maximum(im1arr, im2arr)

	resultImage = Image.fromarray(max_arr)
	resultImage.save(dest_dir + img)
