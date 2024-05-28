# Diploma Thesis 1

The first part of my Diploma Thesis can be found [here](https://github.com/HerQ04/Diploma-Thesis-1/blob/main/Thesis_1.pdf)




## Datasets 
In my work I used the CIFAR 10 and Flowers 102 dataset, which can be downloaded using the [Dataset.ipynb](https://github.com/HerQ04/Diploma-Thesis-1/blob/main/Dataset.ipynb)

## U-Net (backbone)
To extract the latent space representation of given images, I used parts of an unconditional denoising diffusion probability model. The model training can be found in [Train_Unet.ipynb](https://github.com/HerQ04/Diploma-Thesis-1/blob/main/Train_Unet.ipynb)


## Testing the generative capabilities of U-net
Image generation of the trained U-Net is in the [Unet_Samples.ipynb](https://github.com/HerQ04/Diploma-Thesis-1/blob/main/Unet_Samples.ipynb) notebook.
The comparison of the generated images with the test images can be found in [Test_FID.ipynb](https://github.com/HerQ04/Diploma-Thesis-1/blob/main/Test_FID.ipynb)

## U-net latent space representations.

I tested the U-net latent space representations capabilities in two ways. Here are two examples to test the latent space formed by the U-net midblock

- KNN nearest neighbor as shown in [KNN.ipynb](https://github.com/HerQ04/Diploma-Thesis-1/blob/main/KNN.ipynb)
- Linear probe as shown in [Train_Linear_Class.ipynb](https://github.com/HerQ04/Diploma-Thesis-1/blob/main/Train_Linear_Class.ipynb)

At the "Extracting the output of the mid block of the Unet model (backbone)" part you can modify the "forward" function to apply the classification to different blocks of the model