from PIL import Image, ImageDraw
import sys
import pandas as pd


def draw_rectangle(draw, coordinates, color, width=1):
    for i in range(width):
        rect_start = (coordinates[0][0] - i, coordinates[0][1] - i)
        rect_end = (coordinates[1][0] + i, coordinates[1][1] + i)
        draw.rectangle((rect_start, rect_end), outline = color)


if __name__ == '__main__':
    gt_filepath = '/home/yunpeng/Documents/mscnn_mat/data/kitti/training/label_2/'
    res_filepath = '/home/yunpeng/Documents/mscnn_mat/examples/kitti_result/val/vgg_7s_576_2x_25k_ALL_RAIN_val/data/'
    im_filepath = '/home/yunpeng/Documents/mscnn_mat/data/kitti/training/image_2_all_rain/'
    filenumber = sys.argv[1].strip().zfill(6)


    # get groundtruth coordinates
    df = pd.read_csv(gt_filepath + filenumber + '.txt', delimiter=' ', header=None)
    df = df[(df.iloc[:, 0] == 'Pedestrian') | (df.iloc[:,0] == 'Person_sitting')]
    gt_coord = df.iloc[:, 4:8].as_matrix()

    # get groundtruth dontcares
    df = pd.read_csv(gt_filepath + filenumber + '.txt', delimiter=' ', header=None)
    df = df[df.iloc[:, 0] == 'DontCare']
    dc_coord = df.iloc[:, 4:8].as_matrix()

    # get result coordinates
    df = pd.read_csv(res_filepath + filenumber + '.txt', delimiter=' ', header=None)
    df = df[df.iloc[:, 0] == 'Pedestrian']

    df = df[df.iloc[:, 15] >= 100]
    res_coord = df.iloc[:, 4:8].as_matrix()

    im = Image.open(im_filepath + filenumber + '.png')
    draw = ImageDraw.Draw(im)

    # draw gt
    for i in range(len(gt_coord)):
        c = gt_coord[i]
        xy = ((c[0], c[1]), (c[2], c[3]))
        draw_rectangle(draw=draw, coordinates=xy, color=(0,255,0), width=3)

    # draw dontcares
    for i in range(len(dc_coord)):
        c = dc_coord[i]
        xy = ((c[0], c[1]), (c[2], c[3]))
        draw_rectangle(draw=draw, coordinates=xy, color=(255, 255, 0), width=3)

    # draw result
    for i in range(len(res_coord)):
        c = res_coord[i]
        xy = ((c[0], c[1]), (c[2], c[3]))
        draw_rectangle(draw=draw, coordinates=xy, color=(255,0,0), width=3)

    im.show()
