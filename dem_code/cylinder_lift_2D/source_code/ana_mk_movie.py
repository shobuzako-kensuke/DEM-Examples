#=========================#
#  module                 #
#=========================#
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import matplotlib.image as mpimg

#=========================#
#  ArtistAnimation        #
#=========================#
def artist_animation(last_file, write_step, save_name, val):
    fig = plt.figure()  # make a frame
    ims = []            # list to store produced images

    for i in range(0, last_file+1, write_step):
        # read png file as ndarray
        img = mpimg.imread('../fig/{}/snapshot_{}/{}.png'.format(save_name, val, i))

        # convert the ndarray to Artist
        im = plt.imshow(img, animated=True)
        plt.axis('off')

        # append the produced Artist to the list
        ims.append([im])  # note: list in list

    # make an animation
    ani = animation.ArtistAnimation(fig, ims, interval=100, blit=False)
    plt.show()


#=========================#
#  FuncAnimation          #
#=========================#
def func_animation(last_file, write_step, save_name, val):
    fig, ax = plt.subplots()  # make a frame (fig) and a domain (ax)
    ax.axis('off')            # remove all axes

    # read png file as ndarray
    first_img = mpimg.imread('../fig/{}/snapshot_{}/{}.png'.format(save_name, val, 0))
    
    # convert the ndarray to Artist (im_display will be updated)
    im_display = ax.imshow(first_img)

    # frame list (e.g., if write_step=10, frame_list=[10, 20, 30, ..., last_file])
    frame_list = list(range(0, last_file + 1, write_step))

    # update function
    def update(frame_number):
        # read png file as ndarray
        img = mpimg.imread('../fig/{}/snapshot_{}/{}.png'.format(save_name, val, frame_number))

        # update the figure by set_data
        im_display.set_data(img)

        # return as a list
        return [im_display]

    # make an animation
    ani = animation.FuncAnimation(
        fig,
        update,             # update(each each frame_number)
        frames=frame_list,  # each frame_number in frame_list 
        interval=100,       # 100ms = 10fps
        blit=True
    )

    # save
    ani.save('../fig/{}/{}.mp4'.format(save_name, val), writer='ffmpeg', fps=10, dpi=300)
    plt.close()

# END #