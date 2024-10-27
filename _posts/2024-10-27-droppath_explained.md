---
title: 'DropPath'
date: 2024-10-27
permalink: :/posts/2024/10/droppath_explained/
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

Thanks to the VSCode tool that i was using, it showed me that the `drop_path` argument in the constructor was unused. Strange isnt it! 
