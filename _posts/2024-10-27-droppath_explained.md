---
title: 'DropPath'
date: 2024-10-27
permalink: /posts/2024/10/droppath_explained/
---

  While working on my latest project, I had to dive deep into the huggingface's `transformers` codebase. In the process, I ventured into Swin Transformer territory—an innovative vision transformer designed for hierarchical feature representation. It was here that I noticed something that piqued my curiosity. Below is the code block that initially caught my attention:

  ```python

class SwinStage(nn.Module):
    def __init__(self, config, dim, input_resolution, depth, num_heads, drop_path, downsample):
        super().__init__()
        self.config = config
        self.dim = dim
        self.blocks = nn.ModuleList(
            [
                SwinLayer(
                    config=config,
                    dim=dim,
                    input_resolution=input_resolution,
                    num_heads=num_heads,
                    shift_size=0 if (i % 2 == 0) else config.window_size // 2,
                )
                for i in range(depth)
            ]
        )

        # patch merging layer
        if downsample is not None:
            self.downsample = downsample(input_resolution, dim=dim, norm_layer=nn.LayerNorm)
        else:
            self.downsample = None

        self.pointing = False


  ```

While digging deep into the Swin Transformer code in the `transformers` repository, I stumbled upon an intriguing discovery—thanks to a handy tool in VS Code. The tool flagged an unused `drop_path` argument in the constructor. This was unusual enough to prompt further investigation.

I opened up a [pull request](https://github.com/huggingface/transformers/pull/34291/) in transformers repository mentioning the same. 

At that moment, I realized I didn’t have a solid grasp of what Drop Path actually does. I was familiar with dropout, but Drop Path? Not quite. And so began my deep dive into Drop Path, resulting in this blog post.

# Let's First understand DropOut

Dropout is a regularization technique that was introduced by Geoffrey Hinton et al. in [Improving neural networks by preventing co-adaptation of feature detectors](https://arxiv.org/abs/1207.0580) The basic idea is to randomly change some activations to zero at training time. I would like to quote the abstract of the paper here.

> When a large feedforward neural network is trained on a small training set,
it typically performs poorly on held-out test data. This “overfitting” is greatly
reduced by randomly omitting half of the feature detectors on each training
case. This prevents complex co-adaptations in which a feature detector is only
helpful in the context of several other specific feature detectors. Instead, each
neuron learns to detect a feature that is generally helpful for producing the
correct answer given the combinatorially large variety of internal contexts in
which it must operate. Random “dropout” gives big improvements on many
benchmark tasks and sets new records for speech and object recognition.

In other words randomly dropping out activations help models to reduce the overfitting. That makes dropout a wonderful regularisation technique. 

During training,dropout layer randomly zeroes (drops) some of the elements of the input tensor with probability `p`. All the forward and backwards connections with a dropped element nodes are temporarily removed, thus creating a new network architecture out of the parent network. The zeroed element nodes are chosen independently for each forward call and are sampled from a Bernoulli distribution.

During evaluation, this layer behaves like an Identity layer.

Let's see this visually how does dropout work during training time.

![image](https://github.com/user-attachments/assets/8b029f3f-6f4c-4443-ad88-735ddd895417)


As we can see, dropout works at individual neuron level, whether a neuron will be dropped or not is totally independent of another neuron. DropPath is bit different.

# Introduction to DropPath


 

