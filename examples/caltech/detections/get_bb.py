import os

file_dir = "/home/yunpeng/Documents/mscnn_mat/data/caltech/data/test/images"
target = "/home/yunpeng/Documents/mscnn_mat/external/code3.2.1/data-USA/res/MS-CNN-rain"

img_list = os.listdir(file_dir)
img_list.sort()


detections = "caltech_7s_720_20k_test_ped.txt"
f = open(detections, 'r')
# for i in range(len(img_list)):
#     img = img_list[i]
prev_id = 1
data = None

# for img in img_list:
for i in range(len(img_list)):
    img = img_list[i]
    set_no = img[:5]
    v_no = img[6:10]
    i_no_str = img[13:17]
    i_no = int(i_no_str) + 1
    if not os.path.isdir(target + '/' + set_no):
        os.mkdir(target + '/' + set_no)

    filename = target + '/' + set_no + '/' + v_no + ".txt"

    if os.path.exists(filename):
        append_write = 'a'  # append if already exists
    else:
        append_write = 'w'  # make a new file if not
    outfile = open(filename, append_write)

    if data is not None:
        bb = data.split(',', 1)
        if int(bb[0]) != i+1:
            outfile.write(str(i_no) + "," + "528.87,71.574,30.06,75.568,0\n")
            continue
        outfile.write(str(i_no) + "," + bb[1])
        prev_id = int(bb[0])

    while True:
        data = f.readline()
        print data
        if not data: break
        bb = data.split(',', 1)
        if int(bb[0]) == prev_id:
            outfile.write(str(i_no) + "," + bb[1])
        else:
            break
    # print img + "   " + filename + "   " + prev_id


    outfile.close()
f.close()




