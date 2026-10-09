$env:PYTHONIOENCODING="utf-8"
$env:LAB_DATA = "D:\vin\phase2\LAB7\K4-Track4-Day22-Tracking-Student\data_lab21"

$python = "D:\annaconda\envs\cv_robotics_lab21\python.exe"
$script = "scripts/run_tracking.py"

Write-Host "Running video_1..."
& $python $script --source "$env:LAB_DATA/video_1/img1" --seq-name video_1 --tracker bytetrack --conf 0.3 --iou 0.5 --out runs/nop_bai --device cpu

Write-Host "Running video_2..."
& $python $script --source "$env:LAB_DATA/video_2/img1" --seq-name video_2 --tracker strongsort --conf 0.2 --iou 0.5 --out runs/nop_bai --device cpu

Write-Host "Running video_3..."
& $python $script --source "$env:LAB_DATA/video_3/img1" --seq-name video_3 --tracker deepocsort --conf 0.25 --iou 0.5 --out runs/nop_bai --device cpu

Write-Host "Running video_4..."
& $python $script --source "$env:LAB_DATA/video_4/img1" --seq-name video_4 --tracker botsort --conf 0.3 --iou 0.5 --out runs/nop_bai --device cpu

Write-Host "Running video_5..."
& $python $script --source "$env:LAB_DATA/video_5/img1" --seq-name video_5 --tracker strongsort --conf 0.25 --iou 0.4 --out runs/nop_bai --device cpu

Write-Host "Evaluating video_1..."
& $python scripts/evaluate_practice.py --trackeval-root .\TrackEval --lab-data-root "$env:LAB_DATA" --submission runs/nop_bai/video_1.txt --run-name nop_bai_v1 > runs/nop_bai/eval_video_1.txt

