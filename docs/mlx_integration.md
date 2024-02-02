# Apple MLX Integration

You can use [Apple MLX](https://github.com/ml-explore/mlx) as an optimized worker implementation in StartChat.

It runs models efficiently on Apple Silicon

See the supported models [here](https://github.com/ml-explore/mlx-examples/tree/main/llms#supported-models).

Note that for Apple Silicon Macs with less memory, smaller models (or quantized models) are recommended.

## Instructions

1. Install MLX.

   ```
   pip install mlx-lm
   ```

2. When you launch a model worker, replace the normal worker (`startchat.serve.model_worker`) with the MLX worker (`startchat.serve.mlx_worker`).

   ```
   python3 -m startchat.serve.mlx_worker --model-path microsoft/phi-2
   ```
