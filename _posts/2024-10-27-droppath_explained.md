---
title: 'DropPath'
date: 2024-10-27
permalink: /posts/2024/10/droppath_explained/
---

  
  When i was working at my project, i had to dug deep into `transformers` code base and  when i was deep into Swin Transformer territorry, I noticed some thing fishy. 

  Here's the code block that got me interested at first. 

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

Thanks to the VSCode tool that i was using, it showed me that the `drop_path` argument in the constructor was unused. Strange isnt it! I verified the original authors code and found that original swin transformer repo had a stocastic depth decay rule for `droppath` probability while in transformers repository the probability was constant and was picked from the config file. 

I opened up a [pull request](https://github.com/huggingface/transformers/pull/34291/) in transformers repository mentioning the same. 

But, at that moment i realised that i didnt have a proper understanding of what exactly is the drop path? I was well versed with the dropout! Droppath?? nuh. Funny thing that i had used the layer many times when i was writing [Vformer](https://abhi-glitchhg.github.io/projects/vformer). I felt bad. I decided to properly understand the layer and hence this blogpost. 

