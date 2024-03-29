#! /usr/bin/env bash

cd ../.. > /dev/null

# grid-search for hyper-parameters in language model
CUDA_VISIBLE_DEVICES=0,1,2,3 \
python -u tools/tune.py \
--num_batches=-1 \
--batch_size=5 \
--beam_size=500 \
--num_proc_bsearch=12 \
--num_conv_layers=2 \
--num_rnn_layers=3 \
--rnn_layer_size=1024 \
--num_alphas=45 \
--num_betas=8 \
--alpha_from=1.0 \
--alpha_to=3.2 \
--beta_from=0.1 \
--beta_to=0.45 \
--cutoff_prob=1.0 \
--cutoff_top_n=40 \
--use_gru=True \
--use_gpu=True \
--share_rnn_weights=True \
--tune_manifest='data/mpmg/manifest.val2' \
--mean_std_path='data/mpmg/mean_std.npz' \
--vocab_path='data/mpmg/vocab.txt' \
--model_path='checkpoints/gru2/step_final' \
--lang_model_path='models/lm/common_crawl_00.prune01111.trie.klm' \
--error_rate_type='wer' \
--specgram_type='linear'

if [ $? -ne 0 ]; then
    echo "Failed in tuning!"
    exit 1
fi


exit 0
