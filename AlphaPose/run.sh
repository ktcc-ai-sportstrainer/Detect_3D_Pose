#!/bin/bash

# AlphaPose設定
CONFIG="AlphaPose/configs/halpe_26/resnet/256x192_res50_lr1e-3_1x.yaml"
CHECKPOINT="AlphaPose/pretrained_models/halpe26_fast_res50_256x192.pth"
DEFAULT_GPU="0"
VIS_MODE="vis_fast"

# 入力動画の設定
VIDEO_DIR="./input"  # 動画があるディレクトリ
VIDEO_NAME="sample.mp4"       # 処理したい動画ファイル名
VIDEO_PATH="${VIDEO_DIR}/${VIDEO_NAME}"

# 出力ディレクトリの設定
OUTPUT_DIR="outputs/$(basename "$VIDEO_NAME" | sed 's/\.[^.]*$//')"
mkdir -p "$OUTPUT_DIR"

# 実行前チェック
if [ ! -f "$VIDEO_PATH" ]; then
    echo "❌ エラー: 動画ファイルが見つかりません: $VIDEO_PATH"
    exit 1
fi

# GPU設定と実行
echo "🚀 処理を開始します..."
echo "📹 処理対象: $VIDEO_NAME"

CUDA_VISIBLE_DEVICES=$DEFAULT_GPU python scripts/demo_inference.py \
    --cfg $CONFIG \
    --checkpoint $CHECKPOINT \
    --video "$VIDEO_PATH" \
    --outdir "$OUTPUT_DIR" \
    --detector yolo \
    --save_video \
    --detbatch 4\
    --$VIS_MODE \
    --gpus $DEFAULT_GPU \
    --format open \
    --sp \
    --qsize 512\

echo "✨ 完了: $OUTPUT_DIR"